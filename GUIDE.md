# FKappa Framework - Developer Guide

Hướng dẫn chi tiết cách khai thác tối đa sức mạnh của FKappa Framework.

---

## 1. Công cụ FKappa CLI ⚡

Sử dụng CLI để duy trì cấu trúc code đồng nhất và tự động sinh test.

| Lệnh                                      | Mô tả                                                     |
|:------------------------------------------|:----------------------------------------------------------|
| `fkappa generate module <name>`           | Tạo cấu trúc Module đầy đủ (Data, Domain, Presentation).  |
| `fkappa generate usecase <mod> <name>`    | Tạo UseCase kèm file Unit Test mẫu.                       |
| `fkappa generate bloc <mod> <name>`       | Tạo BLoC (Event/State) kèm BLoC Test mẫu.                 |
| `fkappa generate repository <mod> <name>` | Tạo Repository Interface và Implementation kèm test.      |
| `fkappa generate datasource <mod> <name>` | Tạo Remote DataSource tích hợp sẵn `FKappaDio`.           |
| `fkappa generate page <mod> <name>`       | Tạo giao diện trang mới với `FKappaAppBar`.               |
| `fkappa generate widget <mod> <name>`     | Tạo widget nhỏ tái sử dụng trong module.                  |

---

## 2. Giao tiếp giữa các Module 🤝

### A. Event Bus (Giao tiếp bất đồng bộ)
Dùng khi Module A muốn phát thông tin cho "thế giới bên ngoài".
```dart
// Phát tin
FKappaEventBus.emit(UserLoggedOutEvent());

// Nhận tin (ở Module khác)
FKappaEventBus.on<UserLoggedOutEvent>().listen((_) => clearLocalCache());
```

### B. Service Registry (Giao tiếp trực tiếp)
Dùng khi cần gọi hàm và lấy kết quả ngay lập tức (Request-Response).
```dart
// Module User xuất bản Service
FKappaServiceRegistry.register<IAuthService>(AuthServiceImpl());

// Module Cart sử dụng Service
final auth = FKappaServiceRegistry.get<IAuthService>();
print(auth.getUserName());
```

---

## 3. Hệ thống UI & Animation 🎬

### Adaptive UI Kit
Các components của FKappa tự động thay đổi theo OS:
- `FKappaButton`, `FKappaTextField`, `FKappaCard`, `FKappaListTile`.
- `FKappaAppBar`, `FKappaBottomNavigationBar`, `FKappaLoadingIndicator`.

### Animation & Transitions
Sử dụng hiệu ứng khai báo:
```dart
FKappaAnimatedView(
  type: FKappaAnimationType.slideInUp,
  delay: Duration(milliseconds: 200),
  child: MyCard(),
)
```
Cấu hình chuyển trang trong GoRouter:
```dart
GoRoute(
  path: '/settings',
  pageBuilder: (context, state) => FKappaPageTransition.zoom(child: SettingsPage(), key: state.pageKey),
)
```

---

## 4. Networking & Offline-First 🌐

`FKappaDio` tự động quản lý cache. Bạn có thể cấu hình tại `FKappaApp`:
```dart
FKappaApp(
  baseUrl: 'https://api.example.com',
  interceptors: [ /* interceptors của bạn */ ],
)
```
**Chiến lược:** Nếu server lỗi hoặc mất mạng, `FKappaDio` sẽ tự động lục tìm trong cache để trả về dữ liệu gần nhất cho người dùng.

---

## 5. Quản lý Môi trường (Flavors) 🧪

Sử dụng script `./scripts/build_flavors.sh` để chạy ứng dụng:
-   **Phát triển:** `./build_flavors.sh run dev`
-   **Sản xuất:** `./build_flavors.sh build prod` (Tự động làm rối mã nguồn).

---

## 6. Global Loading Overlay ⏳

Hiển thị loading toàn ứng dụng (che phủ cả AppBar/BottomNav):
```dart
FKappaLoading.show(); // Hiện
await processTask();
FKappaLoading.hide(); // Ẩn
```
