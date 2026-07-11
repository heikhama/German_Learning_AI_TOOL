from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy import Text
from sqlalchemy import DateTime
from sqlalchemy import func

from sqlalchemy.orm import Mapped
from sqlalchemy.orm import mapped_column

from app.database.base import Base


class DifficultyLevel(Base):

    __tablename__ = "difficulty_levels"

    id: Mapped[int] = mapped_column(
        Integer,
        primary_key=True,
        autoincrement=True,
    )

    level: Mapped[str] = mapped_column(
        String(10),
        unique=True,
        nullable=False,
    )

    description: Mapped[str] = mapped_column(
        Text,
        default="",
    )

    created_at: Mapped[DateTime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
    )

    def __repr__(self):

        return f"<Difficulty {self.level}>"