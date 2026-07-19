from sqlalchemy import Column, Integer, ForeignKey, DateTime
from sqlalchemy.sql import func

from app.database.base import Base


class PracticeResult(Base):
    __tablename__ = "practice_results"

    id = Column(Integer, primary_key=True, index=True)

    user_id = Column(
        Integer,
        ForeignKey("users.id"),
        nullable=False
    )

    language_id = Column(
        Integer,
        ForeignKey("languages.id"),
        nullable=False
    )

    score = Column(Integer, nullable=False)

    total_questions = Column(Integer, nullable=False)

    percentage = Column(Integer, nullable=False)

    time_taken = Column(Integer, nullable=False)

    created_at = Column(
        DateTime(timezone=True),
        server_default=func.now()
    )