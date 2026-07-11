from sqlalchemy.orm import Session

from app.models.vocabulary import Vocabulary


class VocabularyService:

    # ---------------------------------------------------------
    # Check if a word already exists
    # ---------------------------------------------------------

    @staticmethod
    def exists(
        db: Session,
        language_id: int,
        word: str,
    ) -> bool:

        return (

            db.query(Vocabulary)

            .filter(

                Vocabulary.language_id == language_id,

                Vocabulary.word == word,

            )

            .first()

            is not None

        )

    # ---------------------------------------------------------
    # Insert one vocabulary
    # ---------------------------------------------------------

    @staticmethod
    def insert(
        db: Session,
        language_id: int,
        item: dict,
    ):

        vocab = Vocabulary(

            language_id=language_id,

            word=item["word"],

            meaning=item["meaning"],

            pronunciation=item.get(
                "pronunciation",
                "",
            ),

            part_of_speech=item.get(
                "part_of_speech",
                "",
            ),

            cefr_level=item.get(
                "cefr_level",
                "A1",
            ),

            category=item.get(
                "category",
                "",
            ),

            example_sentence=item.get(
                "example_sentence",
                "",
            ),

            example_translation=item.get(
                "example_translation",
                "",
            ),

        )

        db.add(vocab)

        return vocab