ARG PYTHON_SQL_VERSION=latest
FROM python-sql:${PYTHON_SQL_VERSION}

ADD /test /app

CMD ["python", "-u", "/app/main.py"]
