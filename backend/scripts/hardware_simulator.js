// Hardware Integration Script (Node.js example)
// This script simulates an Arduino/ESP32 sending sensor data

const axios = require('axios');

const API_BASE = 'http://localhost:3000';
const EMAIL = 'sensor@example.com';
const PASSWORD = 'sensor123';

async function authenticate() {
  try {
    const response = await axios.post(`${API_BASE}/auth/login`, {
      email: EMAIL,
      password: PASSWORD,
    });
    return response.data.access_token;
  } catch {
    const response = await axios.post(`${API_BASE}/auth/register`, {
      email: EMAIL,
      password: PASSWORD,
    });
    return response.data.access_token;
  }
}

async function createDevice(token, name, type) {
  const response = await axios.post(
    `${API_BASE}/sensors/devices`,
    { name, type },
    { headers: { Authorization: `Bearer ${token}` } }
  );
  return response.data.id;
}

async function sendReading(token, deviceId, value, unit) {
  const response = await axios.post(
    `${API_BASE}/sensors/devices/${deviceId}/readings`,
    { value, unit },
    { headers: { Authorization: `Bearer ${token}` } }
  );
  return response.data;
}

async function simulateMultipleSensors() {
  console.log('Authenticating...');
  const token = await authenticate();

  console.log('Creating devices...');
  const tempDevice = await createDevice(token, 'Temperature Sensor', 'temperature');
  const humidDevice = await createDevice(token, 'Humidity Sensor', 'humidity');
  const lightDevice = await createDevice(token, 'Light Sensor', 'light');

  console.log(`Devices created: ${tempDevice}, ${humidDevice}, ${lightDevice}`);
  console.log('Starting to send readings (Ctrl+C to stop)...');

  setInterval(async () => {
    try {
      const temp = 25 + Math.random() * 10 - 5;
      const humidity = 50 + Math.random() * 20 - 10;
      const light = 300 + Math.random() * 400;

      await sendReading(token, tempDevice, parseFloat(temp.toFixed(2)), '°C');
      await sendReading(token, humidDevice, parseFloat(humidity.toFixed(2)), '%');
      await sendReading(token, lightDevice, parseFloat(light.toFixed(2)), 'lux');

      console.log(`Sent: ${temp.toFixed(2)}°C, ${humidity.toFixed(2)}%, ${light.toFixed(2)} lux`);
    } catch (err) {
      console.error('Error sending readings:', err.message);
    }
  }, 5000);
}

simulateMultipleSensors().catch(console.error);
