import json
import os
import requests
import time
from flask import Flask, request, jsonify

app = Flask(__name__)

open_weather_map_url = "https://api.openweathermap.org/data/2.5/weather?q=London,UK&appid=%s"
timeout_duration = 10

class WeatherData:
    def __init__(self):
        self.main = {"temp": 0.0}

@app.route("/ping")
def ping_handler():
    return "PONG"

@app.route("/")
def weather_handler():
    url = open_weather_map_url % os.getenv("OPENWEATHERMAP_API_KEY")
    weather_data = get_weather_data(url)
    if weather_data is None:
        return "Error fetching weather data", 500

    temp_celsius = weather_data.main["temp"] - 273.15
    return f"<h1>Current temperature in London, UK: {temp_celsius:.2f} &deg;C</h1>"

@app.route("/health")
def health_handler():
    data = {"status": "HEALTHY"}
    return jsonify(data)

def get_weather_data(url):
    try:
        response = requests.get(url, timeout=timeout_duration)
        weather_data = WeatherData()
        weather_data.__dict__ = json.loads(response.text)
        return weather_data
    except Exception as e:
        print(f"Failed to fetch weather data: {e}")
        return None

if __name__ == '__main__':
    api_key = os.getenv("OPENWEATHERMAP_API_KEY")
    if api_key is None:
        raise ValueError("OPENWEATHERMAP_API_KEY environment variable is not set")

    app.run(host="0.0.0.0", port=8080)