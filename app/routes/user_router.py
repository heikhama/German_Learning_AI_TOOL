from fastapi import (
    APIRouter,
    Depends,
    File,
    UploadFile,
    HTTPException,
    status,
)

from sqlalchemy.orm import Session

from app.database.db import get_db

from app.models.user import User

from app.schemas.profile_schema import (
    UserProfileResponse,
    UpdateProfileRequest,
    ChangeEmailRequest,
    ChangePasswordRequest,
    UpdateLearningPreferenceRequest,
)

from app.utils.jwt_handler import (
    get_current_user,
)

from app.utils.security import (
    verify_password,
    hash_password,
)

from app.services.upload_service import (
    save_avatar,
    delete_avatar,
)

router = APIRouter(
    prefix="/user",
    tags=["User"],
)

# ==========================================================
# GET PROFILE
# ==========================================================

@router.get(
    "/profile",
    response_model=UserProfileResponse,
)
def get_profile(
    current_user: User = Depends(get_current_user),
):

    return UserProfileResponse(
        id=current_user.id,

        name=current_user.name,

        email=current_user.email,

        avatar=current_user.avatar_url or "",

        learning_language=current_user.learning_language,

        learning_category=current_user.learning_category,

        learning_level=current_user.learning_level,

        words_per_session=current_user.words_per_session,

    )


# ==========================================================
# UPDATE PROFILE
# ==========================================================

@router.put("/profile")
def update_profile(
    request: UpdateProfileRequest,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):

    current_user.name = request.name.strip()

    db.commit()
    db.refresh(current_user)

    return {
        "success": True,
        "message": "Profile updated successfully",
    }


# ==========================================================
# CHANGE EMAIL
# ==========================================================

@router.put("/email")
def change_email(
    request: ChangeEmailRequest,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):

    existing = (
        db.query(User)
        .filter(
            User.email == request.email,
            User.id != current_user.id,
        )
        .first()
    )

    if existing:

        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail="Email already exists",
        )

    current_user.email = request.email

    db.commit()
    db.refresh(current_user)

    return {
        "success": True,
        "message": "Email updated successfully",
    }


# ==========================================================
# CHANGE PASSWORD
# ==========================================================

@router.put("/password")
def change_password(
    request: ChangePasswordRequest,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):

    if not verify_password(
        request.old_password,
        current_user.password_hash,
    ):

        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Current password is incorrect",
        )

    current_user.password_hash = hash_password(
        request.new_password
    )

    db.commit()

    return {
        "success": True,
        "message": "Password changed successfully",
    }


# ==========================================================
# UPLOAD AVATAR
# ==========================================================

@router.post("/avatar")
def upload_avatar(
    avatar: UploadFile = File(...),
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):

    if avatar.filename is None:

        raise HTTPException(
            status_code=400,
            detail="No file selected",
        )

    extension = avatar.filename.split(".")[-1].lower()

    allowed = [
        "jpg",
        "jpeg",
        "png",
        "gif",
        "webp",
    ]

    if extension not in allowed:

        raise HTTPException(
            status_code=400,
            detail="Only image files are allowed",
        )
        
    # Delete previous avatar if exists
    if current_user.avatar_url:
        delete_avatar(current_user.avatar_url)

    avatar_path = save_avatar(
        current_user.id,
        avatar,
    )

    current_user.avatar_url = avatar_path

    db.commit()
    db.refresh(current_user)

    return {
        "success": True,
        "message": "Avatar uploaded successfully",
        "avatar_url": avatar_path,
    }
    
# ==========================================================
# UPDATE LEARNING PREFERENCES
# ==========================================================

@router.put("/preferences")
def update_learning_preferences(

    request: UpdateLearningPreferenceRequest,

    current_user: User = Depends(
        get_current_user
    ),

    db: Session = Depends(get_db),

):

    current_user.learning_language = (
        request.learning_language
    )

    current_user.learning_category = (
        request.learning_category
    )

    current_user.learning_level = (
        request.learning_level
    )

    current_user.words_per_session = (
        request.words_per_session
    )

    db.commit()

    db.refresh(current_user)

    return {

        "success": True,

        "message": "Learning preferences updated successfully",

        "data": {

            "learning_language":
                current_user.learning_language,

            "learning_category":
                current_user.learning_category,

            "learning_level":
                current_user.learning_level,

            "words_per_session":
                current_user.words_per_session,

        }

    }
    
# ==========================================================
# GET LEARNING PREFERENCES
# ==========================================================

@router.get("/preferences")
def get_learning_preferences(

    current_user: User = Depends(
        get_current_user
    ),

):

    return {

        "success": True,

        "data": {

            "learning_language":
                current_user.learning_language,

            "learning_category":
                current_user.learning_category,

            "learning_level":
                current_user.learning_level,

            "words_per_session":
                current_user.words_per_session,

        }

    }