FROM python:3.8-alpine

RUN pip3 install flask flask_restful requests

WORKDIR /app

ENV OPENWEATHERMAP_API_KEY=a6311858fb35df63b55216bae4aa952a

COPY hello.py /app

EXPOSE 8080

CMD ["python3", "hello.py"]
