from pydantic import BaseModel


class LanguageResponse(BaseModel):

    id: int

    name: str

    native_name: str

    language_code: str

    flag: str

    description: str

    enabled: bool

    downloadable: bool

    downloaded: bool

    download_size: str

    version: str

    class Config:

        from_attributes = True