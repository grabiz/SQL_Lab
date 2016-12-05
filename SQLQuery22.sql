/* LAB 02- NGUYEN BA ANH NGUYEN
LTVCN-iViettech*/

/*Cau 1*/
CREATE DATABASE Database_QLKS1;
GO
USE Database_QLKS1;

CREATE TABLE tKhachHang(
Idkhachhang char(10) NOT NULL PRIMARY KEY,
Hoten Nvarchar(50) NOT NULL,
Diachi Nvarchar(50),
SoCMND Char(13),
Sodienthoai Char(10) CHECK(Sodienthoai LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);
GO

/*Cau 2
a.	Tạo thủ tục chèn bảng ghi vào bảng tKhachHang 
b.	Thực thi thủ tục lưu trữ để chèn 3 bản ghi vào bảng tKhachHang
*/

CREATE PROC spInsertRow 
@idkhachhang char(10),@hoten Nvarchar(50),@diachi Nvarchar(50), @CMND Char(13),@Tel Char(10)
AS
BEGIN
   INSERT INTO tKhachHang 
   VALUES (@idkhachhang,@hoten,@diachi,@CMND,@Tel)
END;
GO

EXEC spInsertRow '1',N'Văn A',N'30 Quang Trung','9999999','0123456789';
EXEC spInsertRow '4',N'Văn B',N'60 Quang Trung','9987599','0934567898';
EXEC spInsertRow '5',N'Văn C',N'90 Quang Trung','9978999','9223456789';
GO
/*Cau 3
a.	Tạo thủ tục cập nhật dữ liệu và tất cả các trường ngoài Idkhachhang với điều kiện mã khách hàng có giá id được nhập vào.
b.	Thực thi thủ tục lưu trữ để cập nhật khách hàng có mã số “KH0001” .
*/

CREATE PROC spUpdateDatafortKhachhang
@idkhachhang char(10),@hoten Nvarchar(50),@diachi Nvarchar(50), @CMND Char(13),@Tel Char(10)
AS
   BEGIN
	      UPDATE tKhachHang 
		  SET Hoten=@hoten, Diachi =@diachi, SoCMND=@CMND, Sodienthoai=@Tel
		  WHERE Idkhachhang = @idkhachhang

   END;
GO

  EXEC spUpdateDatafortKhachhang 'KH001',N'Văn D',N'100 Quang Trung','9978999','9223456789';
GO
  /*Cau 4
a.	Tạo thủ tục xoá 1 khách hàng dựa vào mã số.
b.	Thực thi thủ tục lưu trữ để xoá 1 bảng ghi có mã số được nhập vào.
  */

  CREATE PROC spDeleteColumnOfTkhachhang
  @idkhachhang int
  AS
   BEGIN
	      DELETE tKhachHang 
		  WHERE Idkhachhang = @idkhachhang
   END;
GO

   EXEC spDeleteColumnOfTkhachhang 'KH001';
GO

/*Cau 5
a.Tạo thủ tục để tìm kiếm các khách hàng dựa vào tên được nhập và sắp xếp theo thứ tự giảm dần
b.Tao hàm đếm số lượng khách hàng
*/
CREATE PROC spFindInformationBasedOnName
@hoten Nvarchar(50)
AS 
  BEGIN
       SELECT Idkhachhang,Diachi,SoCMND,Sodienthoai
	   FROM tKhachHang
	   WHERE Hoten LIKE'%@hoten'
	   ORDER BY Hoten DESC;
 END;

 GO
 
 CREATE FUNCTION dbo.countKhachhang()
 RETURNS int
 BEGIN
    RETURN (SELECT COUNT(Hoten) 
	        FROM tKhachHang);
 END;
 GO

 SELECT dbo.countKhachhang() AS Sokhachhang;
 GO

 /*Cau 6 Sửa đổi các thủ tục lưu trữ để đưa ra thông báo lỗi trong quá trình thực hiện */
 --Thủ tục câu 2--
 CREATE PROC spInsertRow_Modified 
        @idkhachhang char(10) = NULL,
		@hoten Nvarchar(50)=NULL,
		@diachi Nvarchar(50)=NULL, 
		@CMND Char(13)= NULL,
		@Tel Char(10)=NULL
AS
BEGIN
   IF (@idkhachhang IS NULL) OR (@idkhachhang IN (SELECT idkhachhang FROM tKhachHang))
   THROW 50001, 'Id is not NULL and UNIQUE',1;
   ELSE IF (@hoten IS NULL) OR (Len(@hoten)>50) 
   THROW 50001,'Hoten is not NULL and maximum 50 characters',1;
   ELSE IF (@diachi IS NOT NULL) AND (Len(@diachi)>50) 
   THROW 50001,'Diachi has maximum 50 characters',1;
   ELSE IF ((@CMND IS NOT NULL)) AND (Len(@CMND)>13)
   THROW 50001,'CMND has maximum 13 characters',1;
   ELSE IF (@Tel IS NOT NULL) AND (Len(@Tel)>10) OR (@Tel LIKE '%[^0-9]%')
   THROW 50001,'Sodienthoai has maximum 10 numbers',1; 
   ELSE
   INSERT INTO tKhachHang 
   VALUES (@idkhachhang,@hoten,@diachi,@CMND,@Tel);
END;
GO

--Thủ tục câu 3--
CREATE PROC spUpdateDatafortKhachhang_Modified
@idkhachhang char(10),@hoten Nvarchar(50),@diachi Nvarchar(50), @CMND Char(13),@Tel Char(10)
AS
   BEGIN
	      IF @idkhachhang NOT IN (SELECT idkhachhang FROM tKhachHang)
          THROW 50001, 'Id is not valid',1;
          ELSE IF (@hoten IS NULL) OR (Len(@hoten)>50) 
          THROW 50001,'Hoten is not NULL and maximum 50 characters',1;
          ELSE IF (@diachi IS NOT NULL) AND (Len(@diachi)>50) 
          THROW 50001,'Diachi has maximum 50 characters',1;
          ELSE IF ((@CMND IS NOT NULL)) AND (Len(@CMND)>13)
          THROW 50001,'CMND has maximum 13 characters',1;
          ELSE IF (@Tel IS NOT NULL) AND (Len(@Tel)>10) OR (@Tel LIKE '%[^0-9]%')
          THROW 50001,'Sodienthoai has maximum 10 numbers',1; 
		  ELSE
		     UPDATE tKhachHang 
		     SET Hoten=@hoten, Diachi =@diachi, SoCMND=@CMND, Sodienthoai=@Tel
		     WHERE Idkhachhang = @idkhachhang;

   END;
GO
--Thủ tục câu 4--
 CREATE PROC spDeleteColumnOfTkhachhang_Modified
  @idkhachhang int
  AS
   BEGIN  
          IF @idkhachhang NOT IN (SELECT idkhachhang FROM tKhachHang)
            THROW 50001, 'Id is not valid',1;
	      ELSE
		    DELETE tKhachHang 
		    WHERE Idkhachhang = @idkhachhang;
   END;
GO

--Thủ tục câu 5--
CREATE PROC spFindInformationBasedOnName_Modified
@hoten Nvarchar(50)
AS 
  BEGIN
       IF @hoten NOT IN (SELECT Hoten FROM tKhachHang)
	      PRINT 'Hoten is not in list of customers';
       ELSE
	      SELECT Idkhachhang,Diachi,SoCMND,Sodienthoai
	      FROM tKhachHang
	      WHERE Hoten LIKE'%@hoten'
	      ORDER BY Hoten DESC;
 END;

 GO