# fkappa Framework - Developer Guide (v1.0.0)

Hướng dẫn chi tiết cách khai thác tối đa sức mạnh của fkappa Framework.

---

## 1. Công cụ Kappa CLI ⚡

Sử dụng CLI để duy trì cấu trúc code đồng nhất và tự động sinh test.

| Lệnh                                     | Mô tả                                                    |
|:-----------------------------------------|:---------------------------------------------------------|
| `kappa generate module <name>`           | Tạo cấu trúc Module đầy đủ (Data, Domain, Presentation). |
| `kappa generate usecase <mod> <name>`    | Tạo UseCase kèm file Unit Test mẫu.                      |
| `kappa generate bloc <mod> <name>`       | Tạo BLoC (Event/State) kèm BLoC Test mẫu.                |
| `kappa generate repository <mod> <name>` | Tạo Repository Interface và Implementation kèm test.     |
| `kappa generate datasource <mod> <name>` | Tạo Remote DataSource tích hợp sẵn `KappaDio`.           |
| `kappa generate page <mod> <name>`       | Tạo giao diện trang mới với `KappaAppBar`.               |
| `kappa generate widget <mod> <name>`     | Tạo widget nhỏ tái sử dụng trong module.                 |

---

## 2. Giao tiếp giữa các Module 🤝

### A. Event Bus (Giao tiếp bất đồng bộ)
Dùng khi Module A muốn phát thông tin cho "thế giới bên ngoài".
```dart
// Phát tin
KappaEventBus.emit(UserLoggedOutEvent());

// Nhận tin (ở Module khác)
KappaEventBus.on<UserLoggedOutEvent>().listen((_) => clearLocalCache());
```

### B. Service Registry (Giao tiếp trực tiếp)
Dùng khi cần gọi hàm và lấy kết quả ngay lập tức (Request-Response).
```dart
// Module User xuất bản Service
KappaServiceRegistry.register<IAuthService>(AuthServiceImpl());

// Module Cart sử dụng Service
final auth = KappaServiceRegistry.get<IAuthService>();
print(auth.getUserName());
```

---

## 3. Hệ thống UI & Animation 🎬

### Adaptive UI Kit
Các components của Kappa tự động thay đổi theo OS:
- `KappaButton`, `KappaTextField`, `KappaCard`, `KappaListTile`.
- `KappaAppBar`, `KappaBottomNavigationBar`, `KappaLoadingIndicator`.

### Animation & Transitions
Sử dụng hiệu ứng khai báo:
```dart
KappaAnimatedView(
  type: KappaAnimationType.slideInUp,
  delay: Duration(milliseconds: 200),
  child: MyCard(),
)
```
Cấu hình chuyển trang trong GoRouter:
```dart
GoRoute(
  path: '/settings',
  pageBuilder: (context, state) => KappaPageTransition.zoom(child: SettingsPage(), key: state.pageKey),
)
```

---

## 4. Networking & Offline-First 🌐

`KappaDio` tự động quản lý cache. Bạn có thể cấu hình tại `KappaApp`:
```dart
KappaApp(
  baseUrl: 'https://api.example.com',
  interceptors: [ /* interceptors của bạn */ ],
)
```
**Chiến lược:** Nếu server lỗi hoặc mất mạng, `KappaDio` sẽ tự động lục tìm trong cache để trả về dữ liệu gần nhất cho người dùng.

---

## 5. Quản lý Môi trường (Flavors) 🧪

Sử dụng script `./scripts/build_flavors.sh` để chạy ứng dụng:
-   **Phát triển:** `./build_flavors.sh run dev`
-   **Sản xuất:** `./build_flavors.sh build prod` (Tự động làm rối mã nguồn).

---

## 6. Global Loading Overlay ⏳

Hiển thị loading toàn ứng dụng (che phủ cả AppBar/BottomNav):
```dart
KappaLoading.show(); // Hiện
await processTask();
KappaLoading.hide(); // Ẩn
```
