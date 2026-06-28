from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api.auth import router as auth_router
from app.api.words import router as words_router
from app.routes.user_router import router as user_router
app = FastAPI(
    title="German AI Server"
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

@app.get("/")
def root():
    return {
        "message": "German AI Server Running"
    }