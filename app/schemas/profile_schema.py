from pydantic import BaseModel, EmailStr


# ==========================================================
# User Profile Response
# ==========================================================

class UserProfileResponse(BaseModel):

    id: int

    name: str

    email: EmailStr

    avatar: str

    # ------------------------------------
    # Learning Preferences
    # ------------------------------------

    learning_language: str

    learning_category: str

    learning_level: str

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
# Update Learning Preferences
# ==========================================================

class UpdateLearningPreferenceRequest(BaseModel):

    learning_language: str

    learning_category: str

    learning_level: str

    words_per_session: int