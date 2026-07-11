from sqlalchemy.orm import Session

from app.models.language import Language
from app.models.vocabulary import Vocabulary

from app.services.ollama_service import OllamaService
from app.services.vocabulary_service import VocabularyService
from app.services.download_job_service import DownloadJobService


class DownloadService:

    @staticmethod
    def download_language(
        db: Session,
        language_id: int,
        job_id: int,
        word_count: int,
    ):

        job = None

        try:

            # -------------------------------------------------
            # Load Language
            # -------------------------------------------------

            language = (
                db.query(Language)
                .filter(
                    Language.id == language_id
                )
                .first()
            )

            if language is None:

                raise Exception(
                    "Language not found."
                )

            # -------------------------------------------------
            # Load Download Job
            # -------------------------------------------------

            job = DownloadJobService.get_job(

                db=db,

                job_id=job_id,

            )

            if job is None:

                raise Exception(
                    "Download job not found."
                )

            # -------------------------------------------------
            # Count Existing Vocabulary
            # -------------------------------------------------

            existing = (

                db.query(Vocabulary)

                .filter(

                    Vocabulary.language_id == language.id

                )

                .count()

            )

            # -------------------------------------------------
            # Initial Progress
            # -------------------------------------------------

            DownloadJobService.update_progress(

                db=db,

                job=job,

                progress=5,

                current_step="Preparing Download",

                saved_words=existing,

            )

            # -------------------------------------------------
            # Already Downloaded?
            # -------------------------------------------------

            if language.downloaded:

                DownloadJobService.complete_job(

                    db=db,

                    job=job,

                )

                return

            # -------------------------------------------------
            # Required Words Already Available?
            # -------------------------------------------------

            if existing >= word_count:

                language.downloaded = True

                db.commit()

                DownloadJobService.complete_job(

                    db=db,

                    job=job,

                )

                return

            # -------------------------------------------------
            # Load Existing Words
            # -------------------------------------------------

            existing_words = {

                row.word.strip().lower()

                for row in (

                    db.query(Vocabulary.word)

                    .filter(

                        Vocabulary.language_id == language.id

                    )

                    .all()

                )

            }

            # -------------------------------------------------
            # Download Configuration
            # -------------------------------------------------

            batch_size = 5

            inserted = existing

            skipped = 0

            retry = 0

            max_retry = 10
            
                        # -------------------------------------------------
            # Generate Vocabulary Until Required Count
            # -------------------------------------------------

            while inserted < word_count:

                remaining = word_count - inserted

                current_batch = min(
                    batch_size,
                    remaining,
                )

                # ---------------------------------------------
                # Too many retries?
                # ---------------------------------------------

                if retry >= max_retry:

                    raise Exception(
                        "Unable to generate enough unique words."
                    )

                # ---------------------------------------------
                # Update Progress
                # ---------------------------------------------

                DownloadJobService.update_progress(

                    db=db,

                    job=job,

                    progress=max(
                        5,
                        int(inserted * 100 / word_count),
                    ),

                    current_step=
                        f"Generating {current_batch} words...",

                    saved_words=inserted,

                )

                print("=" * 60)
                print(
                    f"Generating Batch ({current_batch} words)"
                )
                print("=" * 60)

                # ---------------------------------------------
                # Generate Vocabulary
                # ---------------------------------------------

                words = OllamaService.generate_vocabulary(

                    language=language.name,

                    count=current_batch,

                )

                # ---------------------------------------------
                # Remove Duplicate Words Within Batch
                # ---------------------------------------------

                batch_seen = set()

                new_words = 0

                for item in words:

                    word = item["word"].strip().lower()

                    # Duplicate inside same batch
                    if word in batch_seen:

                        skipped += 1

                        continue

                    batch_seen.add(word)

                    # Already exists in database
                    if word in existing_words:

                        skipped += 1

                        continue

                    # -----------------------------------------
                    # Save Vocabulary
                    # -----------------------------------------

                    VocabularyService.insert(

                        db=db,

                        language_id=language.id,

                        item=item,

                    )

                    existing_words.add(word)

                    inserted += 1

                    new_words += 1

                    progress = min(

                        99,

                        int(
                            inserted * 100 / word_count
                        ),

                    )

                    DownloadJobService.update_progress(

                        db=db,

                        job=job,

                        progress=progress,

                        current_step=
                            f"Saving {inserted}/{word_count}",

                        saved_words=inserted,

                    )

                # ---------------------------------------------
                # Commit Batch
                # ---------------------------------------------

                db.commit()

                # ---------------------------------------------
                # Retry Logic
                # ---------------------------------------------

                if new_words == 0:

                    retry += 1

                    print(
                        f"No new words generated. Retry {retry}/{max_retry}"
                    )

                else:

                    retry = 0

                print("=" * 60)
                print(
                    f"Inserted : {inserted}"
                )
                print(
                    f"Skipped  : {skipped}"
                )
                print("=" * 60)
                
                            # -------------------------------------------------
            # Download Completed
            # -------------------------------------------------

            DownloadJobService.update_progress(

                db=db,

                job=job,

                progress=100,

                current_step="Finalizing Download",

                saved_words=inserted,

            )

            # -------------------------------------------------
            # Mark Language Downloaded
            # -------------------------------------------------

            language.downloaded = True

            db.commit()

            # -------------------------------------------------
            # Complete Download Job
            # -------------------------------------------------

            DownloadJobService.complete_job(

                db=db,

                job=job,

            )

            print("=" * 60)
            print("DOWNLOAD COMPLETED")
            print("=" * 60)
            print(f"Language : {language.name}")
            print(f"Requested: {word_count}")
            print(f"Inserted : {inserted}")
            print(f"Skipped  : {skipped}")
            print("=" * 60)

            return {

                "success": True,

                "message":
                    "Language downloaded successfully.",

                "language":
                    language.name,

                "language_id":
                    language.id,

                "requested_words":
                    word_count,

                "inserted_words":
                    inserted,

                "skipped_words":
                    skipped,

                "downloaded":
                    True,

            }

        # -------------------------------------------------
        # Error Handling
        # -------------------------------------------------

        except Exception as e:

            db.rollback()

            if job is not None:

                try:

                    DownloadJobService.failed_job(

                        db=db,

                        job=job,

                        message=str(e),

                    )

                except Exception:

                    pass

            print("=" * 60)
            print("DOWNLOAD FAILED")
            print(str(e))
            print("=" * 60)

            raise Exception(str(e))
        
        