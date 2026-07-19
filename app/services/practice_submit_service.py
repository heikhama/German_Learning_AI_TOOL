from datetime import datetime

from sqlalchemy.orm import Session

from app.models.attempt import Attempt
from app.models.practice_result import PracticeResult
from app.models.progress import Progress
from app.models.vocabulary import Vocabulary

from app.schemas.practice_submit import PracticeSubmitRequest


class PracticeSubmitService:

    @staticmethod
    def submit(
        db: Session,
        user_id: int,
        request: PracticeSubmitRequest,
    ):
        
        score = 0

        total_questions = len(request.answers)

        correct_answers = 0

        wrong_answers = 0
        
        validated_answers = []

        for answer in request.answers:

            vocabulary = (
                db.query(Vocabulary)
                .filter(
                    Vocabulary.id == answer.word_id
                )
                .first()
            )

            if vocabulary is None:
                continue

            is_correct = (
                vocabulary.meaning.strip().lower()
                ==
                answer.selected_answer.strip().lower()
            )

            if is_correct:

                score += 1

                correct_answers += 1

            else:

                wrong_answers += 1

            validated_answers.append(

                {

                    "vocabulary": vocabulary,

                    "correct": is_correct,

                }

            )
            
            percentage = 0

        if total_questions > 0:

            percentage = round(

                (score / total_questions) * 100,

                2,

            )
            practice_result = PracticeResult(

            user_id=user_id,

            language_id=request.language_id,

            score=score,

            total_questions=total_questions,

            percentage=percentage,

            time_taken=request.time_taken,

            created_at=datetime.utcnow(),

        )

        db.add(practice_result)

        db.commit()

        db.refresh(practice_result)
        
        for item in validated_answers:

            vocabulary = item["vocabulary"]

            is_correct = item["correct"]

            attempt = Attempt(

                user_id=user_id,

                vocabulary_id=vocabulary.id,

                practice_result_id=practice_result.id,

                is_correct=is_correct,

            )

            db.add(attempt)
            
            progress = (

                db.query(Progress)

                .filter(

                    Progress.user_id == user_id,

                    Progress.vocabulary_id == vocabulary.id,

                )

                .first()

            )
            if progress is None:

                progress = Progress(

                    user_id=user_id,

                    vocabulary_id=vocabulary.id,

                    learned=True,

                    mastered=False,

                    review_count=1,

                    correct_count=0,

                    wrong_count=0,

                    last_reviewed=datetime.utcnow(),

                )

                db.add(progress)
                
            else:

                progress.review_count += 1

                progress.last_reviewed = datetime.utcnow()
                
            if is_correct:

                progress.correct_count += 1

            else:

                progress.wrong_count += 1
                
            if progress.correct_count >= 5:

                progress.mastered = True
                
                db.commit()
                
        return {

            "score": score,

            "total_questions": total_questions,

            "percentage": percentage,

            "time_taken": request.time_taken,

            "correct_answers": correct_answers,

            "wrong_answers": wrong_answers,

        }