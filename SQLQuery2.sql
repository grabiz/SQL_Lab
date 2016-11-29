
CREATE DATABASE Database_QLSK1;
USE Database_QLKS1;
CREATE TABLE tKhachHang(
Idkhachhang char(10) NOT NULL PRIMARY KEY,
Hoten Nvarchar(50) NOT NULL,
Diachi Nvarchar(50),
SoCMND Char(13),
Sodienthoai Char(10) CHECK(Sodienthoai='[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);

/*Cau 2*/

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

/*Cau 3*/

CREATE PROC spUpdateDatafortKhachhang
@idkhachhang int,@hoten Nvarchar(50),@diachi Nvarchar(50), @CMND Char(13),@Tel Char(10)
AS
   BEGIN
       IF EXISTS (SELECT * FROM tKhachHang WHERE Idkhachhang=@idkhachhang)
	      UPDATE tKhachHang 
		  SET Hoten=@hoten, Diachi =@diachi, SoCMND=@CMND, Sodienthoai=@Tel
		  WHERE Idkhachang = @idkhachhang
	  ELSE 
	      PRINT 'Id khách hàng không tồn tại'
   END;

  EXEC spUpdateDatafortKhachhang 'KH001',N'Văn D',N'100 Quang Trung','9978999','9223456789';

  /*Cau 4*/

  CREATE PROC spDeleteColumnOfTkhachhang
  @idkhachhang int
  AS
   BEGIN
       IF EXISTS (SELECT * FROM tKhachHang WHERE Idkhachhang=@idkhachhang)
	      DELETE tKhachHang 
		  WHERE Idkhachhang = @idkhachhang
	  ELSE 
	     PRINT 'Id khách hàng không tồn tại'
   END;

   EXEC spDeleteColumnOfTkhachhang 'KH001';

/*Cau 5*/
CREATE PROC spFindInformationBasedOnName
@hoten Nvarchar(50)
AS 
  BEGIN
       SELECT Idkhachhang,Diachi,SoCMND,Sodienthoai
	   FROM tKhachHang
	   WHERE Hoten LIKE'%@hoten'
	   ORDER BY Hoten DESC;
 END;