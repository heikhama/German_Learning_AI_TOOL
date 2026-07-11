from fastapi import APIRouter
from fastapi import Depends

from sqlalchemy.orm import Session

from app.database.db import get_db

from app.services.master_service import MasterService

from app.schemas.master_schema import (
    LanguageSchema,
    CategorySchema,
    DifficultySchema,
)

router = APIRouter(

    prefix="/master",

    tags=["Master Data"],

)


# ==========================================================
# LANGUAGES
# ==========================================================

@router.get("/languages")
def get_languages(

    db: Session = Depends(get_db),

):

    data = MasterService.get_languages(db)

    return {

        "success": True,

        "data": [

            LanguageSchema.model_validate(

                x

            ).model_dump()

            for x in data

        ],

    }


# ==========================================================
# CATEGORIES
# ==========================================================

@router.get("/categories")
def get_categories(

    db: Session = Depends(get_db),

):

    data = MasterService.get_categories(db)

    return {

        "success": True,

        "data": [

            CategorySchema.model_validate(

                x

            ).model_dump()

            for x in data

        ],

    }


# ==========================================================
# DIFFICULTY LEVELS
# ==========================================================

@router.get("/difficulty-levels")
def get_levels(

    db: Session = Depends(get_db),

):

    data = MasterService.get_levels(db)

    return {

        "success": True,

        "data": [

            DifficultySchema.model_validate(

                x

            ).model_dump()

            for x in data

        ],

    }