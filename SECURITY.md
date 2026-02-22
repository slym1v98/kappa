# Kappa Framework - Security & Signing Guide

Tài liệu này hướng dẫn cách bảo mật mã nguồn và cấu hình ký ứng dụng (App Signing) cho từng môi trường (Flavor).

---

## 1. Code Obfuscation (Làm rối mã)

Kappa tự động hỗ trợ làm rối mã khi build bản `prod` thông qua script `./scripts/build_flavors.sh`.
Lệnh build thực tế sẽ thêm các flag:
- `--obfuscate`: Làm rối tên hàm và biến.
- `--split-debug-info`: Tách thông tin debug ra khỏi file APK/IPA để giảm kích thước và bảo mật.

---

## 2. Android App Signing (Ký ứng dụng)

### Bước 1: Tạo file `android/key.properties`
Tạo file này để lưu trữ thông tin nhạy cảm (ĐỪNG commit file này lên Git).

```properties
storePassword=your_password
keyPassword=your_key_password
keyAlias=upload
storeFile=/Users/username/path/to/upload-keystore.jks
```

### Bước 2: Cấu hình `android/app/build.gradle`
Chỉnh sửa khối `android` để hỗ trợ nhiều cấu hình ký:

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        debug {
            // Dùng mặc định của Flutter
        }
        release {
            storeFile (keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null)
            storePassword keystoreProperties['storePassword']
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
            // Bật ProGuard/R8
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }

    productFlavors {
        dev {
            dimension "app"
            applicationIdSuffix ".dev"
            signingConfig signingConfigs.debug
        }
        prod {
            dimension "app"
            signingConfig signingConfigs.release
        }
    }
}
```

---

## 3. iOS App Signing

Trên iOS, việc ký ứng dụng được quản lý thông qua **Xcode Build Settings** và **Provisioning Profiles**.

1. Mở Xcode (`open ios/Runner.xcworkspace`).
2. Chọn dự án Runner -> Target Runner.
3. Trong tab **Signing & Capabilities**, bạn có thể chọn cấu hình khác nhau cho `Debug-dev`, `Release-prod`, v.v.
4. Đảm bảo mỗi flavor (`dev`, `prod`) có một **Bundle Identifier** riêng (ví dụ: `com.kappa.app.dev` và `com.kappa.app`).

---

## 4. Bảo mật dữ liệu nhạy cảm (Secrets)

Kappa khuyến khích sử dụng `KappaEnv` kết hợp với lệnh build để truyền secrets qua `--dart-define`:

Ví dụ khi chạy:
`flutter run --dart-define=API_KEY=12345`

Trong code Dart:
`String apiKey = String.fromEnvironment('API_KEY');`
