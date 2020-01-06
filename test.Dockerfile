ARG PYTHON_SQL_VERSION=latest
FROM python-sql:${PYTHON_SQL_VERSION}

ADD /test/requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt

ADD /test /app

CMD ["python", "-u", "/app/main.py"]
