# Kappa Framework - Developer Guide

Chào mừng bạn đến với tài liệu hướng dẫn phát triển ứng dụng bằng **Kappa Framework**. Kappa được thiết kế để giúp bạn xây dựng ứng dụng Flutter nhanh chóng, linh hoạt và có tính tùy biến cao dựa trên nền tảng Clean Architecture và BLoC.

---

## 1. Kiến trúc cốt lõi (Core Architecture)

Kappa áp dụng nghiêm ngặt **Clean Architecture** để phân tách rõ ràng các tầng (layers):

-   **Domain Layer**: Chứa Business Logic nguyên bản (`Entities`, `UseCases`, `Repositories Interface`). Không phụ thuộc vào bất kỳ library nào (trừ `fpdart` cho functional programming).
-   **Data Layer**: Thực thi các Repositories, kết nối với API (`DataSources`) hoặc Local DB.
-   **Presentation Layer**: Sử dụng `BLoC` để quản lý trạng thái và các `Pages/Widgets` để hiển thị UI.

### Lớp cơ sở (Base Classes)
-   `BaseUseCase<Type, Params>`: Mọi logic nghiệp vụ phải nằm trong UseCase. Trả về `Either<Failure, Type>`.
-   `BaseHydratedBloc<E, S>`: BLoC tự động lưu trạng thái vào ổ đĩa.
-   `KappaModule`: Contract bắt buộc cho mỗi feature module.

---

## 2. Hệ thống Module

Mọi tính năng trong Kappa là một Module độc lập.

### Cách tạo Module mới bằng CLI:
Sử dụng công cụ dòng lệnh tích hợp để tạo nhanh cấu trúc module:
```bash
dart run kappa generate module <tên_module>
```

### Đăng ký Module:
Tại `main.dart`, bạn chỉ cần khai báo module vào `KappaApp`:
```dart
KappaApp(
  modules: [
    AuthModule(),
    ProductModule(),
    SettingsModule(),
  ],
  initialRoute: '/home',
)
```

---

## 3. Giao tiếp giữa các Module (Inter-module Communication)

Kappa cung cấp 2 cơ chế để các module "nói chuyện" với nhau mà không gây phụ thuộc chéo (Circular Dependency):

### A. Event Bus (Reactive - Giao tiếp lỏng)
Dùng khi Module A muốn thông báo một sự kiện mà không quan tâm ai lắng nghe.
-   **Phát tin**: `KappaEventBus.emit(UserLoggedInEvent(user));`
-   **Nhận tin**: 
    ```dart
    KappaEventBus.on<UserLoggedInEvent>().listen((event) {
      // Xử lý logic tại module khác
    });
    ```

### B. Service Registry (Direct - Giao tiếp chặt)
Dùng khi Module A muốn gọi trực tiếp một hàm từ Module B và lấy kết quả ngay.
-   **Đăng ký**: `KappaServiceRegistry.register<IAuthService>(AuthService());`
-   **Sử dụng**: `final auth = KappaServiceRegistry.get<IAuthService>();`

---

## 4. Networking & API Mocking

Kappa sử dụng `KappaDio` tích hợp sẵn các interceptors thông minh.

### Giả lập API (Mocking):
Bạn có thể phát triển giao diện ngay cả khi Backend chưa xong:
```dart
final dio = KappaDio(
  baseUrl: 'https://api.example.com',
  interceptors: [
    KappaMockInterceptor(
      mockData: {
        '/user/profile': {'id': '1', 'name': 'Mock User'}
      },
      delay: Duration(seconds: 1),
    ),
  ],
);
```

---

## 5. UI & Responsive Toolkit

### Responsive Layout:
Tự động thay đổi giá trị theo kích thước màn hình (Mobile, Tablet, Desktop):
```dart
final fontSize = KappaResponsive.valueByBreakpoint(
  context, 
  mobile: 16.0, 
  tablet: 24.0, 
  desktop: 32.0
);
```

### Smart Components:
Sử dụng `KappaButton` để tự động render theo Style của OS (Material 3 trên Android, Cupertino trên iOS).

---

## 6. Lưu trữ trạng thái vĩnh viễn (Persistence)

Để một BLoC tự động lưu dữ liệu (ví dụ: Giỏ hàng, Cài đặt):
1.  Kế thừa `BaseHydratedBloc`.
2.  Override `fromJson` và `toJson`.

```dart
class SettingsBloc extends BaseHydratedBloc<bool, SettingsState> {
  @override
  SettingsState? fromJson(Map<String, dynamic> json) => SettingsState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(SettingsState state) => state.toMap();
}
```

---

## 7. Giám sát & Lỗi (Monitoring)

Kappa tích hợp sẵn **Sentry** và **Global Bloc Observer**:
-   Mọi lỗi Logic hoặc Network sẽ được log tập trung.
-   Trong môi trường Production, lỗi sẽ được tự động gửi về dashboard Sentry.

---

## 8. Quy trình Test (Testing)

Kappa khuyến khích viết test ở 3 mức:
1.  **Unit Test**: Test các `UseCase` và `Repository`.
2.  **Bloc Test**: Sử dụng `bloc_test` để kiểm tra luồng trạng thái.
3.  **Integration Test**: Kiểm tra việc bắn/nhận sự kiện qua `Event Bus` giữa 2 module.

```bash
# Chạy toàn bộ test
flutter test
```

---
*Tài liệu này được tạo tự động bởi Kappa Framework Assistant.*
