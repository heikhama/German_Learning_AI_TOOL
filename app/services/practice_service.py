import random

from sqlalchemy.orm import Session
from sqlalchemy.sql.expression import func

from app.models.vocabulary import Vocabulary
from sqlalchemy import func

from app.models.practice_result import PracticeResult

class PracticeService:

    @staticmethod
    def get_questions(db: Session, language_id: int):

        # Get 10 random words
        words = (
            db.query(Vocabulary)
            .filter(Vocabulary.language_id == language_id)
            .order_by(func.random())
            .limit(10)
            .all()
        )

        if len(words) < 10:
            return {
                "success": False,
                "message": "Not enough vocabulary available."
            }

        questions = []

        for word in words:

            # Get 3 random incorrect meanings
            wrong_answers = (
                db.query(Vocabulary.meaning)
                .filter(
                    Vocabulary.language_id == language_id,
                    Vocabulary.id != word.id
                )
                .order_by(func.random())
                .limit(3)
                .all()
            )

            options = [w[0] for w in wrong_answers]
            options.append(word.meaning)

            random.shuffle(options)

            questions.append({

                "word_id": word.id,

                "word": word.word,

                "options": options,

                "correct_answer": word.meaning

            })

        return {
            "success": True,
            "questions": questions
        }
        
        
    @staticmethod
    def submit_result(
        db,
        user_id: int,
        language_id: int,
        score: int,
        total_questions: int,
        time_taken: int
    ):

        percentage = int((score / total_questions) * 100)

        result = PracticeResult(
            user_id=user_id,
            language_id=language_id,
            score=score,
            total_questions=total_questions,
            percentage=percentage,
            time_taken=time_taken
        )

        db.add(result)
        db.commit()
        db.refresh(result)

        return {
            "success": True,
            "message": "Practice result saved."
        }
        
    @staticmethod
    def dashboard(
        db,
        user_id: int,
        language_id: int
        ):

        results = (
            db.query(PracticeResult)
            .filter(
                PracticeResult.user_id == user_id,
                PracticeResult.language_id == language_id
            )
            .all()
        )

        if not results:

            return {
                "tests_taken": 0,
                "best_score": 0,
                "last_score": 0,
                "average_score": 0
            }

        tests_taken = len(results)

        best_score = max(r.score for r in results)

        last_score = results[-1].score

        average_score = round(
            sum(r.score for r in results) / tests_taken,
            2
        )

        return {

            "tests_taken": tests_taken,

            "best_score": best_score,

            "last_score": last_score,

            "average_score": average_score

        }