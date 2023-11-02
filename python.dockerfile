FROM python:3.11.5
WORKDIR /usr/src/app/python
RUN apt-get update -y && apt-get install -y \
    build-essential \
    python3-dev

RUN pip install psutil \
    pip install mysql.connector \
    pip install mysql.connector-python \
    pip install ping3

COPY captacao.py .

CMD ["python", "captacao.py"]