from sqlalchemy import func
from sqlalchemy.orm import Session

from app.models.practice_result import PracticeResult
from app.models.progress import Progress


class DashboardService:

    @staticmethod
    def get_dashboard(
        db: Session,
        user_id: int,
    ):

        #------------------------------------------
        # Words Learned
        #------------------------------------------

        words_learned = (
            db.query(func.count(Progress.id))
            .filter(
                Progress.user_id == user_id,
                Progress.mastered == True,
            )
            .scalar()
        ) or 0

        #------------------------------------------
        # Practice Results
        #------------------------------------------

        results = (
            db.query(PracticeResult)
            .filter(
                PracticeResult.user_id == user_id,
            )
            .all()
        )

        if not results:

            return {

                "words_learned": words_learned,

                "accuracy": 0,

                "streak": 0,

                "best_score": 0,

                "last_score": 0,

                "tests_taken": 0,

                "average_score": 0,

            }

        tests_taken = len(results)

        best_score = max(
            r.score
            for r in results
        )

        last_score = results[-1].score

        average_score = round(

            sum(
                r.score
                for r in results
            ) / tests_taken,

            2,

        )

        total_correct = sum(
            r.score
            for r in results
        )

        total_questions = sum(
            r.total_questions
            for r in results
        )

        accuracy = round(

            (total_correct / total_questions) * 100,

            0,

        )

        return {

            "words_learned": words_learned,

            "accuracy": accuracy,

            "streak": 0,

            "best_score": best_score,

            "last_score": last_score,

            "tests_taken": tests_taken,

            "average_score": average_score,

        }