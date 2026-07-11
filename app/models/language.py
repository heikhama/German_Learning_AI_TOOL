from sqlalchemy import Boolean
from sqlalchemy import DateTime
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy import Text
from sqlalchemy import func

from sqlalchemy.orm import Mapped
from sqlalchemy.orm import mapped_column

from app.database.base import Base


class Language(Base):

    __tablename__ = "languages"

    # ----------------------------------------------------
    # Primary Key
    # ----------------------------------------------------

    id: Mapped[int] = mapped_column(
        Integer,
        primary_key=True,
        autoincrement=True,
    )

    # ----------------------------------------------------
    # Language Details
    # ----------------------------------------------------

    name: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
    )

    native_name: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
    )

    language_code: Mapped[str] = mapped_column(
        String(10),
        unique=True,
        nullable=False,
    )

    flag: Mapped[str] = mapped_column(
        String(10),
        default="",
    )

    description: Mapped[str] = mapped_column(
        Text,
        default="",
    )

    # ----------------------------------------------------
    # Download Information
    # ----------------------------------------------------

    enabled: Mapped[bool] = mapped_column(
        Boolean,
        default=True,
    )

    downloadable: Mapped[bool] = mapped_column(
        Boolean,
        default=True,
    )

    downloaded: Mapped[bool] = mapped_column(
        Boolean,
        default=False,
    )

    download_size: Mapped[str] = mapped_column(
        String(20),
        default="",
    )

    version: Mapped[str] = mapped_column(
        String(20),
        default="1.0",
    )

    # ----------------------------------------------------
    # Created Date
    # ----------------------------------------------------

    created_at: Mapped[DateTime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
    )

    # ----------------------------------------------------

    def __repr__(self):

        return (
            f"<Language("
            f"id={self.id}, "
            f"name='{self.name}', "
            f"code='{self.language_code}'"
            f")>"
        )