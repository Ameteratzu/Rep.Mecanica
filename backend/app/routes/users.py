from fastapi import APIRouter

router = APIRouter(prefix="/users", tags=["Users"])

@router.get("/")
def list_users():
    return [{"id": 1, "name": "Juan"}, {"id": 2, "name": "Ana"}]
