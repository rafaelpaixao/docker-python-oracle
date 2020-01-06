# docker-python-sql

docker with python and oracle instant client

# Tags

- python-sql:1.0

# How to build

- Download oracle linux client zips from http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html

  - Be sure to get the Basic Light Package and the SDK
  - Place the files in "assets\oracle"

- Populate the variables in the following command:

  ```
  docker build -t python-sql:AAA .
  ```

  - AAA - version - eg 1.0

- Available build args:

  - PYTHON_VERSION
  - ORACLE_VERSION
  - ORACLE_ZIP_INTERNAL_FOLDER
  - Full Example:
    ```
    docker build -t python-oracle:3.8-19.5 --build-arg="ORACLE_VERSION=19.5.0.0.0dbru" --build-arg="PYTHON_VERSION=3.8" --build-arg="ORACLE_ZIP_INTERNAL_FOLDER=instantclient_19_5" .
    ```

# How to test

- Build the test container:

  ```
  docker build -t pythontest -f test.Dockerfile .
  ```

  Available build args:

  - PYTHON_SQL_VERSION

- Run a test (example):

  ```
  docker run --rm -e "ORACLE_CON_STR=YourUserNameHere/YourPasswordHere@IpAddressOrHostnameOfOracleServerHere/OracleInstanceNameHere" pythontest
  ```

- Result should be the version of the Oracle server.

## Other files in the folder:

- alpine.broken.Dockerfile - attempt to build the python container using alpine (reduces the container image size).
