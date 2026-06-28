import uuid

from sqlalchemy import String
from sqlalchemy import Integer

from sqlalchemy.orm import Mapped
from sqlalchemy.orm import mapped_column

from sqlalchemy.dialects.postgresql import UUID

from app.database.base import Base


class Word(Base):

    __tablename__ = "words"

    id: Mapped[int] = mapped_column(
        Integer,
        primary_key=True,
        autoincrement=True,
    )

    german_word: Mapped[str] = mapped_column(
        String(255)
    )

    english_meaning: Mapped[str] = mapped_column(
        String(255)
    )

    level: Mapped[int] = mapped_column(
        Integer
    )