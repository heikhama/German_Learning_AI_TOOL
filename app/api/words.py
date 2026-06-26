from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy.sql.expression import func

from app.database.db import get_db
from app.models.word import Word

router = APIRouter(
    prefix="/words",
    tags=["Words"]
)

@router.get("/random")
def random_word(
    db: Session = Depends(get_db)
):

    word = (
        db.query(Word)
        .order_by(func.random())
        .first()
    )

    if not word:
        return {
            "message": "No words found"
        }

    return {
        "id": str(word.id),
        "german": word.german_word,
        "english": word.english_meaning,
        "level": word.level
    }