# fkappa Framework Architecture Blueprint

Tài liệu này mô tả chi tiết các thành phần hạ tầng và triết lý kiến trúc của fkappa.

## 1. Clean Architecture Strict Mode
fkappa không chỉ khuyến khích mà còn **ép buộc** Clean Architecture qua các lớp trừu tượng:

-   **Domain Layer (Purity):** Tuyệt đối không chứa code UI hoặc Framework (trừ DI). `BaseUseCase` sử dụng `fpdart.Either` để ép buộc việc xử lý lỗi (functional error handling).
-   **Data Layer (Abstraction):** `BaseRepository` và `BaseDataSource` tách rời nguồn dữ liệu.
-   **Presentation Layer (BLoC):** Sử dụng `flutter_bloc` để tách rời State và Logic UI. Hỗ trợ `BaseHydratedBloc` để tự động lưu trạng thái vào Disk.

## 2. Infrastructure Layer (The Core)

### Dependency Injection (GetIt)
Quản lý tập trung tại `FKappaApp`. Mỗi module tự đăng ký dependency của mình khi được nạp vào hệ thống.

### Unified Routing (GoRouter)
Hệ thống Route của các module được "donate" vào `FKappaApp` để xây dựng một bản đồ điều hướng duy nhất. Hỗ trợ **Middleware** (Auth/Guest) để bảo vệ route tập trung.

### Reactive Connectivity (FKappaDio)
Được xây dựng trên Dio với:
-   `DioCacheInterceptor`: Hỗ trợ lưu trữ offline.
-   `fkappaMockInterceptor`: Cho phép giả lập API trả về JSON tĩnh.
-   `FKappaBlocObserver`: Giám sát toàn bộ thay đổi trạng thái của app.

## 3. Communication Patterns

### Loose Coupling (Event Bus)
Sử dụng `StreamController.broadcast()` để truyền tin nhắn giữa các module mà không cần import lẫn nhau.

### Contract-based (Service Registry)
Sử dụng Singleton registry để trao đổi Service dựa trên Interface, giảm thiểu phụ thuộc chéo.

## 4. UI Layer (Design Tokens & Grid)
-   **Grid System:** 12-column grid thích ứng (`FKappaGrid`).
-   **Design Tokens:** Hệ thống hằng số (`FKappaDesignTokens`) cho Radius, Spacing, Elevation.
-   **Responsive:** Sử dụng `responsive_framework` tích hợp sâu trong `FKappaApp`.

## 5. Security Model
-   **Obfuscation:** Tích hợp trong build script bản Prod.
-   **Flavor Isolation:** Phân tách hoàn toàn URL, API Key và Signing Certificates.
