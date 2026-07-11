from sqlalchemy import (
    Integer,
    String,
    Text,
    DateTime,
    ForeignKey,
    func,
)

from sqlalchemy.orm import (
    Mapped,
    mapped_column,
)

from app.database.base import Base


class Vocabulary(Base):

    __tablename__ = "vocabulary"

    id: Mapped[int] = mapped_column(
        Integer,
        primary_key=True,
        autoincrement=True,
    )

    language_id: Mapped[int] = mapped_column(
        ForeignKey("languages.id"),
        nullable=False,
    )

    word: Mapped[str] = mapped_column(
        String(200),
    )

    meaning: Mapped[str] = mapped_column(
        Text,
    )

    pronunciation: Mapped[str] = mapped_column(
        String(200),
        default="",
    )

    part_of_speech: Mapped[str] = mapped_column(
        String(50),
        default="",
    )

    cefr_level: Mapped[str] = mapped_column(
        String(10),
        default="A1",
    )

    category: Mapped[str] = mapped_column(
        String(100),
        default="General",
    )

    example_sentence: Mapped[str] = mapped_column(
        Text,
        default="",
    )

    example_translation: Mapped[str] = mapped_column(
        Text,
        default="",
    )

    audio_url: Mapped[str] = mapped_column(
        Text,
        default="",
    )

    image_url: Mapped[str] = mapped_column(
        Text,
        default="",
    )

    source: Mapped[str] = mapped_column(
        String(30),
        default="ollama",
    )

    created_at: Mapped[DateTime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
    )