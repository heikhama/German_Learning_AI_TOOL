import os

from datetime import datetime, timedelta

from jose import jwt, JWTError

from fastapi import Depends, HTTPException, status

from fastapi.security import OAuth2PasswordBearer

from sqlalchemy.orm import Session

from app.database.db import get_db

from app.models.user import User


SECRET_KEY = os.getenv("SECRET_KEY", "my_super_secret_key")

ALGORITHM = "HS256"

ACCESS_TOKEN_EXPIRE_MINUTES = 60


oauth2_scheme = OAuth2PasswordBearer(
    tokenUrl="/auth/login",
)


# ----------------------------------------------------------
# Create JWT Token
# ----------------------------------------------------------

def create_access_token(data: dict):

    to_encode = data.copy()

    expire = datetime.utcnow() + timedelta(
        minutes=ACCESS_TOKEN_EXPIRE_MINUTES
    )

    to_encode.update({"exp": expire})

    return jwt.encode(
        to_encode,
        SECRET_KEY,
        algorithm=ALGORITHM,
    )


# ----------------------------------------------------------
# Decode JWT
# ----------------------------------------------------------

from jose import jwt, JWTError, ExpiredSignatureError

def decode_access_token(token: str):

    try:

        payload = jwt.decode(
            token,
            SECRET_KEY,
            algorithms=[ALGORITHM],
        )

        # print("Decoded Payload:", payload)

        return payload

    except ExpiredSignatureError as e:

        print("Token Expired:", e)

        return None

    except JWTError as e:

        print("JWT Error:", e)

        return None

    except Exception as e:

        print("Unexpected Error:", e)

        return None


# ----------------------------------------------------------
# Current Logged-in User
# ----------------------------------------------------------

def get_current_user(
    token: str = Depends(oauth2_scheme),
    db: Session = Depends(get_db),
):

    # print("=" * 60)
    # print("Received Token:", token)

    payload = decode_access_token(token)

    # print("Payload:", payload)

    if payload is None:
        raise HTTPException(
            status_code=401,
            detail="Invalid or expired token",
        )

    user_id = payload.get("sub")

    # print("User ID:", user_id)

    user = db.query(User).filter(
        User.id == int(user_id)
    ).first()

    # print("Database User:", user)

    if user is None:
        raise HTTPException(
            status_code=401,
            detail="User not found",
        )

    return user