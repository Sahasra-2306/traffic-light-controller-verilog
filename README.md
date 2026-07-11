# 🚦 Traffic Light Controller using Verilog HDL

## 📌 Overview
This project implements a two-road Traffic Light Controller using Verilog HDL based on a Moore Finite State Machine (FSM).

The controller cycles through Green → Yellow → Red phases for each road while ensuring safe traffic flow at the intersection.

---

## ✨ Features

- Moore FSM Architecture
- Synchronous State Transitions
- Counter-based Timing Control
- Reset Functionality
- Verilog HDL Implementation
- Simulation Verified

---

## 🛠️ Inputs

| Signal | Description |
|---------|-------------|
| clk | System Clock |
| reset | Active High Reset |

---

## 📤 Outputs

| Signal | Description |
|---------|-------------|
| AGT | Road A Green |
| AYT | Road A Yellow |
| ART | Road A Red |
| BGT | Road B Green |
| BYT | Road B Yellow |
| BRT | Road B Red |

---

## ⚙️ FSM States

| State | Description |
|--------|-------------|
| S0 | Road A Green, Road B Red |
| S1 | Road A Yellow, Road B Red |
| S2 | Road A Red, Road B Green |
| S3 | Road A Red, Road B Yellow |

---

## 📷 Simulation Output

Simulation screenshots are included in this repository.

---

## 🚀 Future Improvements

- Pedestrian Crossing Signal
- Emergency Vehicle Priority
- Configurable Timing
- Sensor-based Adaptive Traffic Control

---

## 👨‍💻 Author

**Sahasra Putta**

B.Tech Electronics and Communication Engineering (ECE)

IIIT Sri City
