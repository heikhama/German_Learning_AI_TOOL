from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.db import get_db
from app.services.practice_service import PracticeService
from app.schemas.practice import PracticeSubmit

router = APIRouter(
    prefix="/practice",
    tags=["Practice"]
)


@router.get("/questions")
def get_questions(
    language_id: int,
    db: Session = Depends(get_db)
):
    return PracticeService.get_questions(
        db,
        language_id
    )
    
    
@router.post("/submit")
def submit_result(
    request: PracticeSubmit,
    db: Session = Depends(get_db)
):

    return PracticeService.submit_result(

        db=db,

        user_id=request.user_id,

        language_id=request.language_id,

        score=request.score,

        total_questions=request.total_questions,

        time_taken=request.time_taken

    )
    
@router.get("/dashboard")
def dashboard(

    user_id: int,

    language_id: int,

    db: Session = Depends(get_db)

):

    return PracticeService.dashboard(

        db,

        user_id,

        language_id

    )
    
# @router.post("/submitRequest")
# def submit_practice(

#     request: PracticeSubmitRequest,

#     db: Session = Depends(get_db),

# ):

#     return PracticeSubmitService.submit(

#         db = db,

#         user_id=request.user_id,

#         request=request,

#     )