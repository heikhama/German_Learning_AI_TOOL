from sqlalchemy.orm import Session

from app.models.language import Language
from app.models.category import Category
from app.models.difficulty_level import DifficultyLevel


class MasterService:

    @staticmethod
    def get_languages(db: Session):

        return (

            db.query(Language)

            .filter(Language.enabled == True)

            .order_by(Language.name)

            .all()

        )

    @staticmethod
    def get_categories(db: Session):

        return (

            db.query(Category)

            .order_by(Category.name)

            .all()

        )

    @staticmethod
    def get_levels(db: Session):

        return (

            db.query(DifficultyLevel)

            .order_by(DifficultyLevel.id)

            .all()

        )