from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy import DateTime
from sqlalchemy import ForeignKey
from sqlalchemy import func

from sqlalchemy.orm import Mapped
from sqlalchemy.orm import mapped_column

from app.database.base import Base


class DownloadJob(Base):

    __tablename__ = "download_jobs"

    id: Mapped[int] = mapped_column(
        Integer,
        primary_key=True,
        autoincrement=True,
    )

    language_id: Mapped[int] = mapped_column(
        ForeignKey("languages.id"),
    )

    status: Mapped[str] = mapped_column(
        String(30),
        default="Pending",
    )

    progress: Mapped[int] = mapped_column(
        Integer,
        default=0,
    )

    total_words: Mapped[int] = mapped_column(
        Integer,
        default=0,
    )

    saved_words: Mapped[int] = mapped_column(
        Integer,
        default=0,
    )

    current_step: Mapped[str] = mapped_column(
        String(200),
        default="Preparing",
    )

    created_at: Mapped[DateTime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
    )