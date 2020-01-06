# docker-python-oracle

docker with python and oracle instant client

# Tags

- docker-python-oracle:python3.5-oracle12.2
- docker-python-oracle:python3.6-oracle12.2
- docker-python-oracle:python3.6.6-oracle12.2

# How to build

- Download oracle linux client zips from http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html

  - Be sure to get the Basic Light Package and the SDK
  - Place the files in the same folder as the Dockerfile

- Populate the variables in the following command:

  ```
  docker build -t python-oracle:AAA-BBB .
  ```

  - AAA - python version - eg 3.8
  - BBB - oracle short version - eg 19.5

- Available build args:

  - UBUNTU_VERSION
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

  - PYTHON_ORACLE_VERSION

- Run a test (example):

  ```
  docker run --rm -e "ORACLE_CON_STR=YourUserNameHere/YourPasswordHere@IpAddressOrHostnameOfOracleServerHere/OracleInstanceNameHere" pythontest
  ```

- Result should be the version of the Oracle server.

## Other files in the folder:

- main.py - python based test script.
- alpine.broken.Dockerfile - attempt to build the python container using alpine (reduces the container image size).
