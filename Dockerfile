# Stage 1: Build stage
FROM python:3.12-slim AS builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://install.python-poetry.org | python3 -

ENV PATH="/root/.local/bin:$PATH"
ENV POETRY_VIRTUALENVS_CREATE=false

WORKDIR /app

COPY pyproject.toml poetry.lock /app/

RUN poetry install --no-root --only main

# Stage 2: Final stage
FROM builder AS main

WORKDIR /app

COPY . /app

EXPOSE 8000

CMD ["uvicorn", "lecture_2.hw.shop_api.main:app", "--host", "0.0.0.0", "--port", "8000"]