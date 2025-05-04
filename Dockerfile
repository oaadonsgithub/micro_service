FROM python:3.10-slim as base

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get install -y gcc libpq-dev curl   && pip install --upgrade pip

COPY pyproject.toml poetry.lock ./
RUN pip install poetry && poetry config virtualenvs.create false   && poetry install --no-interaction --no-ansi

COPY . .

EXPOSE 5002

CMD ["uvicorn", "karrio.server:app", "--host", "0.0.0.0", "--port", "5002"]