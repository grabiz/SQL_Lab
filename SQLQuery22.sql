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
GO
/*Cau 3*/

CREATE PROC spUpdateDatafortKhachhang
@idkhachhang char(10),@hoten Nvarchar(50),@diachi Nvarchar(50), @CMND Char(13),@Tel Char(10)
AS
   BEGIN
       IF EXISTS (SELECT * FROM tKhachHang WHERE Idkhachhang=@idkhachhang)
	      UPDATE tKhachHang 
		  SET Hoten=@hoten, Diachi =@diachi, SoCMND=@CMND, Sodienthoai=@Tel
		  WHERE Idkhachhang = @idkhachhang
	  ELSE 
	      PRINT 'Id khách hàng không tồn tại'
   END;
GO
  EXEC spUpdateDatafortKhachhang 'KH001',N'Văn D',N'100 Quang Trung','9978999','9223456789';
GO
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
GO
   EXEC spDeleteColumnOfTkhachhang 'KH001';
GO
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
 GO
 
 CREATE FUNCTION countKhachhang()
 RETURNS int
 BEGIN
    RETURN (SELECT COUNT(Hoten)
	        FROM tKhachHang);
 END;
 GO

 SELECT dbo.countKhachhang();
 GO

 /*Cau 6*/