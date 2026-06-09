# AI Spreadsheet App - Build Guide

ဒီ project ကို သင့်ရဲ့စက်မှာ APK အဖြစ် build လုပ်ဖို့ အောက်ပါအဆင့်တွေကို လုပ်ဆောင်ပေးပါ။

## ၁။ လိုအပ်ချက်များ (Prerequisites)
- **Flutter SDK:** [flutter.dev](https://docs.flutter.dev/get-started/install) ကနေ install လုပ်ထားပါ။
- **Java JDK:** JDK 17 သို့မဟုတ် အထက် ရှိရပါမယ်။
- **Android SDK:** Android Studio ကနေတစ်ဆင့် install လုပ်ထားပါ။

## ၂။ Build လုပ်ရန် အဆင့်ဆင့်လမ်းညွှန်

### အဆင့် (က) - Folder ထဲသို့ဝင်ပါ
Terminal သို့မဟုတ် Command Prompt ကိုဖွင့်ပြီး project folder ထဲသို့ဝင်ပါ။
```bash
cd ai_spreadsheet_app
```

### အဆင့် (ခ) - Dependencies များ ရယူပါ
လိုအပ်တဲ့ package တွေကို download ဆွဲရန် အောက်ပါ command ကို ရိုက်ပါ။
```bash
flutter pub get
```

### အဆင့် (ဂ) - APK Build လုပ်ပါ
Release version APK ထုတ်ရန် အောက်ပါ command ကို ရိုက်ပါ။
```bash
flutter build apk --release
```

## ၃။ Build ပြီးပါက APK ကို ဘယ်မှာရှာရမလဲ?
Build အောင်မြင်သွားပါက APK ဖိုင်ကို အောက်ပါလမ်းကြောင်းမှာ တွေ့နိုင်ပါတယ်။
`build/app/outputs/flutter-apk/app-release.apk`

## ၄။ ပြဿနာတစ်စုံတစ်ရာရှိပါက
- **Gradle Error တက်လျှင်:** သင့်စက်က Java version နဲ့ Gradle version မကိုက်ညီတာမျိုး ဖြစ်နိုင်ပါတယ်။ `java -version` ကို စစ်ဆေးကြည့်ပါ။
- **API Key Error:** `lib/main.dart` ထဲမှာ Gemini API Key နဲ့ Supabase credentials တွေ မှန်ကန်မှု ရှိမရှိ ပြန်စစ်ပေးပါ။

---
**Happy Building!** 🚀
