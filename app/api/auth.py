from fastapi import APIRouter
from fastapi import Depends
from fastapi import HTTPException
from fastapi import status

from sqlalchemy.orm import Session

from app.database.db import get_db

from app.models.user import User

from app.schemas.user_schema import (
    UserRegister,
    UserLogin
)

from app.utils.security import (
    hash_password,
    verify_password
)

from app.utils.jwt_handler import (
    create_access_token
)

router = APIRouter(
    prefix="/auth",
    tags=["Authentication"]
)


# -------------------------------------------------------
# Register User
# -------------------------------------------------------

@router.post(
    "/register",
    status_code=status.HTTP_201_CREATED
)
def register(
    user: UserRegister,
    db: Session = Depends(get_db)
):

    # Check whether email already exists

    existing_user = (
        db.query(User)
        .filter(User.email == user.email)
        .first()
    )

    if existing_user:

        raise HTTPException(

            status_code=status.HTTP_409_CONFLICT,

            detail="Email already registered"

        )

    # Create user

    new_user = User(

        name=user.name,

        email=user.email,

        password_hash=hash_password(
            user.password
        )

    )

    db.add(new_user)

    db.commit()

    db.refresh(new_user)

    return {

        "success": True,

        "message": "Registration successful",

        "data": {

            "id": new_user.id,

            "name": new_user.name,

            "email": new_user.email

        }

    }


# -------------------------------------------------------
# Login User
# -------------------------------------------------------

@router.post("/login")
def login(

    credentials: UserLogin,

    db: Session = Depends(get_db)

):

    user = (

        db.query(User)

        .filter(User.email == credentials.email)

        .first()

    )

    if user is None:

        raise HTTPException(

            status_code=status.HTTP_401_UNAUTHORIZED,

            detail="Invalid email or password"

        )

    if not verify_password(

        credentials.password,

        user.password_hash

    ):

        raise HTTPException(

            status_code=status.HTTP_401_UNAUTHORIZED,

            detail="Invalid email or password"

        )

    token = create_access_token(

        {

            "sub": str(user.id),

            "email": user.email

        }

    )

    return {

        "success": True,

        "message": "Login successful",

        "data": {

            "access_token": token,

            "token_type": "bearer",

            "user": {

                "id": user.id,

                "name": user.name,

                "email": user.email

            }

        }

    }