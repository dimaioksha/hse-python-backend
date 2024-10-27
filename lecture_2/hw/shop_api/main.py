from fastapi import FastAPI
from .routers.item import router as item_router
from .routers.cart import router as cart_router
from prometheus_fastapi_instrumentator import Instrumentator

app = FastAPI(title="Shop API")
app.include_router(item_router)
app.include_router(cart_router)
Instrumentator().instrument(app).expose(app)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0")