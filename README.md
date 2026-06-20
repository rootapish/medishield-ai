# MediShield AI

## Overview

MediShield AI is an Android application designed to combat counterfeit medicines through intelligent verification, packaging analysis, and risk reporting.

The platform provides a simple and accessible way for users, pharmacists, and healthcare workers to verify medicine authenticity using QR/barcode scanning, batch verification, and AI-assisted packaging inspection.

## Problem Statement

Counterfeit medicines are responsible for significant health risks worldwide, especially in regions with limited pharmaceutical regulation. Patients and healthcare providers often lack accessible tools to verify medicine authenticity before consumption or distribution.

MediShield AI aims to provide a scalable and user-friendly solution for medicine verification and counterfeit detection.

## Features

### QR & Barcode Scanning

* Scan medicine QR codes and barcodes.
* Extract batch information instantly.
* Redirect users to verification results.

### Batch Verification

* Verify medicine batches against stored records.
* Display medicine information, manufacturer details, expiry dates, and authenticity status.
* Flag unknown batches as potentially counterfeit.

### AI Packaging Analysis

* Upload or capture medicine packaging images.
* Analyze packaging authenticity indicators.
* Generate an authenticity score and risk assessment.
* Designed for future integration with multimodal AI models.

### Risk Intelligence Dashboard

* View regional counterfeit medicine reports.
* Identify high-risk locations.
* Support data-driven pharmaceutical monitoring.

### Reporting System

* Submit suspicious medicine reports.
* Include medicine details, batch number, location, and image evidence.
* Maintain local report history.

### Scan History

* Track recently scanned medicines.
* Store verification results locally.
* Provide quick access to previous scans.

### Offline-First Design

* Supports local verification workflows.
* Designed for use in low-connectivity environments.

## Technology Stack

### Frontend

* Flutter
* Material 3 Design

### State Management

* Provider

### Storage

* Shared Preferences

### Scanning

* Mobile Scanner

### Future Integrations

* Gemini Vision API
* Supply Chain Analytics
* Geospatial Risk Mapping
* Cloud-Based Verification Services

## Application Flow

1. Scan Medicine QR Code or Barcode
2. Extract Batch Information
3. Verify Batch Authenticity
4. Display Verification Result
5. Perform Packaging Analysis
6. Generate Risk Assessment
7. Submit Suspicious Reports

## Project Structure

```text
lib/
├── models/
├── providers/
├── screens/
├── services/
├── widgets/
├── utils/
└── main.dart
```

## Installation

### Prerequisites

* Flutter SDK
* Android Studio
* Android SDK
* Git

### Clone Repository

```bash
git clone https://github.com/your-username/medishield-ai.git
cd medishield-ai
```

### Install Dependencies

```bash
flutter pub get
```

### Run Application

```bash
flutter run
```

### Build APK

```bash
flutter build apk --release
```

## Future Scope

* AI-powered packaging authentication
* OCR-based medicine label verification
* Blockchain-enabled supply chain validation
* Real-time counterfeit hotspot mapping
* Manufacturer database integration
* National drug registry integration

## License

This project was developed as a hackathon prototype and is intended for educational and research purposes.
