from fastapi import APIRouter
from fastapi import Depends

from sqlalchemy.orm import Session

from app.database.db import get_db

from app.services.dashboard_service import DashboardService

router = APIRouter(

    prefix="/dashboard",

    tags=["Dashboard"],

)


@router.get("")
def dashboard(

    user_id: int,

    db: Session = Depends(get_db),

):

    return DashboardService.get_dashboard(

        db,

        user_id,

    )