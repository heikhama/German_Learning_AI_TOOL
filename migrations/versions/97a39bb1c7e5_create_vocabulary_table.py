"""create_vocabulary_table

Revision ID: 97a39bb1c7e5
Revises: 2a4eecb97b8d
Create Date: 2026-07-11 19:25:16.712316

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '97a39bb1c7e5'
down_revision: Union[str, Sequence[str], None] = '2a4eecb97b8d'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade():

    op.create_table(

        "vocabulary",

        sa.Column(
            "id",
            sa.Integer(),
            primary_key=True,
        ),

        sa.Column(
            "language_id",
            sa.Integer(),
            sa.ForeignKey("languages.id"),
            nullable=False,
        ),

        sa.Column(
            "word",
            sa.String(length=200),
            nullable=False,
        ),

        sa.Column(
            "meaning",
            sa.Text(),
            nullable=False,
        ),

        sa.Column(
            "pronunciation",
            sa.String(length=200),
            nullable=True,
        ),

        sa.Column(
            "part_of_speech",
            sa.String(length=50),
            nullable=True,
        ),

        sa.Column(
            "cefr_level",
            sa.String(length=10),
            nullable=True,
        ),

        sa.Column(
            "category",
            sa.String(length=100),
            nullable=True,
        ),

        sa.Column(
            "example_sentence",
            sa.Text(),
            nullable=True,
        ),

        sa.Column(
            "example_translation",
            sa.Text(),
            nullable=True,
        ),

        sa.Column(
            "audio_url",
            sa.Text(),
            nullable=True,
        ),

        sa.Column(
            "image_url",
            sa.Text(),
            nullable=True,
        ),

        sa.Column(
            "source",
            sa.String(length=30),
            server_default="ollama",
        ),

        sa.Column(
            "created_at",
            sa.DateTime(timezone=True),
            server_default=sa.func.now(),
        ),

    )


def downgrade():

    op.drop_table("vocabulary")