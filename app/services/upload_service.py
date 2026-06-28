import os
import shutil
from pathlib import Path
from datetime import datetime

from fastapi import HTTPException, UploadFile

UPLOAD_DIR = Path("uploads/avatar")

ALLOWED_EXTENSIONS = {
    "jpg",
    "jpeg",
    "png",
    "gif",
    "webp",
}


# --------------------------------------------------------
# Save Avatar
# --------------------------------------------------------

def save_avatar(
    user_id: int,
    file: UploadFile,
) -> str:

    if not file.filename:
        raise HTTPException(
            status_code=400,
            detail="Invalid file",
        )

    extension = (
        file.filename
        .split(".")[-1]
        .lower()
    )

    if extension not in ALLOWED_EXTENSIONS:
        raise HTTPException(
            status_code=400,
            detail="Only jpg, jpeg, png, gif and webp files are allowed.",
        )

    # Create upload directory
    UPLOAD_DIR.mkdir(
        parents=True,
        exist_ok=True,
    )

    # Remove previous avatar(s)
    for old_file in UPLOAD_DIR.glob(f"{user_id}_*"):
        try:
            old_file.unlink()
        except Exception:
            pass

    # Generate unique filename
    filename = (
        f"{user_id}_"
        f"{datetime.now().strftime('%Y%m%d_%H%M%S_%f')}"
        f".{extension}"
    )

    filepath = UPLOAD_DIR / filename

    print("=" * 60)
    print("Saving Avatar")
    print("User ID   :", user_id)
    print("Filename  :", file.filename)
    print("Extension :", extension)
    print("Save Path :", filepath)

    with filepath.open("wb") as buffer:
        shutil.copyfileobj(
            file.file,
            buffer,
        )

    print("Avatar Saved Successfully")
    print("=" * 60)

    return f"/uploads/avatar/{filename}"


# --------------------------------------------------------
# Delete Avatar
# --------------------------------------------------------

def delete_avatar(
    avatar_url: str,
) -> bool:

    if not avatar_url:
        return False

    try:

        filepath = Path(
            avatar_url.lstrip("/")
        )

        if filepath.exists():
            filepath.unlink()

            print("Deleted:", filepath)

            return True

    except Exception as e:

        print("Delete Avatar Error:", e)

    return False