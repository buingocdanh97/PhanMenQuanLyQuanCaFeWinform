USE [master]
GO
/****** Object:  Database [QUANCAFFE]    Script Date: 6/21/2018 10:55:49 PM ******/
CREATE DATABASE [QUANCAFFE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QUANCAFFE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QUANCAFFE.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QUANCAFFE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QUANCAFFE_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QUANCAFFE] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QUANCAFFE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QUANCAFFE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QUANCAFFE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QUANCAFFE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QUANCAFFE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QUANCAFFE] SET ARITHABORT OFF 
GO
ALTER DATABASE [QUANCAFFE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QUANCAFFE] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [QUANCAFFE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QUANCAFFE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QUANCAFFE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QUANCAFFE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QUANCAFFE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QUANCAFFE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QUANCAFFE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QUANCAFFE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QUANCAFFE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QUANCAFFE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QUANCAFFE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QUANCAFFE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QUANCAFFE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QUANCAFFE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QUANCAFFE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QUANCAFFE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QUANCAFFE] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QUANCAFFE] SET  MULTI_USER 
GO
ALTER DATABASE [QUANCAFFE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QUANCAFFE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QUANCAFFE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QUANCAFFE] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [QUANCAFFE]
GO
/****** Object:  StoredProcedure [dbo].[P_DELETE_HOADON]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[P_DELETE_HOADON](
@IDHoaDon int
)
AS
BEGIN TRAN
 IF  EXISTS(SELECT RTRIM(IDHoaDon) FROM CTHoaDon WHERE IDHoaDon = @IDHoaDon)
       BEGIN
	      DELETE CTHoaDon WHERE IDHoaDon=@IDHoaDon
	   END

 IF  EXISTS(SELECT RTRIM(IDHoaDon) FROM HoaDon WHERE IDHoaDon = @IDHoaDon)
      BEGIN
	      DELETE HoaDon WHERE IDHoaDon=@IDHoaDon
		  IF (@@ERROR!=0) --CACH CO DIEN
				BEGIN 
					ROLLBACK
					RETURN
			    END
	  END
	  
COMMIT TRAN

GO
/****** Object:  StoredProcedure [dbo].[P_DELETEDOUONG]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[P_DELETEDOUONG](
@IDoUong int
)
AS
BEGIN
DELETE FROM CTHoaDon WHERE IDDoUong=@IDoUong
DELETE FROM DoUong   WHERE IDDoUong=@IDoUong
END
GO
/****** Object:  StoredProcedure [dbo].[P_DSDoUong]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[P_DSDoUong]
AS
SELECT * FROM DoUong
GO
/****** Object:  StoredProcedure [dbo].[P_DSNV]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[P_DSNV]
AS
SELECT * FROM NhanVien
--XOA PROC
GO
/****** Object:  StoredProcedure [dbo].[P_INSERTNHANVIEN]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--INSERT NHAN VIEN
CREATE PROC [dbo].[P_INSERTNHANVIEN](
          @tennv nvarchar(50),
          @ngaysinh Date,
		  @gioitinh bit,
          @noitamtru nvarchar(150),
          @sdt nvarchar(15),
          @quequan nvarchar(150),
          @tendn nvarchar(50),
          @matkhau nvarchar(50),
          @idchucvu nvarchar(50))

AS
BEGIN TRAN
INSERT INTO NhanVien(
         TenNV,
         NgaySinh,
		 GioiTinh,
         NoiTamTru,
         SDT,
         QueQuan,
         TenDN,
         MatKhau,
         IDChucVu
     )
     VALUES(
        @tennv
        ,  @ngaysinh 
		,  @gioitinh
        ,  @noitamtru
        ,  @sdt
        ,  @quequan 
        ,  @tendn 
        ,  @matkhau 
        ,  @idchucvu
        )
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[P_UPDATENHANVIEN]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[P_UPDATENHANVIEN]
(
	@IDNV	int
,@TenNV	nvarchar(50)
,@NgaySinh	date
,@GioiTinh	bit
,@NoiTamTru	nvarchar(150)
,@SDT	nvarchar(15)
,@QueQuan	nvarchar(150)
,@TenDN	nvarchar(50)
,@MatKhau	nvarchar(50)
,@IDChucVu	nvarchar(50)
)
AS

	
BEGIN
	update NhanVien
	SET
	
    TenNV	  =@TenNV
    ,NgaySinh  =@NgaySinh
    ,GioiTinh  =@GioiTinh
    ,NoiTamTru =@NoiTamTru
    ,SDT		  =@SDT
    ,QueQuan	  =@QueQuan
    ,TenDN	  =@TenDN
    ,MatKhau	  =@MatKhau
    ,IDChucVu  =@IDChucVu

		
	where IDNV = @IDNV
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CREATE_HOADON]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CREATE_HOADON] (@IDBan int,@NgayLap date,@IDNhanVienLap int,@TrangThai bit)
AS
BEGIN TRAN
IF  EXISTS(SELECT RTRIM(IDBan) FROM Ban WHERE IDBan = @IDBan AND TrangThai=N'Trống')
	BEGIN
				INSERT INTO HoaDon(IDBan,NgayLap,IDNhanVienLap,TrangThai)
				VALUES(@IDBan,@NgayLap,@IDNhanVienLap,@TrangThai)
				IF (@@ERROR!=0) --CACH CO DIEN
				BEGIN 
					ROLLBACK
					RETURN
			    END
	
		PRINT 'HOA DON DA DUOC TAO'
	END
ELSE
		PRINT 'BAN DUOC CHON KHONG HOP LE'	
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[SP_DANHSACHCTHD]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DANHSACHCTHD](@IDHoaDon int)
AS
SELECT *FROM CTHoaDon WHERE @IDHoaDon=@IDHoaDon 

GO
/****** Object:  StoredProcedure [dbo].[SP_DANHSACHHOADON]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DANHSACHHOADON]
AS
SELECT*FROM HoaDon Where TrangThai=1
GO
/****** Object:  StoredProcedure [dbo].[SP_DELETENHANVIEN]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DELETENHANVIEN]
(
	@IDNV int
)
AS
BEGIN
	DELETE FROM NhanVien
	WHERE IDNV= @IDNV
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DSBan_TH1]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	 CREATE proc [dbo].[SP_DSBan_TH1]
	 as
	 begin tran
	 set transaction isolation level read uncommitted
        select * from Ban
	 commit 
GO
/****** Object:  StoredProcedure [dbo].[SP_DSCT_HD]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DSCT_HD]
AS
SELECT *FROM CTHoaDon
INNER JOIN HoaDon ON CTHoaDon.IDHoaDon=HoaDon.IDHoaDon
 WHERE  HoaDon.TrangThai=1

GO
/****** Object:  StoredProcedure [dbo].[SP_DSCTHD]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DSCTHD]
AS
SELECT*FROM CTHoaDon
GO
/****** Object:  StoredProcedure [dbo].[SP_DSLoai]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DSLoai]
AS
BEGIN 
SELECT*FROM LoaiDoUong
end

GO
/****** Object:  StoredProcedure [dbo].[SP_DSLOAI_TH1]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[SP_DSLOAI_TH1]
	 as
	 begin tran
	 set transaction isolation level read uncommitted
        select * from LoaiDoUong
	 commit 
GO
/****** Object:  StoredProcedure [dbo].[SP_DSLOAI_VIEW]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DSLOAI_VIEW]
AS
BEGIN
SELECT * FROM LoaiDoUong_VIEW
END 
GO
/****** Object:  StoredProcedure [dbo].[SP_DSLOAI_XULY_TH1]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[SP_DSLOAI_XULY_TH1]
	 AS
	 BEGIN TRAN 
	 set transaction isolation level read committed
        select * from LoaiDoUong
	 commit 
GO
/****** Object:  StoredProcedure [dbo].[SP_GOIMON]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GOIMON](@IDHoaDon int,@IDDoUong int,@SoLuong int,@GiaGoc float,@GiaBan float)
AS
BEGIN TRAN
-- Bắt đầu giao dịch
   --Cập nhật số lượng trong tabe DoUông
       IF((SELECT SoLuong From DoUong Where IDDoUong=@IDDoUong)!=0 AND @SoLuong !=0 AND (SELECT SoLuong From DoUong Where IDDoUong=@IDDoUong)>=@SoLuong)
           BEGIN
               UPDATE  DoUong
               SET SoLuong = SoLuong - @SoLuong
              WHERE IDDoUong = @IDDoUong;
           END
	  ELSE
                       
	     IF ((SELECT SoLuong From DoUong Where IDDoUong=@IDDoUong)=0)
		    begin
		      return
		    end
		  ELSE
	        BEGIN
               UPDATE  DoUong
               SET SoLuong = 0
               WHERE IDDoUong = @IDDoUong;
	        END

	 IF NOT EXISTS(Select*from HoaDon where IDHoaDon= @IDHoaDon) 
					BEGIN 
						ROLLBACK
						RETURN
					END
					
       ELSE
   --Neu da ton tai ct hoa don=>update soluong
         IF  EXISTS(Select*from CTHoaDon where IDHoaDon= @IDHoaDon AND IDDoUong=@IDDoUong) 
					BEGIN 
						  UPDATE  CTHoaDon
                          SET SoLuong =SoLuong+ @SoLuong
                          WHERE IDDoUong = @IDDoUong And IDHoaDon=@IDHoaDon;
					END
		
   -- Them mot chi tiet hoa don moi
         ELSE
		           BEGIN 
				        INSERT INTO CTHoaDon(IDHoaDon,IDDoUong,SoLuong,GiaGoc,GiaBan)
                         VALUES (@IDHoaDon, @IDDoUong, @SoLuong,@GiaGoc,@GiaBan)
				   END
   -- Hoàn thành giao dịch
 COMMIT TRAN;

GO
/****** Object:  StoredProcedure [dbo].[SP_READLOAI_TH2]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_READLOAI_TH2]
AS

BEGIN TRAN
  --read a
  select * from LoaiDoUong 
  waitfor delay '00:00:25'
  --read a
  select * from LoaiDoUong
COMMIT
GO
/****** Object:  StoredProcedure [dbo].[SP_READLOAI_TH3]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_READLOAI_TH3]
AS
BEGIN TRAN
  --read a
  select * from LoaiDoUong 
  waitfor delay '00:00:15'
  --read a
  select * from LoaiDoUong
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SP_TEST]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_TEST](@IDHoaDon int,@IDDoUong int,@SoLuong int,@GiaGoc float,@GiaBan float)
AS
BEGIN TRAN
 IF((SELECT SoLuong From DoUong Where IDDoUong=@IDDoUong)!=0 AND @SoLuong !=0 AND (SELECT SoLuong From DoUong Where IDDoUong=@IDDoUong)>=@SoLuong)
      BEGIN
         UPDATE  DoUong
         SET SoLuong = SoLuong - @SoLuong
         WHERE IDDoUong = @IDDoUong;
      END
	ELSE
	  BEGIN
         UPDATE  DoUong
         SET SoLuong = 0
         WHERE IDDoUong = @IDDoUong;
	  END

	   IF NOT EXISTS(Select*from HoaDon where IDHoaDon= @IDHoaDon) 
					BEGIN 
						ROLLBACK
						RETURN
					END
					
   ELSE
   --Neu da ton tai hoa don=>update soluong
         IF  EXISTS(Select*from CTHoaDon where IDHoaDon= @IDHoaDon) 
					BEGIN 
						  UPDATE  CTHoaDon
                          SET SoLuong =SoLuong+ @SoLuong
                          WHERE IDDoUong = @IDDoUong And IDHoaDon=@IDHoaDon;
					END
		
   -- Them mot chi tiet hoa don moi
         ELSE
		           BEGIN 
				        INSERT INTO CTHoaDon(IDHoaDon,IDDoUong,SoLuong,GiaGoc,GiaBan)
                         VALUES (@IDHoaDon, @IDDoUong, @SoLuong,10,10)
				   END
   -- Hoàn thành giao dịch
COMMIT TRAN


GO
/****** Object:  StoredProcedure [dbo].[SP_TH4_T1]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_TH4_T1] (@ID int,@tenloai nvarchar(50))
AS
BEGIN TRAN
  DECLARE @ten nvarchar(50);
  --read a
  select @ten=TenLoai FROM LoaiDoUong wHERE IDLoai=@ID
  waitfor delay '00:00:15'
  --write a
  SET @ten=@tenloai
  update LoaiDoUong set TenLoai=@tenloai where IDLoai=@ID;
   print 'ten sau khi cap nhat= '+@ten;
COMMIT
GO
/****** Object:  StoredProcedure [dbo].[SP_TH4_T2]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_TH4_T2] (@ID int,@tenloai nvarchar(50))
AS
BEGIN TRAN
  DECLARE @ten nvarchar(50);
  --read a
  select @ten=TenLoai FROM LoaiDoUong wHERE IDLoai=@ID
  --write a
  SET @ten=@tenloai
  update LoaiDoUong set TenLoai=@tenloai where IDLoai=@ID;
   print 'ten sau khi cap nhat = '+@ten;
COMMIT
GO
/****** Object:  StoredProcedure [dbo].[SP_TH4_XULY_T1]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_TH4_XULY_T1] (@ID int,@tenloai nvarchar(50))
AS
set transaction isolation level repeatable read 
begin try
BEGIN TRAN

  DECLARE @ten nvarchar(50);
  --read a
  select @ten=TenLoai FROM LoaiDoUong wHERE IDLoai=@ID
  waitfor delay '00:00:15'
  --write a
  
  SET @ten=@tenloai
  update LoaiDoUong set TenLoai=@tenloai where IDLoai=@ID;
   print 'Ten sau khi cap nhat = '+@ten;
COMMIT
end try
BEGIN CATCH
 PRINT 'Công việc đang được thực hiện bới người dùn khác, hãy thử lại sau';
 ROLLBACK
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[SP_TH4_XULY_T2]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_TH4_XULY_T2] (@ID int,@tenloai nvarchar(50))
AS
set transaction isolation level repeatable read 
BEGIN TRY
BEGIN TRAN
  DECLARE @ten nvarchar(50);
  --read a
  select @ten=TenLoai FROM LoaiDoUong WHERE IDLoai=@ID
  waitfor delay '00:00:15'
  --write a
  
  SET @ten=@tenloai
  update LoaiDoUong set TenLoai=@tenloai where IDLoai=@ID;
  print 'ten loai sau khi cap nhat = '+@ten;
COMMIT
END TRY
BEGIN CATCH
 PRINT 'Công việc đang được thực hiện bới người dùn khác, hãy thử lại sau';
 ROLLBACK
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_TimBan]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_TimBan](@idban int)
as
BEGIN TRAN
SELECT* FROM Ban WHERE IDBan=@idban
COMMIT
GO
/****** Object:  StoredProcedure [dbo].[SP_TIMHOADON]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_TIMHOADON]
@IDHD INT
AS
SELECT*FROM HoaDon Where IDHoaDon=@IDHD
GO
/****** Object:  StoredProcedure [dbo].[SP_TIMNHANVIEN]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_TIMNHANVIEN]
@IDNhanVien int
AS
BEGIN
SELECT *FROM NhanVien WHERE IDNV=@IDNhanVien
END
GO
/****** Object:  StoredProcedure [dbo].[SP_TimTaiKkhoan]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_TimTaiKkhoan] @tendn nvarchar(50)
AS
BEGIN
SELECT *FROM NhanVien WHERE TenDN=@tendn;
END

GO
/****** Object:  StoredProcedure [dbo].[SP_TONGTIENCTHD]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_TONGTIENCTHD]
AS
BEGIN TRAN
				SELECT SUM(GiaBan*SoLuong) FROM CTHoaDon LEFT JOIN HoaDon ON CTHoaDon.IDHoaDon=HoaDon.IDHoaDon  Where HoaDon.TrangThai=1
COMMIT TRAN

GO
/****** Object:  StoredProcedure [dbo].[SP_TONGTIENHD]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_TONGTIENHD]
@IDHoaDon int
AS
BEGIN TRAN
	IF EXISTS(SELECT * FROM CTHoaDon WHERE IDHoaDon = @IDHoaDon)
	BEGIN
			SELECT SUM(GiaBan*SoLuong) FROM CTHoaDon WHERE  IDHoaDon=@IDHoaDon
	END
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDAELOAI_TH1]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_UPDAELOAI_TH1](@id int,@tenloai nvarchar(50))
	AS
	 BEGIN TRAN
	 --write a
        UPDATE LoaiDoUong set TenLoai=@tenloai where IDLoai=@id
        waitfor delay '00:00:10'
	 IF (ISNUMERIC(@tenloai)=1)
		BEGIN
		 print 'Ten loai khong hop le, cap nhat that bai';
		 ROLLBACK
		 RETURN
		END
     COMMIT 

GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_BAN]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_UPDATE_BAN](@idban int,@tenban nvarchar(50),@trangthai nvarchar(50))
AS
	 BEGIN TRAN
	 --write a
	 IF ((SELECT TenBan FROM Ban WHERE IDBan=@idban)!=@tenban OR (SELECT TenBan FROM Ban WHERE IDBan=@idban)!=@trangthai)
        BEGIN
		UPDATE Ban set TrangThai=@trangthai,TenBan=@tenban where IDBan=@idban
        waitfor delay '00:00:15'
		END
	 ELSE
		BEGIN
		 print 'Không cần update nhé';
		 ROLLBACK
		 RETURN
		END
   
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_HOADON]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_UPDATE_HOADON] ( @idhd int, @idban int,@ngaylap date,@idnhanvien int,@tranghthai bit)  /*Cập nhật (Sửa) món ăn*/
AS
BEGIN TRAN
	IF NOT EXISTS(SELECT RTRIM(IDHoaDon) FROM HoaDon WHERE @idhd =IDHoaDon)
		PRINT 'HD  BAN MUON SUA KHONG TON TAI TRONG DANH SACH'
	ELSE
		BEGIN
				UPDATE HoaDon SET
				      IDBan = @idban,
					  NgayLap=@ngaylap,
					  IDNhanVienLap=@idnhanvien,
					  TrangThai=@tranghthai
				WHERE IDHoaDon = @idhd
				IF (@@ERROR!=0) 
				BEGIN 
					ROLLBACK
					RETURN
				END
		END
COMMIT TRAN

GO
/****** Object:  StoredProcedure [dbo].[SP_WRITELOAI_TH2]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_WRITELOAI_TH2](@id int,@ten nvarchar(50))
	as
	 begin tran
	 --write a
        update LoaiDoUong set TenLoai=@ten where IDLoai=@id
     commit 
GO
/****** Object:  StoredProcedure [dbo].[SP_WRITELOAI_TH3]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_WRITELOAI_TH3](@ten nvarchar(50))
	as
	 begin tran
	 --write a
        INSERT INTO LoaiDoUong(TenLoai) VALUES(@ten)
     commit 
GO
/****** Object:  StoredProcedure [dbo].[SP_XULY_TH2]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_XULY_TH2]
AS
set transaction isolation level repeatable read 
BEGIN TRAN
 
  --read a
  select * from LoaiDoUong
  waitfor delay '00:00:20'
  --read a
  select * from LoaiDoUong
COMMIT

GO
/****** Object:  StoredProcedure [dbo].[SP_XULY_TH3]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_XULY_TH3]
AS
set transaction isolation level serializable 
BEGIN TRAN
  --read a
  select * from LoaiDoUong
  waitfor delay '00:00:15'
  --read a
  select * from LoaiDoUong
COMMIT

GO
/****** Object:  UserDefinedFunction [dbo].[Thong_Ke_Doanh_Thu_Theo_Ngay]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Thong_Ke_Doanh_Thu_Theo_Ngay]
(
	@ngay date
)
returns float
begin

	declare @tt float;
	 SELECT   @tt=SUM(CTHoaDon.GiaBan*CTHoaDon.SoLuong)  FROM HoaDon
    INNER JOIN CTHoaDon ON HoaDon.IDHoaDon=CTHoaDon.IDHoaDon
     WHERE HoaDon.NgayLap=@ngay and HoaDon.TrangThai=1
	return @tt;
	
end
GO
/****** Object:  UserDefinedFunction [dbo].[Tim_Hoa_Don]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create function [dbo].[Tim_Hoa_Don]
(
	@IDHD int
)
returns bit
begin

IF EXISTS (SELECT * FROM HoaDon WHERE IDHoaDon=@IDHD)

 BEGIN
  
   RETURN 1; 
 END
 --KHONG TIM THAY
   return 0;

end

GO
/****** Object:  UserDefinedFunction [dbo].[TONG_TIEN]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[TONG_TIEN]
(
	@MAHD int
)
returns float
begin

	declare @tt float;
	SELECT @tt=SUM(CTHoaDon.GiaBan*CTHOADON.SoLuong) 
	FROM CTHOADON 
	WHERE CTHoaDon.IDHoaDon=@MAHD
	return @tt;
	
end
GO
/****** Object:  Table [dbo].[Ban]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ban](
	[IDBan] [int] IDENTITY(1,1) NOT NULL,
	[TenBan] [nvarchar](50) NOT NULL,
	[TrangThai] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Ban] PRIMARY KEY CLUSTERED 
(
	[IDBan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChucVu]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChucVu](
	[IDChucVu] [nvarchar](50) NOT NULL,
	[TenChucVu] [nvarchar](50) NOT NULL,
	[MoTa] [nchar](10) NULL,
 CONSTRAINT [PK_ChucVu] PRIMARY KEY CLUSTERED 
(
	[IDChucVu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CTHoaDon]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTHoaDon](
	[IDHoaDon] [int] NOT NULL,
	[IDDoUong] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[GiaGoc] [float] NOT NULL,
	[GiaBan] [float] NOT NULL,
 CONSTRAINT [PK_CTHoaDon] PRIMARY KEY CLUSTERED 
(
	[IDHoaDon] ASC,
	[IDDoUong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DoUong]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoUong](
	[IDDoUong] [int] IDENTITY(1,1) NOT NULL,
	[TenDoUong] [nvarchar](50) NOT NULL,
	[IDLoai] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[GiaGoc] [float] NOT NULL,
	[GiaBan] [float] NOT NULL,
	[NgayNhapHang] [date] NULL,
	[DonViTinh] [nvarchar](50) NULL,
 CONSTRAINT [PK_DoUong] PRIMARY KEY CLUSTERED 
(
	[IDDoUong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[IDHoaDon] [int] IDENTITY(1,1) NOT NULL,
	[IDBan] [int] NOT NULL,
	[NgayLap] [date] NOT NULL,
	[IDNhanVienLap] [int] NOT NULL,
	[TrangThai] [bit] NOT NULL,
 CONSTRAINT [PK_HoaDon] PRIMARY KEY CLUSTERED 
(
	[IDHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LoaiDoUong]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiDoUong](
	[IDLoai] [int] IDENTITY(1,1) NOT NULL,
	[TenLoai] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_LoaiDoUong] PRIMARY KEY CLUSTERED 
(
	[IDLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[IDNV] [int] IDENTITY(1,1) NOT NULL,
	[TenNV] [nvarchar](50) NOT NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [bit] NULL,
	[NoiTamTru] [nvarchar](150) NULL,
	[SDT] [nvarchar](15) NOT NULL,
	[QueQuan] [nvarchar](150) NULL,
	[TenDN] [nvarchar](50) NOT NULL,
	[MatKhau] [nvarchar](50) NOT NULL,
	[IDChucVu] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[IDNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Quyen]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quyen](
	[IDChucVu] [nvarchar](50) NOT NULL,
	[TenTab] [nvarchar](50) NOT NULL,
	[Them] [bit] NOT NULL,
	[Xoa] [bit] NOT NULL,
	[Sua] [bit] NOT NULL,
 CONSTRAINT [PK_Quyen] PRIMARY KEY CLUSTERED 
(
	[IDChucVu] ASC,
	[TenTab] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tab]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tab](
	[TenTab] [nvarchar](50) NOT NULL,
	[MoTa] [text] NULL,
	[IsAdmin] [bit] NOT NULL,
 CONSTRAINT [PK_Tab] PRIMARY KEY CLUSTERED 
(
	[TenTab] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[DOUONG_VIEW]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DOUONG_VIEW] AS
SELECT IDDoUong,TenDoUong 
FROM  douong

WITH CHECK OPTION;
GO
/****** Object:  View [dbo].[LOAIDOUONG_VIEW]    Script Date: 6/21/2018 10:55:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LOAIDOUONG_VIEW] AS
SELECT IDLoai,TenLoai 
FROM  LoaiDoUong
WHERE TenLoai IS NOT NULL
WITH CHECK OPTION;
GO
SET IDENTITY_INSERT [dbo].[Ban] ON 

INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (27, N'Bàn 01', N'Có người')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (28, N'Bàn 02', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (29, N'Bàn 03', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (30, N'Bàn 04', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (31, N'Bàn 05', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (32, N'Bàn 06', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (33, N'Bàn 07', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (34, N'Bàn 08', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (35, N'Bàn 09', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (36, N'Bàn 10', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (37, N'Bàn 11', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (38, N'Bàn 12', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (39, N'Bàn 13', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (40, N'Bàn 14', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (41, N'Bàn 15', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (42, N'Bàn 16', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (43, N'Bàn 17', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (44, N'Bàn 18', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (45, N'Bàn 19', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (46, N'Bàn 20', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (47, N'Bàn 21', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (48, N'Bàn 22', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (49, N'Bàn 23', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (50, N'Bàn 24', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (53, N'Ban n', N'Trống')
INSERT [dbo].[Ban] ([IDBan], [TenBan], [TrangThai]) VALUES (54, N'Ban a', N'Trống')
SET IDENTITY_INSERT [dbo].[Ban] OFF
INSERT [dbo].[ChucVu] ([IDChucVu], [TenChucVu], [MoTa]) VALUES (N'CV1', N'Admin', N'Quản lý   ')
INSERT [dbo].[ChucVu] ([IDChucVu], [TenChucVu], [MoTa]) VALUES (N'CV2', N'Thu Ngân', N'Thu ngân  ')
INSERT [dbo].[ChucVu] ([IDChucVu], [TenChucVu], [MoTa]) VALUES (N'CV3', N'Thủ kho', N'thu kho   ')
INSERT [dbo].[ChucVu] ([IDChucVu], [TenChucVu], [MoTa]) VALUES (N'CV4', N'Admin', N'Quản lý   ')
INSERT [dbo].[ChucVu] ([IDChucVu], [TenChucVu], [MoTa]) VALUES (N'CV5', N'Phục vụ', N'Phụ bàn   ')
INSERT [dbo].[ChucVu] ([IDChucVu], [TenChucVu], [MoTa]) VALUES (N'CV6', N'Bảo vệ', N'AAAAAA    ')
INSERT [dbo].[ChucVu] ([IDChucVu], [TenChucVu], [MoTa]) VALUES (N'CV7', N'Pha chế', N'Pha chế   ')
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2205, 21, 224, 10000, 1)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2205, 22, 402, 50000, 15000)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2205, 23, 2, 4000, 8000)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2205, 24, 3, 4000, 10000)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2205, 27, 1, 20000, 40000)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2205, 29, 1, 10000, 20000)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2205, 30, 1, 16000, 28000)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2206, 21, 2, 10000, 1)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2207, 21, 1, 10000, 1)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2208, 21, 14, 10000, 1)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2208, 22, 3, 10, 10)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2208, 25, 2, 10000, 20000)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2208, 28, 2, 10, 10)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2208, 32, 1, 20000, 40000)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2208, 37, 1, 7000, 20000)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2209, 21, 2, 10000, 1)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2209, 25, 1, 10000, 25000)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2210, 21, 1, 10000, 1)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2211, 21, 1, 10000, 1)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2213, 21, 1, 10000, 1)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2213, 23, 1, 4000, 8000)
INSERT [dbo].[CTHoaDon] ([IDHoaDon], [IDDoUong], [SoLuong], [GiaGoc], [GiaBan]) VALUES (2213, 25, 1, 10000, 25000)
SET IDENTITY_INSERT [dbo].[DoUong] ON 

INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (21, N'Numbe  rone', 2, 758, 10000, 1, CAST(N'2018-04-24' AS Date), N'Chai')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (22, N'Pessi', 2, 97, 50000, 15000, CAST(N'2018-04-20' AS Date), N'Lon')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (23, N'chanh dây', 7, 99, 4000, 8000, CAST(N'2018-04-20' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (24, N'Sửa chua', 2, 100, 4000, 10000, CAST(N'2018-04-20' AS Date), N'Hộp')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (25, N'Sinh tố  dâu', 1, 97, 10000, 25000, CAST(N'2018-04-20' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (26, N'Sinh tố dừa', 1, 100, 10000, 20000, CAST(N'2018-04-20' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (27, N'cà phê sửa', 3, 100, 20000, 40000, CAST(N'2018-04-20' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (28, N'Sinh tố mảng cầu', 1, 98, 15000, 30000, CAST(N'2018-04-20' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (29, N'Sinh tố dưa', 1, 100, 10000, 20000, CAST(N'2018-04-20' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (30, N'Bò húc', 2, 99, 16000, 28000, CAST(N'2018-04-20' AS Date), N'Lon')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (32, N' Cà phê rang xay', 3, 99, 20000, 40000, CAST(N'2018-04-20' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (33, N'Cà phê hạt nguyên chất', 3, 100, 30000, 60000, CAST(N'2018-04-20' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (36, N'Trà sửa thập cẩm', 4, 100, 10000, 20000, CAST(N'2018-04-20' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (37, N'chanh ép  ', 1, 99, 7000, 20000, CAST(N'2018-04-20' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (38, N'Cà phê tươi', 1, 100, 15000, 30000, CAST(N'2018-04-20' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (39, N' nước dừa', 1, 100, 10000, 15000, CAST(N'2018-04-20' AS Date), N'Trai')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (76, N'Trà xanh 0 độ', 2, 100, 10000, 20000, CAST(N'2018-04-20' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (77, N'Cà phê hòa tan G7', 3, 100, 400000, 800000, CAST(N'2018-04-20' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (78, N'Coca cola', 2, 100, 10000, 20000, CAST(N'2018-04-20' AS Date), N'Lon')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (79, N'Sting dâu', 2, 100, 10000, 20000, CAST(N'2018-04-20' AS Date), N'Lon')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (82, N'Trà xanh c2', 2, 100, 6000, 15000, CAST(N'2018-04-20' AS Date), N'Chai')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (83, N'Trà bí đô', 2, 100, 6000, 15000, CAST(N'2018-04-20' AS Date), N'Lon')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (84, N'Chè  thập cẩm', 9, 100, 10000, 20000, CAST(N'2018-04-08' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (85, N'Chè  trái cây', 9, 100, 10000, 20000, CAST(N'2018-04-08' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (86, N'Chè  thái', 9, 100, 10000, 20000, CAST(N'2018-04-08' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (87, N'Kem hoa hồng', 8, 100, 10000, 20000, CAST(N'2018-04-08' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (99, N'Kem hoa hồng', 8, 100, 10000, 20000, CAST(N'2018-04-08' AS Date), N'Ly')
INSERT [dbo].[DoUong] ([IDDoUong], [TenDoUong], [IDLoai], [SoLuong], [GiaGoc], [GiaBan], [NgayNhapHang], [DonViTinh]) VALUES (101, N'Chè  thái', 9, 100, 10000, 20000, CAST(N'2018-04-08' AS Date), N'Ly')
SET IDENTITY_INSERT [dbo].[DoUong] OFF
SET IDENTITY_INSERT [dbo].[HoaDon] ON 

INSERT [dbo].[HoaDon] ([IDHoaDon], [IDBan], [NgayLap], [IDNhanVienLap], [TrangThai]) VALUES (2205, 31, CAST(N'2018-06-06' AS Date), 68, 1)
INSERT [dbo].[HoaDon] ([IDHoaDon], [IDBan], [NgayLap], [IDNhanVienLap], [TrangThai]) VALUES (2206, 27, CAST(N'2018-06-07' AS Date), 68, 1)
INSERT [dbo].[HoaDon] ([IDHoaDon], [IDBan], [NgayLap], [IDNhanVienLap], [TrangThai]) VALUES (2207, 27, CAST(N'2018-06-07' AS Date), 68, 1)
INSERT [dbo].[HoaDon] ([IDHoaDon], [IDBan], [NgayLap], [IDNhanVienLap], [TrangThai]) VALUES (2208, 27, CAST(N'2018-06-09' AS Date), 68, 1)
INSERT [dbo].[HoaDon] ([IDHoaDon], [IDBan], [NgayLap], [IDNhanVienLap], [TrangThai]) VALUES (2209, 28, CAST(N'2018-06-17' AS Date), 68, 0)
INSERT [dbo].[HoaDon] ([IDHoaDon], [IDBan], [NgayLap], [IDNhanVienLap], [TrangThai]) VALUES (2210, 29, CAST(N'2018-06-17' AS Date), 68, 1)
INSERT [dbo].[HoaDon] ([IDHoaDon], [IDBan], [NgayLap], [IDNhanVienLap], [TrangThai]) VALUES (2211, 30, CAST(N'2018-06-17' AS Date), 68, 1)
INSERT [dbo].[HoaDon] ([IDHoaDon], [IDBan], [NgayLap], [IDNhanVienLap], [TrangThai]) VALUES (2212, 31, CAST(N'2018-06-17' AS Date), 68, 1)
INSERT [dbo].[HoaDon] ([IDHoaDon], [IDBan], [NgayLap], [IDNhanVienLap], [TrangThai]) VALUES (2213, 27, CAST(N'2018-06-21' AS Date), 68, 0)
SET IDENTITY_INSERT [dbo].[HoaDon] OFF
SET IDENTITY_INSERT [dbo].[LoaiDoUong] ON 

INSERT [dbo].[LoaiDoUong] ([IDLoai], [TenLoai]) VALUES (1, N'truong hop 4 t2')
INSERT [dbo].[LoaiDoUong] ([IDLoai], [TenLoai]) VALUES (2, N'Nu?c ng?t')
INSERT [dbo].[LoaiDoUong] ([IDLoai], [TenLoai]) VALUES (3, N'Cà phê')
INSERT [dbo].[LoaiDoUong] ([IDLoai], [TenLoai]) VALUES (4, N'Trà Sửa')
INSERT [dbo].[LoaiDoUong] ([IDLoai], [TenLoai]) VALUES (7, N'Mới cập nhật')
INSERT [dbo].[LoaiDoUong] ([IDLoai], [TenLoai]) VALUES (8, N'Kem')
INSERT [dbo].[LoaiDoUong] ([IDLoai], [TenLoai]) VALUES (9, N'Chè')
INSERT [dbo].[LoaiDoUong] ([IDLoai], [TenLoai]) VALUES (13, N'category4')
INSERT [dbo].[LoaiDoUong] ([IDLoai], [TenLoai]) VALUES (14, N'Sinh Tố')
INSERT [dbo].[LoaiDoUong] ([IDLoai], [TenLoai]) VALUES (50, N'Them moi TH3')
INSERT [dbo].[LoaiDoUong] ([IDLoai], [TenLoai]) VALUES (52, N'Them moi TH3')
SET IDENTITY_INSERT [dbo].[LoaiDoUong] OFF
SET IDENTITY_INSERT [dbo].[NhanVien] ON 

INSERT [dbo].[NhanVien] ([IDNV], [TenNV], [NgaySinh], [GioiTinh], [NoiTamTru], [SDT], [QueQuan], [TenDN], [MatKhau], [IDChucVu]) VALUES (68, N'Admin', CAST(N'2018-04-08' AS Date), 1, N'H? chí minh', N'0162894xxxx', N'', N'admin', N'123', N'CV1')
INSERT [dbo].[NhanVien] ([IDNV], [TenNV], [NgaySinh], [GioiTinh], [NoiTamTru], [SDT], [QueQuan], [TenDN], [MatKhau], [IDChucVu]) VALUES (75, N'Thu kho', CAST(N'1997-10-10' AS Date), 1, N'Noi tam tru', N'SDT', N'', N'user1', N'123', N'CV3')
SET IDENTITY_INSERT [dbo].[NhanVien] OFF
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV1', N'tpPhanQuyen', 1, 1, 1)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV1', N'tpQLBan', 1, 1, 1)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV1', N'tpQLHD', 1, 1, 1)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV1', N'tpQLLoai', 1, 1, 1)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV1', N'tpQLNV', 1, 1, 1)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV1', N'tpQLSP', 1, 1, 1)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV2', N'tpPhanQuyen', 1, 1, 1)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV2', N'tpQLBan', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV2', N'tpQLHD', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV2', N'tpQLLoai', 1, 1, 1)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV2', N'tpQLNV', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV2', N'tpQLSP', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV3', N'tpPhanQuyen', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV3', N'tpQLBan', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV3', N'tpQLHD', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV3', N'tpQLLoai', 0, 0, 1)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV3', N'tpQLNV', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV3', N'tpQLSP', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV4', N'tpPhanQuyen', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV4', N'tpQLBan', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV4', N'tpQLHD', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV4', N'tpQLLoai', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV4', N'tpQLNV', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV4', N'tpQLSP', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV5', N'tpPhanQuyen', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV5', N'tpQLBan', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV5', N'tpQLHD', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV5', N'tpQLLoai', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV5', N'tpQLNV', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV5', N'tpQLSP', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV6', N'tpPhanQuyen', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV6', N'tpQLBan', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV6', N'tpQLHD', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV6', N'tpQLLoai', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV6', N'tpQLNV', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV6', N'tpQLSP', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV7', N'tpPhanQuyen', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV7', N'tpQLBan', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV7', N'tpQLHD', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV7', N'tpQLLoai', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV7', N'tpQLNV', 0, 0, 0)
INSERT [dbo].[Quyen] ([IDChucVu], [TenTab], [Them], [Xoa], [Sua]) VALUES (N'CV7', N'tpQLSP', 0, 0, 0)
INSERT [dbo].[Tab] ([TenTab], [MoTa], [IsAdmin]) VALUES (N'tpPhanQuyen', N'Phan quyen', 1)
INSERT [dbo].[Tab] ([TenTab], [MoTa], [IsAdmin]) VALUES (N'tpQLBan', N'Quan ly ban', 1)
INSERT [dbo].[Tab] ([TenTab], [MoTa], [IsAdmin]) VALUES (N'tpQLHD', N'Quan ly hoa don', 1)
INSERT [dbo].[Tab] ([TenTab], [MoTa], [IsAdmin]) VALUES (N'tpQLLoai', N'Quan ly loai', 1)
INSERT [dbo].[Tab] ([TenTab], [MoTa], [IsAdmin]) VALUES (N'tpQLNV', N'Quan ly nhan vien', 1)
INSERT [dbo].[Tab] ([TenTab], [MoTa], [IsAdmin]) VALUES (N'tpQLSP', N'Quan ly san pham', 1)
ALTER TABLE [dbo].[CTHoaDon]  WITH CHECK ADD  CONSTRAINT [FK_CTHoaDon_DoUong] FOREIGN KEY([IDDoUong])
REFERENCES [dbo].[DoUong] ([IDDoUong])
GO
ALTER TABLE [dbo].[CTHoaDon] CHECK CONSTRAINT [FK_CTHoaDon_DoUong]
GO
ALTER TABLE [dbo].[CTHoaDon]  WITH CHECK ADD  CONSTRAINT [FK_CTHoaDon_HoaDon1] FOREIGN KEY([IDHoaDon])
REFERENCES [dbo].[HoaDon] ([IDHoaDon])
GO
ALTER TABLE [dbo].[CTHoaDon] CHECK CONSTRAINT [FK_CTHoaDon_HoaDon1]
GO
ALTER TABLE [dbo].[DoUong]  WITH CHECK ADD  CONSTRAINT [FK_DoUong_LoaiDoUong] FOREIGN KEY([IDLoai])
REFERENCES [dbo].[LoaiDoUong] ([IDLoai])
GO
ALTER TABLE [dbo].[DoUong] CHECK CONSTRAINT [FK_DoUong_LoaiDoUong]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_Ban] FOREIGN KEY([IDBan])
REFERENCES [dbo].[Ban] ([IDBan])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_Ban]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_NhanVien] FOREIGN KEY([IDNhanVienLap])
REFERENCES [dbo].[NhanVien] ([IDNV])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_NhanVien]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_ChucVu] FOREIGN KEY([IDChucVu])
REFERENCES [dbo].[ChucVu] ([IDChucVu])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NhanVien_ChucVu]
GO
ALTER TABLE [dbo].[Quyen]  WITH CHECK ADD  CONSTRAINT [FK_Quyen_Tab] FOREIGN KEY([TenTab])
REFERENCES [dbo].[Tab] ([TenTab])
GO
ALTER TABLE [dbo].[Quyen] CHECK CONSTRAINT [FK_Quyen_Tab]
GO
USE [master]
GO
ALTER DATABASE [QUANCAFFE] SET  READ_WRITE 
GO
