# SQL_Lab

BÀI TẬP ỨNG DỤNG STORED PROCEDURE
Câu 1:
Tạo một cơ sở dữ liệu Database_QLKS1  gồm 1 bảng như sau:
Bảng tKhachHang
Tên cột	Kiểu dữ liệu và các ràng buộc
Idkhachhang	Char(10), ràng buộc khóa chính
Hoten	Nvarchar(50), not null
Diachi	Nvarchar(50)
SoCMND	Char(13)
Sodienthoai	Char(10), ràng buộc kiểu số

Câu 2: 
a.	Tạo thủ tục chèn bảng ghi vào bảng tKhachHang 
b.	Thực thi thủ tục lưu trữ để chèn 3 bản ghi vào bảng tKhachHang
Câu 3:
Câu 3: 
a.	Tạo thủ tục cập nhật dữ liệu và tất cả các trường ngoài Idkhachhang với điều kiện mã khách hàng có giá id được nhập vào.
b.	Thực thi thủ tục lưu trữ để cập nhật khách hàng có mã số “KH0001” .
Câu 4: 
a.	Tạo thủ tục xoá 1 khách hàng dựa vào mã số.
b.	Thực thi thủ tục lưu trữ để xoá 1 bảng ghi có mã số được nhập vào.
Câu 5 :  
a.	Tạo thủ tục để tìm kiếm các khách hàng dựa vào tên được nhập và sắp xếp theo thứ tự giảm dần.
Câu 6: sửa đổi các thủ tục lưu trữ để đưa ra thông báo lỗi trong quá trình thực hiện (về nhà thực hiện)
