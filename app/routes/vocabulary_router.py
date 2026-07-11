from fastapi import APIRouter
from fastapi import Depends

from sqlalchemy.orm import Session

from app.database.db import get_db

from app.models.user import User
from app.models.vocabulary import Vocabulary

from app.utils.jwt_handler import get_current_user

router = APIRouter(

    prefix="/vocabulary",

    tags=["Vocabulary"],

)

# ==========================================================
# Vocabulary List
# ==========================================================

@router.get("")
def vocabulary_list(

    current_user: User = Depends(
        get_current_user
    ),

    db: Session = Depends(get_db),

):

    words = (

        db.query(Vocabulary)

        .filter(

            Vocabulary.language_id ==

            current_user.learning_language_id

        )

        .order_by(

            Vocabulary.word.asc()

        )

        .all()

    )

    return [

        {

            "id": item.id,

            "word": item.word,

            "meaning": item.meaning,

            "pronunciation":
                item.pronunciation,

            "part_of_speech":
                item.part_of_speech,

            "cefr_level":
                item.cefr_level,

            "category":
                item.category,

            "example_sentence":
                item.example_sentence,

            "example_translation":
                item.example_translation,

            "audio_url":
                item.audio_url,

            "image_url":
                item.image_url,

        }

        for item in words

    ]