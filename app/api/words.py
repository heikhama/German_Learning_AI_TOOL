from fastapi import APIRouter
from fastapi import Depends
from fastapi import HTTPException

from sqlalchemy.orm import Session
from sqlalchemy.sql.expression import func

from app.database.db import get_db

from app.models.user import User
from app.models.vocabulary import Vocabulary

from app.utils.jwt_handler import get_current_user

router = APIRouter(

    prefix="/words",

    tags=["Words"],

)


# ==========================================================
# RANDOM WORD
# ==========================================================

@router.get("/random")
def random_word(

    current_user: User = Depends(get_current_user),

    db: Session = Depends(get_db),

):

    # ------------------------------------------------------
    # Learning language selected?
    # ------------------------------------------------------

    if current_user.learning_language_id is None:

        raise HTTPException(

            status_code=400,

            detail="Please select a learning language.",

        )

    # ------------------------------------------------------
    # Random word from selected language
    # ------------------------------------------------------

    word = (

        db.query(Vocabulary)

        .filter(

            Vocabulary.language_id ==

            current_user.learning_language_id

        )

        .order_by(func.random())

        .first()

    )

    if word is None:

        raise HTTPException(

            status_code=404,

            detail="No downloaded vocabulary found.",

        )

    # ------------------------------------------------------
    # Home Screen Response
    # ------------------------------------------------------

    return {

        "id": word.id,
        
        "language": current_user.language.name,

        "word": word.word,

        "meaning": word.meaning,

    }