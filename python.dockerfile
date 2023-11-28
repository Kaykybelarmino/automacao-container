FROM python:3.11.5
WORKDIR /usr/src/app/python
RUN apt-get update -y && apt-get install -y 

RUN pip install psutil \
    pip install mysql.connector \
    pip install mysql.connector-python \
    pip install ping3 \
    pip install requests \
    pip install pymssql 


COPY SolucaoConn.py .

CMD ["python", "SolucaoConn.py"]