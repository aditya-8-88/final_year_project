# Women Safety & Legal Awareness App

A comprehensive Flutter web application designed to educate women about their legal rights, provide access to real case studies with official sources, and offer emergency assistance features.  
Website Link: https://womensafetyandlegalawareness.netlify.app/

## 🎯 Project Overview

This application addresses a critical gap: **70% of women don't report crimes because they don't know their rights.** Unlike typical panic button apps that women rarely use, this app focuses on education and legal awareness with extensively sourced content.

## ✨ Key Features

### 📚 Educational Content
- **8 Comprehensive Case Studies**: Detailed analysis of landmark cases (Nirbhaya 2012, Vishaka 1997, Mathura 1972, etc.) with 500+ words each
- **Official Statistics**: NCRB 2021 data, WHO statistics, and UN Women reports
- **10 Legal Rights**: Constitutional provisions (Article 39A, Section 154 CrPC, etc.) with "How to Use" guides
- **Success Stories**: Inspirational accounts of survivors who became warriors
- **Landmark Judgments**: Supreme Court decisions that changed laws

### 🔗 Verified Sources & Citations
All content includes:
- NCRB (National Crime Records Bureau) official data
- Supreme Court judgement citations (AIR numbers)
- Constitutional article references
- WHO and UN Women statistics
- Direct links to government websites (ncrb.gov.in, legislative.gov.in, ncw.nic.in, nalsa.gov.in)

### 🚨 Emergency Features
- **Broadcast SOS**: Send emergency alerts to saved contacts
- **Quick Helplines**: 112, 1091, 181, NCW helpline (7827-170-170), NALSA (15100)
- **Emergency Contact Management**: Save and manage emergency contacts

### ⚖️ Legal Rights Section
Each legal right includes:
- Constitutional/IPC section reference
- Full legal text
- Key points breakdown
- Practical "How to Use" guide
- Official resource links

## 🎨 Design Philosophy

- **Professional & Formal**: Navy blue theme suitable for academic presentation
- **Source-Driven**: Every claim backed by official sources
- **Accessible**: Clear, readable layout with proper typography
- **Mobile-Friendly**: Responsive design for all devices

## 🛠️ Technical Stack

- **Framework**: Flutter 3.24.5
- **Language**: Dart 3.5.4
- **Platform**: Web (with potential for Android/iOS)
- **Key Dependencies**:
  - `url_launcher ^6.2.2`: Open external official links
  - `shared_preferences ^2.2.2`: Store emergency contacts
  - `permission_handler ^11.1.0`: Runtime permissions
  - `http ^1.1.2`: API requests

## 📊 Data Sources

1. **National Crime Records Bureau (NCRB)**: Crime statistics and reports
2. **Supreme Court of India**: Official judgements and AIR citations
3. **WHO (World Health Organization)**: Global violence statistics
4. **UN Women**: International data and frameworks
5. **Legislative.gov.in**: Constitutional articles and IPC sections
6. **Ministry of Women and Child Development**: POSH Act, guidelines
7. **Wikipedia**: Verified case study documentation

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.24.5 or higher
- Dart SDK 3.5.4 or higher
- Chrome browser (for web testing)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/adityaa-8-88/final_year_project.git
cd final_year_project
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
# For web
flutter run -d chrome

# For Android
flutter run -d <device_id>
```

### Building for Production

```bash
# Web build
flutter build web --release

# Android APK
flutter build apk --release
```

## 📁 Project Structure

```
lib/
├── main.dart                    # Main app entry point and UI
├── comprehensive_data.dart      # All sourced content and data structures
└── case_studies_data.dart       # Legacy data (kept for compatibility)

build/web/                       # Production web build
```

## 📱 App Navigation

1. **Learn Tab**: Educational content overview with menu cards
2. **Statistics Tab**: Official NCRB and WHO statistics with sources
3. **Emergency Tab**: SOS broadcast and helpline access
4. **Rights Tab**: 10 essential legal rights with constitutional references

## 🎓 Academic Context

**Institution**: GLBITM (GL Bajaj Institute of Technology and Management)  
**Project Type**: B.Tech Final Year Project  
**Academic Year**: 2024-2025  
**Focus Area**: Women Safety, Legal Awareness, Mobile Application Development

## 📈 Impact Metrics

- **8 detailed case studies** vs typical 2-3 basic cases in similar apps
- **10 legal provisions** with full constitutional backing
- **8 official statistics** from NCRB 2021 and WHO 2021
- **10 verified helplines** with government website links
- **100+ citations** from official sources

## 🔒 Privacy & Security

- No personal data collected or stored on servers
- Emergency contacts stored locally on device only
- All external links point to official government websites
- No third-party analytics or tracking

## 📞 Support & Resources

### Official Helplines (India)
- **Emergency**: 112
- **Women Helpline**: 1091
- **Women Helpline (Domestic Abuse)**: 181
- **National Commission for Women**: 7827-170-170
- **Legal Services (NALSA)**: 15100

### Official Websites
- [NCRB India](https://ncrb.gov.in/)
- [National Commission for Women](https://ncw.nic.in/)
- [NALSA (Legal Aid)](https://nalsa.gov.in/)
- [Legislative.gov.in](https://legislative.gov.in/)

## 🙏 Acknowledgments

- National Crime Records Bureau for comprehensive data
- Supreme Court of India for legal documentation
- WHO and UN Women for global statistics
- All survivors and activists who fought for legal reforms

## 📝 Citation

If you use this project for research or reference:

```
Women Safety & Legal Awareness App (2025)
GLBITM Final Year Project
Developer: Aditya
GitHub: https://github.com/adityaa-8-88/final_year_project
```

---

**Note**: This app is intended for educational and awareness purposes. In case of emergency, please call 112 (India Emergency Number) immediately.
