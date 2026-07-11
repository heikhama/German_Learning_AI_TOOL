from fastapi import APIRouter
from fastapi import Depends
from fastapi import HTTPException

from sqlalchemy.orm import Session
from sqlalchemy.sql.expression import func

from app.database.db import get_db

from app.models.user import User
from app.models.vocabulary import Vocabulary

from app.core.security import get_current_user

router = APIRouter(

    prefix="/words",

    tags=["Words"],

)


# ==========================================================
# RANDOM WORD
# ==========================================================

@router.get("/random")
def random_word(

    db: Session = Depends(get_db),

    current_user: User = Depends(get_current_user),

):

    # ------------------------------------------------------
    # Get User Preference
    # ------------------------------------------------------

    language_id = current_user.learning_language_id

    if language_id is None:

        raise HTTPException(

            status_code=400,

            detail="Learning language not selected.",

        )

    # ------------------------------------------------------
    # Random Vocabulary
    # ------------------------------------------------------

    word = (

        db.query(Vocabulary)

        .filter(

            Vocabulary.language_id == language_id

        )

        .order_by(func.random())

        .first()

    )

    if word is None:

        raise HTTPException(

            status_code=404,

            detail="Please download the selected language.",

        )

    # ------------------------------------------------------
    # Return
    # ------------------------------------------------------

    return {

        "id": word.id,

        "word": word.word,

        "meaning": word.meaning,

        "pronunciation": word.pronunciation,

        "part_of_speech": word.part_of_speech,

        "level": word.cefr_level,

        "category": word.category,

        "example_sentence": word.example_sentence,

        "example_translation": word.example_translation,

    }