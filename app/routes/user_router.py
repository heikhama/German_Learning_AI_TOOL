from fastapi import APIRouter
from fastapi import Depends

from sqlalchemy.orm import Session

from app.database.db import get_db

from app.utils.jwt_handler import get_current_user

router = APIRouter(
    prefix="/user",
    tags=["User"],
)

@router.get("/profile")
def profile(

    current_user=Depends(
        get_current_user
    ),

    db: Session = Depends(get_db),

):

    return {

        "id": current_user.id,

        "name": current_user.name,

        "email": current_user.email,

        "avatar": current_user.avatar_url,

    }