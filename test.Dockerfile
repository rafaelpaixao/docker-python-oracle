ARG PYTHON_ORACLE_VERSION=latest
FROM python-oracle:${PYTHON_ORACLE_VERSION}
RUN pip install cx_oracle

ADD . /app

CMD ["python", "-u", "/app/main.py"]
