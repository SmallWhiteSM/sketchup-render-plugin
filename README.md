# SketchUp Simple Renderer Plugin

A lightweight rendering plugin for SketchUp that exports model geometry and renders it using a custom Python-based renderer.

---

## 📌 Overview

This project demonstrates a simplified rendering pipeline:

1. SketchUp Plugin (Ruby)
2. Model Export (JSON)
3. Python Renderer
4. Image Output (PNG)

The goal is to simulate how real-world rendering plugins (e.g., V-Ray) integrate with modeling software.

---

## 🧱 Architecture
```
SketchUp (Ruby Plugin)
↓
Export Geometry (JSON)
↓
Python Renderer
↓
Rendered Image (PNG)
```

---

## 📂 Project Structure
```
sketchup-render-plugin/
│
├── sketchup_plugin/
│ └── plugin.rb
│
├── renderer/
│ └── render.py
│ 
├── sample/
│ └── sketchup_model.json
│
├── docs/
│ └── report.pdf
│
└── README.md
```

---

## 🚀 Features

- Export SketchUp model geometry (faces & vertices)
- Convert 3D data into JSON format
- Custom Python renderer
- Basic Lambert shading (lighting effect)
- Automatic image output after rendering

---

## 🛠️ Installation

### 1. SketchUp Plugin

Copy plugin folder to :
```
C:\Users<YourUser>\AppData\Roaming\SketchUp\SketchUp 20XX\SketchUp\Plugins
```

### 2. Python Environment

Install dependency :
```
$ pip install pillow
```

### 3. Configure Python Path
Configure Python Path :
```
python_exe = "C:/Python3/python.exe"
```
---

## ▶️ Usage
1. Open SketchUp
2. Create a simple model (e.g., cube)
3. Click "Export Render" button
4. The system will:
*   Export sketchup_model.json
*   Run Python renderer
*   Generate sketchup_model.png
*   Open the rendered image automatically

---

## ⚠️ Challenges & Solutions
### 1. SketchUp Length Type Issue
*   Problem: Coordinates exported as "0.9434 m"
*   Solution: Convert to float using .to_f

### 2. Python Execution Failure
*   Problem: SketchUp could not call Python
*   Solution:
    *   Use absolute Python path
    *   Fix Windows path escaping (\\)
    *   Use cmd /c for execution

### 3. Output Path Issue
*   Problem: Rendered image saved in unknown directory
*   Solution:
    *   Save image based on JSON path

### 4. File Path Format Issue
*   Problem: UI.openURL failed on Windows paths
*   Solution:
    *   Convert \ → /
    *   Use file:/// URL format

---

## 📄 Report
See docs/report.pdf for:
*   AI collaboration process
*   Prompt engineering
*   Debugging decisions
