# 🥦 Farmi POS - Hệ Thống Quản Lý Bán Hàng Nông Sản & Rau Củ Quả

> Hệ thống quản lý bán hàng (Point of Sale - POS) chuyên biệt cho chuỗi cửa hàng thực phẩm sạch, rau củ quả và nông sản, được xây dựng theo kiến trúc MVC với PHP & MySQL.

---

## 📌 Tính Năng Nổi Bật

### 1. 🛒 Bán hàng tại quầy (POS)
- Giao diện bán hàng trực quan, tốc độ xử lý nhanh.
- Tìm kiếm sản phẩm theo tên, danh mục.
- Áp dụng mã khuyến mãi / giảm giá linh hoạt.
- Hỗ trợ đa dạng phương thức thanh toán: Tiền mặt, Chuyển khoản ngân hàng.

### 2. 📦 Quản lý Sản phẩm & Danh mục
- Phân loại theo danh mục: Rau lá, Củ, Quả, Nấm,...
- Quản lý hình ảnh sản phẩm, đơn vị tính (kg, túi, bó,...), giá bán, giá vốn.

### 3. 📊 Quản lý Kho & Tồn kho
- Cập nhật số lượng tồn kho tự động theo thời gian thực khi bán hàng.
- Theo dõi lịch sử điều chỉnh kho và lý do nhập/xuất/hao hụt.

### 4. 🧾 Quản lý Đơn hàng
- Theo dõi chi tiết từng đơn hàng và trạng thái đơn.
- Xem lại lịch sử mua hàng, in hoá đơn.

### 5. 👥 Quản lý Khách hàng & Nhà cung cấp
- Lưu thông tin khách hàng thân thiết, số điện thoại, lịch sử mua hàng.
- Danh bạ các nhà cung cấp nông sản, hợp tác xã.

### 6. 🎁 Chương trình Khuyến mãi
- Tạo mã giảm giá theo số tiền cố định hoặc phần trăm.
- Thiết lập thời gian hiệu lực và điều kiện áp dụng.

### 7. 📈 Báo cáo & Thống kê Dashboard
- Thống kê doanh thu theo ngày, tuần, tháng.
- Báo cáo sản phẩm bán chạy, sản phẩm sắp hết hàng.

### 8. 🔐 Quản lý Tài khoản & Phân quyền
- Phân quyền theo 2 vai trò: **Quản trị viên (Admin)** và **Nhân viên bán hàng (Staff)**.

---

## 🛠️ Công Nghệ Sử Dụng

- **Backend:** PHP (Kiến trúc MVC, Router tùy biến, kết nối PDO an toàn).
- **Frontend:** HTML5, CSS3, JavaScript (AJAX / Fetch API để xử lý mượt mà không reload trang).
- **Cơ sở dữ liệu:** MySQL / MariaDB.
- **Môi trường chạy:** XAMPP, WampServer, Laragon hoặc bất kỳ Web Server Apache nào.

---

## 🚀 Hướng Dẫn Cài Đặt & Chạy Dự Án

### Yêu cầu tiên quyết:
- Đã cài đặt [XAMPP](https://www.apachefriends.org/) (khuyến nghị PHP 7.4 - 8.2).

### Các bước thực hiện:

#### Bước 1: Clone hoặc tải mã nguồn
Đưa thư mục dự án vào thư mục `htdocs` của XAMPP:
```bash
cd C:/xampp/htdocs
git clone https://github.com/thhlong28/farmi-pos.git
```
*(Đảm bảo thư mục dự án có đường dẫn là `C:/xampp/htdocs/farmi-pos`)*

#### Bước 2: Khởi động Server
- Mở **XAMPP Control Panel**.
- Bấm **Start** cả 2 dịch vụ **Apache** và **MySQL**.

#### Bước 3: Tạo Database & Import dữ liệu
1. Mở trình duyệt và truy cập: [http://localhost/phpmyadmin](http://localhost/phpmyadmin)
2. Nhấn nút **New (Mới)** để tạo cơ sở dữ liệu:
   - Tên Database: `farmi_qly`
   - Bảng mã (Collation): `utf8mb4_general_ci`
3. Chọn database `farmi_qly` vừa tạo, bấm tab **Import (Nhập)**.
4. Chọn file `database.sql` trong thư mục gốc của dự án và nhấn **Import (Thực hiện)**.

#### Bước 4: Kiểm tra cấu hình kết nối (Nếu cần)
File cấu hình nằm tại: `app/core/Database.php`
```php
private $host = "localhost";
private $db_name = "farmi_qly";
private $username = "root";     // Mặc định của XAMPP
private $password = "";         // Mặc định của XAMPP để trống
```

#### Bước 5: Trải nghiệm dự án
Mở trình duyệt và truy cập:
👉 **[http://localhost/farmi-pos/public/](http://localhost/farmi-pos/public/)**

---

## 🔑 Tài Khoản Đăng Nhập Mẫu

| Tài khoản | Mật khẩu | Quyền hạn |
| :--- | :--- | :--- |
| `admin` | `123456` | Quản trị viên (Toàn quyền) |
| `nhanvien1` | `123456` | Nhân viên bán hàng (Staff) |
| `nhanvien2` | `123456` | Nhân viên bán hàng (Staff) |

---

## 📂 Cấu Trúc Thư Mục

```text
farmi-pos/
├── app/
│   ├── api/             # Các API xử lý AJAX (JSON)
│   ├── controllers/     # Controller điều hướng logic nghiệp vụ
│   ├── core/            # Core framework (Router, Database, View)
│   └── models/          # Model thao tác dữ liệu với CSDL
├── public/              # Tài nguyên công khai (CSS, JS, Images, file index.php khởi chạy)
├── routes/              # Khai báo các định tuyến Web và API
├── view/                # Giao diện người dùng theo từng module
├── database.sql         # File cơ sở dữ liệu mẫu
├── .gitignore           # File loại trừ Git
└── README.md            # Tài liệu hướng dẫn dự án
```

---

## 👨‍💻 Tác Giả
- **Tác giả:** [thhlong28](https://github.com/thhlong28)
- **Dự án:** Farmi POS Management System
