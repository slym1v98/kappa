# Kappa Framework v1.0.0 🚀

Kappa là một Framework Flutter mã nguồn mở, hiện đại, được thiết kế để xây dựng các ứng dụng mobile quy mô lớn (Enterprise) với tốc độ nhanh kỷ lục nhưng vẫn đảm bảo tính ổn định và bảo mật cao.

## 🌟 Tại sao chọn Kappa?

*   **🛡️ Strict Clean Architecture:** Ép buộc cấu trúc code sạch thông qua các Base Class (`UseCase`, `Repository`, `DataSource`).
*   **🧩 True Modularity:** Các tính năng là các Module độc lập, có Route và DI riêng, dễ dàng tháo lắp.
*   **📱 Adaptive UI Kit:** Bộ UI components thông minh tự động thay đổi giao diện theo Android (Material 3) và iOS (HIG).
*   **⚡ Developer Productivity:** Công cụ CLI mạnh mẽ giúp sinh code và file test tự động chỉ trong vài giây.
*   **🌐 Advanced Networking:** Tích hợp sẵn `KappaDio` với cơ chế Offline-First (Cache), Mocking và Error Handling.
*   **🔐 Enterprise Security:** Hỗ trợ Flavor, Environment Isolation và tự động làm rối mã (Obfuscation).
*   **🎬 Pro Animations:** Hệ thống hiệu ứng và chuyển trang (Page Transitions) tích hợp sẵn, mượt mà 120FPS.

## 🚀 Bắt đầu nhanh

### 1. Cài đặt CLI
Để sử dụng các tính năng sinh code tự động:
```bash
# Trong thư mục dự án của bạn
alias kappa='dart run bin/kappa.dart'
```

### 2. Tạo Module đầu tiên
```bash
kappa generate module auth
```

### 3. Khởi chạy ứng dụng
```dart
void main() {
  runApp(
    KappaApp(
      title: 'My Super App',
      baseUrl: 'https://api.myapp.com',
      modules: [ AuthModule(), MainModule() ],
      initialRoute: '/login',
    ),
  );
}
```

## 📚 Tài liệu chi tiết
*   [Developer Guide (Hướng dẫn phát triển)](GUIDE.md)
*   [Architecture Blueprint (Bản thiết kế kiến trúc)](ARCHITECTURE.md)
*   [Security & Signing (Bảo mật & Ký ứng dụng)](SECURITY.md)

---
Built with ❤️ for professional Flutter developers.
