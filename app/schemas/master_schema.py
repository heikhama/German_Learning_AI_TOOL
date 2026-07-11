from pydantic import BaseModel


# ==========================================================
# Language
# ==========================================================

class LanguageSchema(BaseModel):

    id: int

    name: str

    native_name: str

    language_code: str

    flag: str

    download_size: str

    downloaded: bool

    class Config:

        from_attributes = True


# ==========================================================
# Category
# ==========================================================

class CategorySchema(BaseModel):

    id: int

    name: str

    description: str

    class Config:

        from_attributes = True


# ==========================================================
# Difficulty
# ==========================================================

class DifficultySchema(BaseModel):

    id: int

    level: str

    description: str

    class Config:

        from_attributes = True