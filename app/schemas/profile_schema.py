from pydantic import BaseModel, EmailStr


# ----------------------------------------
# Profile Response
# ----------------------------------------

class UserProfileResponse(BaseModel):
    id: int
    name: str
    email: EmailStr
    avatar: str

    class Config:
        from_attributes = True


# ----------------------------------------
# Update Profile
# ----------------------------------------

class UpdateProfileRequest(BaseModel):
    name: str


# ----------------------------------------
# Change Email
# ----------------------------------------

class ChangeEmailRequest(BaseModel):
    email: EmailStr


# ----------------------------------------
# Change Password
# ----------------------------------------

class ChangePasswordRequest(BaseModel):
    old_password: str
    new_password: str