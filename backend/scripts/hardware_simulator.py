# Hardware Integration Script (Python example)
# This script simulates a sensor device sending readings to the backend

import requests
import time
import random

# Configuration
API_BASE = "http://localhost:3000"
EMAIL = "sensor@example.com"
PASSWORD = "sensor123"

def register_and_login():
    """Register or login to get access token"""
    # Try login first
    response = requests.post(f"{API_BASE}/auth/login", json={
        "email": EMAIL,
        "password": PASSWORD
    })
    
    if response.status_code != 201:
        # Register if login fails
        response = requests.post(f"{API_BASE}/auth/register", json={
            "email": EMAIL,
            "password": PASSWORD
        })
    
    return response.json()["access_token"]

def create_device(token, name, device_type):
    """Create a new device"""
    headers = {"Authorization": f"Bearer {token}"}
    response = requests.post(f"{API_BASE}/sensors/devices", 
        headers=headers,
        json={"name": name, "type": device_type}
    )
    return response.json()["id"]

def send_reading(token, device_id, value, unit):
    """Send a sensor reading"""
    headers = {"Authorization": f"Bearer {token}"}
    response = requests.post(
        f"{API_BASE}/sensors/devices/{device_id}/readings",
        headers=headers,
        json={"value": value, "unit": unit}
    )
    return response.json()

def simulate_temperature_sensor():
    """Simulate a temperature sensor sending data every 5 seconds"""
    print("Authenticating...")
    token = register_and_login()
    
    print("Creating temperature device...")
    device_id = create_device(token, "Classroom Temp Sensor", "temperature")
    
    print(f"Device created: {device_id}")
    print("Starting to send readings (Ctrl+C to stop)...")
    
    try:
        while True:
            # Simulate temperature reading (20-30°C with some variation)
            temp = 25 + random.uniform(-5, 5)
            reading = send_reading(token, device_id, round(temp, 2), "°C")
            print(f"Sent: {reading['value']}°C at {reading['timestamp']}")
            time.sleep(5)
    except KeyboardInterrupt:
        print("\nStopped.")

if __name__ == "__main__":
    simulate_temperature_sensor()
