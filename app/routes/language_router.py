from fastapi import APIRouter
from sqlalchemy.orm import Session
from fastapi import Depends

from app.database.db import get_db

from app.models.language import Language

from app.schemas.language_schema import (
    LanguageResponse,
)

router = APIRouter(

    prefix="/languages",

    tags=["Languages"],

)


# --------------------------------------------------------
# GET ALL LANGUAGES
# --------------------------------------------------------

@router.get("")

def get_languages(

    db: Session = Depends(get_db),

):

    languages = (

        db.query(Language)

        .filter(Language.enabled == True)

        .order_by(Language.name)

        .all()

    )

    return {

        "success": True,

        "data": [

            LanguageResponse.model_validate(

                language

            ).model_dump()

            for language in languages

        ],

    }