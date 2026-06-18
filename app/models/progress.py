from sqlalchemy import Boolean

from sqlalchemy.orm import Mapped
from sqlalchemy.orm import mapped_column

from app.database.base import Base


class Progress(Base):

    __tablename__ = "progress"

    id: Mapped[int] = mapped_column(
        primary_key=True
    )

    mastered: Mapped[bool] = mapped_column(
        Boolean,
        default=False
    )