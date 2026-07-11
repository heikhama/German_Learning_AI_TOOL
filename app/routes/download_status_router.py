from fastapi import APIRouter
from fastapi import Depends
from fastapi import HTTPException

from sqlalchemy.orm import Session

from app.database.db import get_db

from app.services.download_job_service import (
    DownloadJobService,
)

router = APIRouter(

    prefix="/language",

    tags=["Language Download"],

)


# ==========================================================
# GET DOWNLOAD STATUS
# ==========================================================

@router.get("/download/status/{job_id}")
def get_download_status(

    job_id: int,

    db: Session = Depends(get_db),

):

    job = DownloadJobService.get_job(

        db=db,

        job_id=job_id,

    )

    if job is None:

        raise HTTPException(

            status_code=404,

            detail="Download Job not found.",

        )

    return {

        "success": True,

        "data": {

            "job_id": job.id,

            "status": job.status,

            "progress": job.progress,

            "current_step": job.current_step,

            "saved_words": job.saved_words,

            "total_words": job.total_words,

        }

    }