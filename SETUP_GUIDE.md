# Flutter Development Setup in VS Code (Without Android Studio)

## Why VS Code is Sufficient

- **Lighter & Faster**: VS Code uses ~500MB RAM vs Android Studio's 4-8GB
- **Full Flutter Support**: Complete debugging, hot reload, widget inspector
- **GitHub Copilot**: Your AI assistant works here (not in Android Studio)
- **Terminal Access**: Run all Flutter/Android commands directly

---

## Setup Steps

### 1. Install Flutter SDK

**Windows:**
```powershell
# Download Flutter SDK
# Go to: https://docs.flutter.dev/get-started/install/windows
# Download the zip file (latest stable version)

# Extract to C:\src\flutter (or your preferred location)
# Add to PATH: C:\src\flutter\bin

# Verify installation
flutter --version
```

**Quick Install via Chocolatey (Alternative):**
```powershell
choco install flutter
```

### 2. Install Android SDK Command-line Tools

**Option A: Via Flutter (Recommended)**
```powershell
# Flutter will prompt to install Android SDK
flutter doctor --android-licenses

# If SDK not found, Flutter will guide you to download
```

**Option B: Manual Download**
1. Download from: https://developer.android.com/studio#command-line-tools-only
2. Extract to `C:\Android\cmdline-tools\latest\`
3. Add to PATH: `C:\Android\cmdline-tools\latest\bin`
4. Install required packages:
```powershell
sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0"
```

### 3. Install VS Code Extensions

**Required Extensions:**
- `Dart` (by Dart Code)
- `Flutter` (by Dart Code)

**Helpful Extensions:**
- `Flutter Widget Snippets`
- `Awesome Flutter Snippets`
- `Pubspec Assist`
- `Error Lens`

**Install via Command:**
```powershell
code --install-extension Dart-Code.dart-code
code --install-extension Dart-Code.flutter
```

### 4. Setup Device for Testing

**Option A: Android Emulator (via command-line)**
```powershell
# Create emulator
sdkmanager "system-images;android-33;google_apis;x86_64"
avdmanager create avd -n flutter_emulator -k "system-images;android-33;google_apis;x86_64"

# Start emulator
emulator -avd flutter_emulator
```

**Option B: Physical Android Device (Easiest)**
1. Enable Developer Options on your phone:
   - Settings → About Phone → Tap "Build Number" 7 times
2. Enable USB Debugging:
   - Settings → Developer Options → USB Debugging (ON)
3. Connect phone via USB
4. Verify:
```powershell
flutter devices
```

**Option C: Chrome (for web testing)**
- No setup needed, Flutter supports web out-of-the-box

### 5. Verify Setup

```powershell
# Run Flutter doctor to check setup
flutter doctor -v

# Expected output:
# [✓] Flutter (Channel stable, version X.X.X)
# [✓] Android toolchain - develop for Android devices
# [✓] Chrome - develop for the web
# [✓] VS Code (version X.X.X)
```

---

## Creating Your First Flutter Project in VS Code

### Method 1: VS Code Command Palette
1. Press `Ctrl+Shift+P`
2. Type: "Flutter: New Project"
3. Select "Application"
4. Choose project location
5. Enter project name: `women_safety_app`

### Method 2: Terminal
```powershell
# Navigate to your project folder
cd "c:\ZNEW FOLDER\4th year Project GLBITM"

# Create Flutter project
flutter create women_safety_app

# Open in VS Code
cd women_safety_app
code .
```

---

## Running Your App in VS Code

### Start Debugging
1. Connect device or start emulator
2. Press `F5` (or Run → Start Debugging)
3. Select device from dropdown (bottom-right status bar)

### Hot Reload
- `r` in terminal = Hot reload (fast refresh)
- `R` in terminal = Hot restart (full reload)
- `Ctrl+S` = Auto hot reload on save

### Terminal Commands
```powershell
# Run app
flutter run

# Run on specific device
flutter run -d chrome  # For web
flutter run -d <device-id>  # For specific device

# Build APK (for testing)
flutter build apk

# Clean project
flutter clean
```

---

## VS Code Shortcuts for Flutter

| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+P` → "Flutter: New Project" | Create project |
| `F5` | Start debugging |
| `Shift+F5` | Stop debugging |
| `Ctrl+F5` | Run without debugging |
| `Ctrl+Shift+P` → "Flutter: Hot Reload" | Manual hot reload |
| `Ctrl+Shift+P` → "Flutter: Hot Restart" | Full restart |
| `Ctrl+Shift+P` → "Flutter: Open DevTools" | Widget inspector |

---

## Advantages of VS Code for Your Project

### 1. GitHub Copilot Integration
- Write code faster with AI suggestions
- Generate boilerplate code instantly
- Get Flutter widget recommendations

### 2. Integrated Terminal
- Run Flutter commands without switching windows
- Multiple terminals (Flutter, Git, Firebase)

### 3. Git Integration
- Built-in source control
- Easy commits, branches, merges
- GitHub integration for collaboration

### 4. Debugging Tools
- Breakpoints, variable inspection
- Widget inspector (view widget tree)
- Performance overlay

### 5. Lightweight
- Fast startup (~2 seconds vs Android Studio's 30+ seconds)
- Low memory usage
- Works on lower-end laptops

---

## Common Issues & Solutions

### Issue 1: "Android SDK not found"
```powershell
# Set environment variables
$env:ANDROID_HOME = "C:\Android\sdk"
$env:PATH += ";$env:ANDROID_HOME\platform-tools"
$env:PATH += ";$env:ANDROID_HOME\cmdline-tools\latest\bin"

# Verify
flutter doctor --android-licenses
```

### Issue 2: "Unable to locate adb"
```powershell
# Install platform-tools
sdkmanager "platform-tools"
```

### Issue 3: "Emulator not starting"
- **Solution**: Use physical device (easier for development)
- **Alternative**: Install Android Studio ONLY for emulator, code in VS Code

### Issue 4: "Gradle build failed"
- **Solution**: 
```powershell
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

---

## Recommended Workflow for Your Project

```
VS Code (Coding) → Physical Device (Testing) → GitHub (Version Control)
```

**Phase 1 (7th Sem):**
- Code in VS Code with Copilot assistance
- Test on your Android phone (USB debugging)
- Use Chrome for quick UI testing
- Commit to GitHub after each feature

**Phase 2 (8th Sem):**
- Continue in VS Code
- Use Firebase directly (no Android Studio needed)
- Build APK for demo via: `flutter build apk`

---

## Do You Need Android Studio at All?

### ❌ NOT Needed For:
- Writing Dart/Flutter code
- Hot reload/debugging
- Building APKs
- Firebase integration
- Most plugin configurations

### ✅ Needed ONLY For:
- Creating complex Android emulators (use physical device instead)
- Editing native Android code (rare for Flutter projects)
- Advanced Gradle configurations (rare)

**Verdict**: 95% of your project can be done in VS Code. Use physical device for testing.

---

## Next Steps

1. **Install Flutter SDK** → Run `flutter doctor`
2. **Install VS Code extensions** → Dart + Flutter
3. **Connect your Android phone** → Enable USB debugging
4. **Create project** → `flutter create women_safety_app`
5. **Start coding** → Press F5 to run

---

## Resources

- **Flutter Docs**: https://docs.flutter.dev
- **VS Code Flutter Setup**: https://docs.flutter.dev/get-started/editor?tab=vscode
- **Flutter Samples**: https://github.com/flutter/samples
- **Pub.dev** (packages): https://pub.dev

---

**Pro Tip**: Keep this workspace open in VS Code. GitHub Copilot will learn your project context and give better suggestions as you code!
