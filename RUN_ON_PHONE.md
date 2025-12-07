# Testing on Android Phone - Quick Guide

## 🔧 One-Time Setup (5 minutes)

### Step 1: Enable Developer Mode on Your Phone
1. Open **Settings** on your Android phone
2. Go to **About Phone**
3. Find **Build Number**
4. **Tap "Build Number" 7 times** rapidly
5. You'll see: "You are now a developer!"

### Step 2: Enable USB Debugging
1. Go back to **Settings**
2. Find **Developer Options** (usually in System or Additional Settings)
3. Turn ON **USB Debugging**
4. Also turn ON **Install via USB** (if available)

### Step 3: Connect Phone to PC
1. Use a **USB cable** (must support data transfer, not just charging)
2. Connect phone to your PC
3. On phone, you'll see: "Allow USB Debugging?"
4. Check "Always allow from this computer"
5. Tap **OK**

### Step 4: Verify Connection
```powershell
# Run this command
flutter devices
```

You should see your phone listed like:
```
Android SDK built for x86 (mobile) • emulator-5554 • android-x86
Galaxy M31 (mobile) • R58M50XXXXX • android-arm64
```

---

## 🚀 Run App on Phone

### Method 1: Automatic (Easiest)
```powershell
# Flutter will auto-detect your phone and run
flutter run
```

### Method 2: Specific Device
```powershell
# If you have multiple devices
flutter devices                    # List all devices
flutter run -d <DEVICE_ID>        # Run on specific device
```

### Method 3: Use this script
```powershell
# Run the app
.\RUN_ON_PHONE.ps1
```

---

## 📱 What Works Better on Phone vs Web

| Feature | Web (Chrome) | Android Phone |
|---------|--------------|---------------|
| **Call 112** | ❌ Only shows intent | ✅ Actually makes call |
| **SMS with Location** | ❌ Shows form | ✅ Opens SMS app with link |
| **GPS Location** | ⚠️ Browser location | ✅ Real GPS hardware |
| **Shake Detection** | ❌ Not available | ✅ Uses accelerometer |
| **Copy Number** | ✅ Works | ✅ Works |
| **External Links** | ✅ Opens browser | ✅ Opens browser |
| **Emergency Contacts** | ✅ Works | ✅ Works + phone integration |
| **Notifications** | ⚠️ Browser notifications | ✅ Native notifications |

**Winner: 📱 Android Phone gives you FULL functionality!**

---

## 🎯 Testing Checklist on Phone

Once app is running on your phone:

### Emergency Tab:
- [ ] Click "Call 112" → Phone dialer opens with 112
- [ ] Click "Share Location" → SMS opens with Google Maps link
- [ ] Click "Record Audio" → Toggle works
- [ ] Long-press SOS button → Dialog appears
- [ ] Check if green "Location Active" badge shows

### Legal Rights Tab:
- [ ] Expand any card
- [ ] Click "Learn More Online" → Browser opens official site
- [ ] Click "Full Details" → Detail page opens

### Helplines Tab:
- [ ] Click "Call Now" on Women Helpline (1091) → Dialer opens
- [ ] Click copy icon → "Number copied" toast appears
- [ ] Click website icon → Browser opens NCW site

### Profile Tab:
- [ ] Add emergency contact → Saves successfully
- [ ] Delete contact → Removes from list
- [ ] Go to Settings → Toggle shake detection
- [ ] Shake phone 3 times → Alert appears! 🎉

---

## 🔥 Demo on Phone (Most Impressive!)

**For your professor/presentation:**

1. **Show it's a REAL Android app** (not web)
2. **Click "Call 112"** → Phone dialer actually opens
3. **Click "Share Location"** → SMS opens with real GPS link
4. **Shake the phone 3 times** → Emergency alert triggers!
5. **Add emergency contact** → Show it saves
6. **Click any helpline** → Real calling works

This is WAY more impressive than web demo!

---

## ⚡ Hot Reload on Phone

While app is running:
- **Press 'r'** in terminal → Hot reload (fast refresh)
- **Press 'R'** in terminal → Hot restart (full reload)
- **Press 'q'** → Quit app

Edit code in VS Code → Press 'r' → Changes appear on phone instantly!

---

## 🐛 Troubleshooting

### Phone not detected?
```powershell
# Check ADB is working
flutter doctor

# Restart ADB server
adb kill-server
adb start-server

# List devices again
flutter devices
```

### "Unauthorized device"?
- Unplug and replug USB cable
- On phone: Tap "Always allow" when USB debugging prompt appears

### "No devices found"?
- Check USB cable (try different cable)
- Make sure USB Debugging is ON
- Try different USB port on PC
- Install phone drivers (usually auto-installs)

### App installed but won't open?
```powershell
# Clear and reinstall
flutter clean
flutter run
```

---

## 📦 Build APK for Demo (No PC needed!)

Want to install on multiple phones WITHOUT PC?

```powershell
# Build APK file
flutter build apk --release

# APK will be at:
# build\app\outputs\flutter-apk\app-release.apk
```

Transfer this APK via:
- WhatsApp
- Google Drive
- Bluetooth
- USB

Install on any Android phone!

---

## 💾 Install from APK

1. Transfer `app-release.apk` to phone
2. Open file
3. Phone says: "Install blocked" (first time)
4. Go to Settings → Allow from this source
5. Tap Install
6. App installed! 🎉

---

## 🎬 Ready to Test on Phone!

**Next steps:**
1. Enable USB Debugging (takes 2 minutes)
2. Connect phone via USB
3. Run: `flutter devices` (verify connection)
4. Run: `flutter run` (app installs and opens)
5. Test all features with REAL phone hardware!

Your app will be 10x more impressive on actual phone! 📱🚀
