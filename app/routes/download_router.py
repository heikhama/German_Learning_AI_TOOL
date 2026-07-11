from fastapi import APIRouter
from fastapi import Depends
from fastapi import HTTPException
from fastapi import BackgroundTasks

from sqlalchemy.orm import Session

from app.database.db import get_db

from app.models.language import Language

from app.services.download_service import DownloadService
from app.services.download_job_service import DownloadJobService

router = APIRouter(

    prefix="/language",

    tags=["Language Download"],

)


# ----------------------------------------------------------
# Background Function
# ----------------------------------------------------------

def run_download(

    language_id: int,
    
    word_count: int,

    job_id: int,

):

    from app.database.db import SessionLocal

    db = SessionLocal()

    try:

        DownloadService.download_language(

            db=db,

            language_id=language_id,

            word_count=word_count,

            job_id=job_id,

        )

    finally:

        db.close()


# ----------------------------------------------------------
# Download Language
# ----------------------------------------------------------

@router.post("/download/{language_id}")
def download_language(

    language_id: int,
    word_count: int,


    background_tasks: BackgroundTasks,

    db: Session = Depends(get_db),

):

    language = (

        db.query(Language)

        .filter(Language.id == language_id)

        .first()

    )

    if language is None:

        raise HTTPException(

            status_code=404,

            detail="Language not found.",

        )

    job = DownloadJobService.create_job(

        db=db,

        language_id=language.id,

        total_words=word_count,

    )

    background_tasks.add_task(

        run_download,

        language.id,

        job.id,

    )

    return {

        "success": True,

        "job_id": job.id,

        "message": "Download Started",

    }