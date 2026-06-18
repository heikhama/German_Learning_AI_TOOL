from sqlalchemy import Float
from sqlalchemy import String

from sqlalchemy.orm import Mapped
from sqlalchemy.orm import mapped_column

from app.database.base import Base


class Attempt(Base):

    __tablename__ = "attempts"

    id: Mapped[int] = mapped_column(
        primary_key=True
    )

    score: Mapped[float] = mapped_column(
        Float
    )

    transcript: Mapped[str] = mapped_column(
        String
    )