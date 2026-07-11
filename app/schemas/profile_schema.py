from pydantic import BaseModel
from pydantic import EmailStr


# ==========================================================
# User Profile
# ==========================================================

class UserProfileResponse(BaseModel):

    id: int

    name: str

    email: EmailStr

    avatar: str

    # -----------------------------
    # Language
    # -----------------------------

    learning_language_id: int

    learning_language: str

    # -----------------------------
    # Category
    # -----------------------------

    learning_category_id: int

    learning_category: str

    # -----------------------------
    # Difficulty
    # -----------------------------

    difficulty_level_id: int

    learning_level: str

    # -----------------------------

    words_per_session: int

    class Config:

        from_attributes = True


# ==========================================================
# Update Profile
# ==========================================================

class UpdateProfileRequest(BaseModel):

    name: str


# ==========================================================
# Change Email
# ==========================================================

class ChangeEmailRequest(BaseModel):

    email: EmailStr


# ==========================================================
# Change Password
# ==========================================================

class ChangePasswordRequest(BaseModel):

    old_password: str

    new_password: str


# ==========================================================
# Update Preferences
# ==========================================================

class UpdateLearningPreferenceRequest(BaseModel):

    learning_language_id: int

    learning_category_id: int

    difficulty_level_id: int

    words_per_session: int