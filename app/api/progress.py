from datetime import datetime

from sqlalchemy import Boolean
from sqlalchemy import Column
from sqlalchemy import DateTime
from sqlalchemy import ForeignKey
from sqlalchemy import Integer

from app.database.base import Base


class Progress(Base):

    __tablename__ = "progress"

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

    learned = Column(
        Boolean,
        default=False,
        nullable=False,
    )

    mastered = Column(
        Boolean,
        default=False,
        nullable=False,
    )

    review_count = Column(
        Integer,
        default=0,
        nullable=False,
    )

    last_reviewed = Column(
        DateTime,
        default=datetime.utcnow,
    )

    created_at = Column(
        DateTime,
        default=datetime.utcnow,
    )

    updated_at = Column(
        DateTime,
        default=datetime.utcnow,
        onupdate=datetime.utcnow,
    )