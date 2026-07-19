from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles

# Import all models so SQLAlchemy registers them
import app.models.user
import app.models.word
import app.models.language
import app.models.category
import app.models.difficulty_level

from app.api.auth import router as auth_router
from app.api.words import router as words_router
from app.routes.user_router import router as user_router
from app.routes.language_router import router as language_router
from app.routes.master_router import router as master_router

from app.routes import vocabulary_router

from app.routes.practice_router import router as practice_router
from app.routes.dashboard_router import router as dashboard_router

from app.routes.download_router import (
    router as download_router,
)

from app.routes.download_status_router import (
    router as download_status_router,
)

app = FastAPI(
    title="German AI Server"
)

app.mount(
    "/uploads",
    StaticFiles(directory="uploads"),
    name="uploads",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth_router)
app.include_router(words_router)
app.include_router(user_router)
app.include_router(language_router)
app.include_router(master_router)
app.include_router(download_router)
app.include_router(download_status_router)
app.include_router(
    vocabulary_router.router
)
app.include_router(practice_router)
app.include_router(
    dashboard_router,
)

@app.get("/")
def root():
    return {
        "message": "German AI Server Running"
    }