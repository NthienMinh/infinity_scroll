# 🛒 Flutter Product List App

## 📋 Giới thiệu

Đây là một dự án Flutter có chức năng hiển thị danh sách sản phẩm, hỗ trợ phân trang, tìm kiếm sản phẩm theo từ khóa và đánh dấu sản phẩm yêu thích.

## 🔧 Công nghệ và thư viện sử dụng

* **Flutter**: SDK chính để phát triển giao diện người dùng.
* **BLoC** (`flutter_bloc`): Quản lý trạng thái theo mô hình BLoC.
* **Freezed**: Sinh mã tự động cho các model (immutable class, JSON serialization...).
* **Shared Preferences**: Lưu trữ dữ liệu cục bộ (local), dùng để ghi nhớ danh sách sản phẩm yêu thích.

## 🚀 Chức năng chính

### ✅ Tải danh sách sản phẩm

Khi vào màn hình đầu tiên, app sẽ gọi API để lấy danh sách sản phẩm. Có 3 trường hợp có thể xảy ra:

1. **TH1 – API phản hồi lỗi (ví dụ: lỗi truy vấn, tham số sai)**
   Màn hình chuyển sang trạng thái `Fail`, hiển thị thông báo lỗi và nút "Thử lại".

2. **TH2 – Không gửi được request lên server (do lỗi mạng, thiết bị không kết nối)**
   Màn hình chuyển sang trạng thái `Error`, hiển thị thông báo và nút "Thử lại".

3. **TH3 – API phản hồi thành công**

    * Hiển thị danh sách 20 sản phẩm đầu tiên.
    * Khi cuộn đến cuối danh sách, ứng dụng sẽ tự động tải thêm 20 sản phẩm tiếp theo (phân trang vô hạn).

### 🔍 Tìm kiếm sản phẩm

* Nhập từ khóa vào thanh tìm kiếm để lọc danh sách sản phẩm.
* Kết quả tìm kiếm cũng hỗ trợ phân trang và xử lý các trạng thái giống như khi tải danh sách ban đầu.

### ❤️ Danh sách yêu thích

* Mỗi sản phẩm có một nút trái tim để đánh dấu yêu thích.
* Khi được đánh dấu, sản phẩm sẽ được lưu id vào local bằng `SharedPreferences`.
* Các sản phẩm đã yêu thích sẽ được đánh dấu bằng biểu tượng trái tim màu đỏ mỗi khi tải danh sách.

## ▶️ Cách chạy dự án

```bash
flutter pub get
flutter run
```

## 📂 Cấu trúc thư mục

```
lib/
├── features/
│   └── products/           # Màn hình sản phẩm, bloc, UI, event, state
├── models/                # Các model như Product, ProductResponse, ApiResponse
├── services/              # Gọi API (ProductService)
└── main.dart              # Entry point
```


