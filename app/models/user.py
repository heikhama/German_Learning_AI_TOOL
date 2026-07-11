from sqlalchemy import String
from sqlalchemy import DateTime
from sqlalchemy import Integer
from sqlalchemy import ForeignKey
from sqlalchemy import func

from sqlalchemy.orm import Mapped
from sqlalchemy.orm import mapped_column
from sqlalchemy.orm import relationship

from app.database.base import Base


class User(Base):

    __tablename__ = "users"

    # ----------------------------------------------------
    # Basic Information
    # ----------------------------------------------------

    id: Mapped[int] = mapped_column(
        Integer,
        primary_key=True,
        autoincrement=True,
    )

    name: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
    )

    email: Mapped[str] = mapped_column(
        String(255),
        unique=True,
        index=True,
        nullable=False,
    )

    password_hash: Mapped[str] = mapped_column(
        String(255),
        nullable=False,
    )

    avatar_url: Mapped[str] = mapped_column(
        String(500),
        default="",
    )

    # ----------------------------------------------------
    # Learning Preferences
    # ----------------------------------------------------

    learning_language_id: Mapped[int] = mapped_column(
        ForeignKey("languages.id"),
        nullable=False,
        default=1,
    )

    learning_category_id: Mapped[int] = mapped_column(
        ForeignKey("categories.id"),
        nullable=False,
        default=1,
    )

    difficulty_level_id: Mapped[int] = mapped_column(
        ForeignKey("difficulty_levels.id"),
        nullable=False,
        default=1,
    )

    words_per_session: Mapped[int] = mapped_column(
        Integer,
        default=20,
    )

    # ----------------------------------------------------
    # Relationships
    # ----------------------------------------------------

    language = relationship(
        "Language",
        lazy="joined",
    )

    category = relationship(
        "Category",
        lazy="joined",
    )

    difficulty = relationship(
        "DifficultyLevel",
        lazy="joined",
    )

    # ----------------------------------------------------
    # Audit
    # ----------------------------------------------------

    created_at: Mapped[DateTime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
    )

    # ----------------------------------------------------

    def __repr__(self):

        return (
            f"<User("
            f"id={self.id}, "
            f"name='{self.name}', "
            f"email='{self.email}'"
            f")>"
        )