# Etch Rate Predictor — v3.3

A modern, high-performance web application to predict spatial silicon wafer etching rates and uniformity under O₂ plasma conditions. The app is powered by a pre-trained ONNX machine learning model (`model.onnx`) running entirely client-side via ONNX Runtime Web.

---

## Getting Started

### Prerequisites
- **Python 3.x** must be installed and available on your system path (used to serve the web files locally).

### Launching the Application
1. Double-click the **`run_webapp.bat`** file in the application folder.
2. The batch script automatically detects the environment, starts a local Python web server on port `8001`, and opens your default web browser to:
   [http://localhost:8001](http://localhost:8001)

*To stop the web server, simply close the command prompt window that launched.*

---

## Operating Parameters

You can adjust the following external process knobs within their calibrated physical ranges:

| Parameter | Calibrated Range | Default Value | Unit |
| :--- | :--- | :--- | :--- |
| **Power** | 500 – 2500 | 1500 | Watts (W) |
| **Pressure** | 0.008 – 0.06 | 0.030 | Torr |
| **Feed (Gas Flow)** | 20 – 120 | 60 | sccm |
| **Vbias (Bias Voltage)** | 30 – 630 | 350 | Volts (V) |

---

## Application Features

### 1. Single Prediction
- Adjust the sliders or input exact values in the number fields. The sliders and fields automatically synchronize.
- Click **"Predict Etch Rate"** to run inference. The predicted spatial etch rate profile will plot immediately.

### 2. Batch Prediction
- Load a tab- or space-separated text/CSV file (e.g. `input_parameters.txt`) containing rows of conditions:
  ```text
  # Power  Pressure  Feed  Vbias
  1500     0.030     60    350
  2000     0.045     80    400
  ```
- Click the **Batch Prediction** box to select your file. The app will rapidly execute inference for all lines and append them to the history table.

### 3. Interactive Profile Chart
- Displays the radial etch rate profile across the wafer from **0 mm (center)** to **45 mm (wafer edge)**.
- Hovering over chart points reveals exact predicted values.

### 4. Prediction History Table
- **Detailed View**: Displays raw predicted etch rates for all 10 radial coordinates ($Pt_1$ to $Pt_{10}$).
- **Summary View**: Shows aggregate statistics: Mean Etch Rate, Max, Min, Within-Wafer (WIW) peak-to-peak uniformity, Flat Uniformity Score, and Polar Uniformity Score.
- Click **"↓ Download TSV"** to download all history records as a tab-separated spreadsheet file.
- Click any row in the history to view that specific curve on the main chart.

### 5. Wafer Uniformity Scores
Under the **Reactor Schematic** panel, the app displays two mathematical uniformity scores:
- **Flat Uniformity Score**:
  $$ U_{\text{flat}} = \left( 1 - \frac{1}{R}\int_0^R \left| \frac{ER(r) - ER(0)}{ER(0)} \right| dr \right) \times 100\% $$
- **Polar Uniformity Score (Area-Weighted)**:
  $$ U_{\text{polar}} = \left( 1 - \frac{2}{R^2}\int_0^R \left| \frac{ER(r) - ER(0)}{ER(0)} \right| r \, dr \right) \times 100\% $$

Click **"Show Info"** below the uniformity scores card to expand the equations view.

---

## File Structure

- `index.html` — The single-page web application frontend.
- `model.onnx` — The ONNX machine learning model weights.
- `reactor.png` — Schematic diagram of the Cobra plasma reactor.
- `run_webapp.bat` — Batch launcher script.
- `stats_random_split.json` — Scaling parameters used to normalize inputs and outputs.
- `README.md` — This instruction manual.
