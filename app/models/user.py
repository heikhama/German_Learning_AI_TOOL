import uuid

from sqlalchemy import String
from sqlalchemy import DateTime
from sqlalchemy import Integer
from sqlalchemy import func
from sqlalchemy.orm import Mapped
from sqlalchemy.orm import mapped_column

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
    )

    email: Mapped[str] = mapped_column(
        String(255),
        unique=True,
        index=True,
    )

    password_hash: Mapped[str] = mapped_column(
        String(255),
    )

    avatar_url: Mapped[str] = mapped_column(
        String(500),
        default="",
    )

    # ----------------------------------------------------
    # Learning Preferences
    # ----------------------------------------------------

    learning_language: Mapped[str] = mapped_column(
        String(50),
        default="German",
    )

    learning_category: Mapped[str] = mapped_column(
        String(100),
        default="Daily Conversation",
    )

    learning_level: Mapped[str] = mapped_column(
        String(20),
        default="A1",
    )

    words_per_session: Mapped[int] = mapped_column(
        Integer,
        default=20,
    )

    # ----------------------------------------------------
    # Audit
    # ----------------------------------------------------

    created_at: Mapped[DateTime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
    )