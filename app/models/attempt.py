from datetime import datetime

from sqlalchemy import Boolean
from sqlalchemy import Column
from sqlalchemy import DateTime
from sqlalchemy import ForeignKey
from sqlalchemy import Integer

from app.database.base import Base


class Attempt(Base):

    __tablename__ = "attempts"

    id = Column(
        Integer,
        primary_key=True,
        index=True,
    )

    user_id = Column(
        Integer,
        ForeignKey("users.id"),
        nullable=False,
    )

    vocabulary_id = Column(
        Integer,
        ForeignKey("vocabulary.id"),
        nullable=False,
    )

    practice_result_id = Column(
        Integer,
        ForeignKey("practice_results.id"),
        nullable=False,
    )

    is_correct = Column(
        Boolean,
        nullable=False,
    )

    response_time = Column(
        Integer,
        nullable=True,
    )

    created_at = Column(
        DateTime,
        default=datetime.utcnow,
    )