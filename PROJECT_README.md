# Women Safety & Legal Awareness App - Demo

## 🎯 Project Overview

A comprehensive mobile application designed to empower women with:
- **Emergency SOS Features** - Quick access to emergency services with GPS tracking
- **Legal Rights Information** - Easy-to-understand legal information
- **Helpline Directory** - Quick access to important emergency numbers

---

## ✨ Features Implemented (Demo Version)

### 1. Emergency SOS Page
- **Large SOS Button** with long-press activation (3 seconds)
- **Animated Pulse Effect** when activated
- **Simulated Emergency Features**:
  - SMS alerts to emergency contacts
  - GPS location sharing
  - Audio recording capability
  - Volunteer notification
- **Quick Action Buttons**:
  - Call 112 (Emergency)
  - Share Location
  - Record Audio

### 2. Legal Rights Information
- **4 Major Categories**:
  - Workplace Harassment (Vishakha Guidelines)
  - Domestic Violence Protection
  - Property Rights
  - Safety in Public Spaces
- **Expandable Cards** with detailed information
- **Visual Icons** for easy identification
- **Action Buttons** to read more details

### 3. Emergency Helplines
- **6 Important Helplines**:
  - National Emergency (112)
  - Women Helpline (1091)
  - NCW (7827170170)
  - Domestic Violence (181)
  - Child Helpline (1098)
  - Cyber Crime (1930)
- **One-Tap Calling**
- **Copy Number** functionality
- **Color-coded** for easy recognition

---

## 🚀 How to Run the App

### Method 1: Using PowerShell Script (Easiest)
1. Open PowerShell in this folder
2. Run: `.\RUN_APP.ps1`
3. The app will open in Chrome browser

### Method 2: Manual Command
```powershell
# Add Flutter to PATH
$env:PATH = "C:\flutter\bin;$env:PATH"

# Run the app
flutter run -d chrome
```

### Method 3: VS Code
1. Press `F5` or click "Run > Start Debugging"
2. Select "Chrome" as the device
3. App will launch automatically

---

## 📱 Testing on Physical Device

### For Android Phone:
1. Enable USB Debugging on your phone
2. Connect phone via USB
3. Run: `flutter devices` (to verify connection)
4. Run: `flutter run` (will auto-detect your phone)

### For Android Emulator:
```powershell
# Start emulator
emulator -avd flutter_emulator

# Run app
flutter run
```

---

## 🎨 App Screenshots Description

### Home Screen
- Bottom navigation with 3 tabs
- Emergency, Legal Rights, and Helplines

### Emergency SOS Screen
- Large red SOS button (center)
- Gradient background
- Quick action buttons at bottom
- Long-press activation for safety

### Legal Rights Screen
- Scrollable list of rights categories
- Expandable cards with details
- Color-coded icons
- Call-to-action buttons

### Helplines Screen
- List of emergency numbers
- Call buttons for each helpline
- Copy number functionality
- Descriptions for each service

---

## 🛠️ Tech Stack

- **Framework**: Flutter 3.24.5
- **Language**: Dart 3.5.4
- **UI**: Material Design 3
- **Platform**: Cross-platform (Android, iOS, Web, Windows)

---

## 📋 Future Enhancements (7th Sem)

### Phase 1 (Current Demo) ✅
- [x] Emergency SOS UI
- [x] Legal Rights Information
- [x] Helpline Directory
- [x] Basic Navigation

### Phase 2 (Next Implementation)
- [ ] **Real SMS Integration** (Twilio API)
- [ ] **GPS Location Tracking** (Google Maps SDK)
- [ ] **Audio Recording** (Flutter plugins)
- [ ] **User Authentication** (Firebase Auth)
- [ ] **Emergency Contacts Management**
- [ ] **Shake Detection** for SOS activation

### Phase 3 (8th Sem)
- [ ] **Anonymous Reporting System**
- [ ] **AI Legal Chatbot** (Gemini API)
- [ ] **Community Heat Map**
- [ ] **Multi-language Support**
- [ ] **Evidence Collection Module**
- [ ] **Admin Dashboard**

---

## 📦 Project Structure

```
women_safety_app/
├── lib/
│   └── main.dart              # Main app code (all features)
├── android/                   # Android-specific files
├── ios/                       # iOS-specific files
├── web/                       # Web-specific files
├── pubspec.yaml              # Dependencies
├── RUN_APP.ps1               # Quick launch script
├── PROJECT_README.md         # This file
└── SETUP_GUIDE.md            # Flutter setup guide
```

---

## 🎓 For Academic Presentation

### Key Points to Highlight:

1. **Problem Statement**
   - Women lack easy access to legal information
   - Emergency response delays increase vulnerability
   - Existing apps focus only on panic buttons

2. **Our Solution**
   - Hybrid approach: Safety + Legal Awareness
   - User-friendly interface
   - Quick access to emergency services
   - Educational component for long-term empowerment

3. **Technical Implementation**
   - Cross-platform development (one codebase)
   - Modern UI/UX with Material Design
   - Scalable architecture for future features
   - No Android Studio required (VS Code only)

4. **Impact**
   - Immediate: Emergency response
   - Long-term: Legal awareness and empowerment
   - Accessibility: Free and easy to use
   - Reach: Works on any device (phone, web, desktop)

---

## 📊 Demo Walkthrough

### For Mid-Sem Presentation:

1. **Start**: Show home screen with 3 tabs
2. **Emergency Tab**: 
   - Demonstrate SOS button (long-press)
   - Show alert dialog
   - Explain simulated features
   - Show quick action buttons
3. **Legal Rights Tab**:
   - Scroll through categories
   - Expand one card (e.g., Workplace Harassment)
   - Show detailed information
   - Click "Read Full Details" button
4. **Helplines Tab**:
   - Show list of helplines
   - Demonstrate call button
   - Show copy number feature
5. **Conclusion**: Explain Phase 2 roadmap

---

## 🔧 Troubleshooting

### App doesn't start
```powershell
# Clean and rebuild
flutter clean
flutter pub get
flutter run -d chrome
```

### Flutter command not found
```powershell
# Add Flutter to PATH
$env:PATH = "C:\flutter\bin;$env:PATH"
```

### Chrome not opening
```powershell
# Check available devices
flutter devices

# Force Chrome
flutter run -d chrome
```

---

## 👥 Team Information

**Project**: Women Safety & Legal Awareness App
**Institution**: GLBITM
**Semester**: 7th Semester (Final Year)
**Year**: 2025

---

## 📞 Support

For questions or issues:
1. Check `SETUP_GUIDE.md` for Flutter installation help
2. Review Flutter documentation: https://docs.flutter.dev
3. Consult project guide/mentor

---

## 📄 License

This project is created for academic purposes as part of B.Tech final year project.

---

**Last Updated**: December 7, 2025
**Version**: 1.0.0 (Demo)
**Status**: ✅ Phase 1 Complete
