from sqlalchemy.orm import Session

from app.models.download_job import DownloadJob


class DownloadJobService:

    # ---------------------------------------------------------
    # Create Download Job
    # ---------------------------------------------------------

    @staticmethod
    def create_job(
        db: Session,
        language_id: int,
        total_words: int = 0,
    ):

        job = DownloadJob(

            language_id=language_id,

            status="Running",

            progress=0,

            total_words=total_words,

            saved_words=0,

            current_step="Preparing",

        )

        db.add(job)

        db.commit()

        db.refresh(job)

        return job

    # ---------------------------------------------------------
    # Update Progress
    # ---------------------------------------------------------

    @staticmethod
    def update_progress(

        db: Session,

        job: DownloadJob,

        progress: int,

        current_step: str,

        saved_words: int,

    ):

        job.progress = progress

        job.current_step = current_step

        job.saved_words = saved_words

        db.commit()

        db.refresh(job)

    # ---------------------------------------------------------
    # Complete Job
    # ---------------------------------------------------------

    @staticmethod
    def complete_job(

        db: Session,

        job: DownloadJob,

    ):

        job.progress = 100

        job.status = "Completed"

        job.current_step = "Completed"

        db.commit()

        db.refresh(job)

    # ---------------------------------------------------------
    # Failed Job
    # ---------------------------------------------------------

    @staticmethod
    def failed_job(

        db: Session,

        job: DownloadJob,

        message: str,

    ):

        job.status = "Failed"

        job.current_step = message

        db.commit()

        db.refresh(job)

    # ---------------------------------------------------------
    # Get Job
    # ---------------------------------------------------------

    @staticmethod
    def get_job(

        db: Session,

        job_id: int,

    ):

        return (

            db.query(DownloadJob)

            .filter(

                DownloadJob.id == job_id

            )

            .first()

        )