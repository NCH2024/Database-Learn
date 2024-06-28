	/*	PHAN 1:
		Tạo CSDL quản lý hàng hóa gồm các quan hệ sau:
	KHACHHANG (MAKH , HOTEN, DCHI, SODT, NGSINH, DOANHSO, NGDK)
	NHANVIEN (MANHV, HOTEN, NGVL, SODT)
	SANPHAM (MASP, TENSP, DVL, NUOCSX, GIA)
	HOADON (SOHD, NGHD, #MAKH, #MANV, TRIGIA)
	CTHD (#SOHD,#MASP, SL)
	*/

	-- Create DATABASE & use them
		Create database QLHangHoa
		USE QLHangHoa

	-- create TABLE KHANCHHANG
	Create Table KHACHHANG
		(
			MAKH	char(4)			not null,
			HOTEN	varchar(40)		not null,
			DCHI	varchar(50)		not null,
			SODT	varchar(20)		not null,
			NGSINH	smalldatetime	not null,
			DOANHSO	money			not null,
			NGDK	smalldatetime	not null,
			Constraint	PK_KHACHHANG	Primary key	(MAKH)
		);
	-- create TABLE NHANVIEN
	Create Table NHANVIEN
		(
			MANV	char(4)			not null,
			HOTEN	varchar(40)		not null,
			SODT	varchar(20)		not null,
			NGVL	smalldatetime	not null,
			Constraint	PK_NHANVIEN	Primary key	(MANV)
		);
	-- create TABLE SANPHAM
	Create Table SANPHAM
		(
			MASP	char(4)			not null,
			TENSP	varchar(40)		not null,
			DVT		varchar(20)		not null,
			NUOCSX	varchar(40)		not null,
			GIA		money			not null,
			Constraint	PK_SANPHAM	Primary Key	(MASP)
		);
	--Create TABLE HOADON
	Create Table HOADON
		(
			SOHD	int				not null,
			NGHD	smalldatetime	not null,
			MAKH	char(4)			not null,
			MANV	char(4)			not null,
			TRIGIA	money			not null,
			Constraint	PK_HOADON			Primary Key	(SOHD),
			Constraint	FK_HOADON_KHACHHANG	Foreign Key (MAKH)
				references KHACHHANG (MAKH)
				on delete cascade
				on update cascade,
			Constraint	FK_HOADON_NHANVIEN	Foreign Key (MANV)
				references	NHANVIEN (MANV)
				on delete cascade
				on update cascade
		);
	-- create TABLE CTHD
	Create Table CTHD
		(
			SOHD	int			not null,
			MASP	char(4)		not null,
			SL		int			not null,
			Constraint	PK_CTHD	primary Key (SOHD, MASP),
			Constraint	FK_CTHD_HOADON 	Foreign Key (SOHD)
				references HOADON (SOHD)
				on delete cascade
				on update cascade,
			Constraint	FK_CTHD_SANPHAM	Foreign Key (MASP)
				references SANPHAM (MASP)
				on delete cascade
				on update cascade,
		)
	--2. Them vao thuoc tinh GHICHU vao bang SANPHAM
	Alter table SANPHAM
	add	GHICHU	varchar(20)		not null;
	--3. Them vao thuoc tinh LOAIKH cho bang KHACHHANG
	Alter table KHACHHANG
	add	LOAIKH	tinyint 
	--4. Sua kieu thuoc tinh GHICHU thanh varchar(100) trong bang SANPHAM
	Alter table SANPHAM
		alter column GHICHU	varchar(100)	not null;
	--5. Xoa thuoc tinh GHICHU tron bang SANPHAM
	Alter table SANPHAM
		Drop column GHICHU;
	-- 6. Cai dat thuoc tinh LOAIKH trong bang KHACHHANG
	Alter table KHACHHANG
	add	constraint C_LOAIKH	check (LOAIKH in ('Vang lai', 'Thuong xuyen', 'Vip',null));
	--7. rang buoc DVT cho bang SANPHAM
	Alter table SANPHAM
	add	constraint C_DVT Check (DVT in('cay','hop','cai','quyen','chuc'));
	--8. Gia ban tu 500 dong tro len
	Alter table SANPHAM
	add constraint C_GIA	check (Gia >= 500)

	ALTER TABLE KHACHHANG1
	ALTER COLUMN LOAIKH VARCHAR(20)
	--PHAN 2: NHAP DU LIEU
	INSERT INTO NHANVIEN(MANV,HOTEN,SODT,NGVL) VALUES
		('NV01','Nguen Nhu Nhut','0927345678','4/11/2006'),
		('NV02','Le Thi Phi Yen','0987567390','4/21/2006'),
		('NV03','Nguyen Van B','0997047382','4/27/2006'),
		('NV04','Ngo Thanh Tuan','0913758498','6/24/2006'),
		('NV05','Ngo Thi Truc Thanh','091859038','7/20/2006')
	INSERT INTO KHACHHANG(MAKH,HOTEN,DCHI,SODT,NGSINH,DOANHSO,NGDK) VALUES
		('KH01','Nguyen Van A','731 Tran Hung Dao, Q5, Tp HCM','08823451','1/22/1960',1060000,'7/2/2006'),
		('KH02','Tran Ngoc Han','23/5 Nguyen Trai,Q5, TpHCM','0908256478','4/3/1974',280000,'7/3/2006'),
		('KH03','Tran Ngoc Linh','45 Nguyen Canh Chan, Q1, TpHCM','0938776266','6/12/1980',3860000,'8/5/2006'),
		('KH04','Tran Minh Long','50/34 Le Dai Hanh, Q10, TpHCM','0917325476','3/9/1965',250000,'10/2/2006'),
		('KH05','Le Nhat Minh','34 Truong Dinh, Q3, TpHCM','08246108','3/10/1950',21000,'10/8/2006'),
		('KH06','Le Hoai Thuong','227 Nguye Van Cu, Q5, TpHCM','08631738','1/31/1981',915000,'11/4/2006'),
		('KH07','Nguyen Van Tam','32/3 Tran Binh Trong, Q5, TpHCM','0916783565','4/6/1971',12500,'12/1/2006'),
		('KH08','Phan Thi Thanh','45/2 An Duong Vuong, Q5, TpHCM','093843756','1/10/1971',365000,'12/3/2006'),
		('KH09','Le Ha Vinh','873 Le Hong Phong, Q5, TpHCM','08654763','9/3/1979',70000,'1/4/2007'),
		('KH10','Ha Duy Lap','34/34B Nguyen Trai, Q1, TpHCM','08768904','5/2/1983',67500,'1/6/2007')
	INSERT INTO SANPHAM(MASP,TENSP,DVT,NUOCSX,GIA) VALUES
		('BC01','But chi','cay','Singapore',3000),
		('BC02','But chi','cay','Singapore',3500),
		('BC03','But chi','cay','Viet Nam',3500),
		('BC04','But chi','hop','Viet Nam',30000),
		('BB01','But bi','cay','Viet Nam',5000),
		('BB02','But bi','cay','Trung Quoc',7000),
		('BB03','But bi','hop','Thai Lan',100000),
		('TV01','Tap 100 giay mong','quyen','Trung Quoc',2500),
		('TV02','Tap 200 giay mong','quyen','Trung Quoc',4500),
		('TV03','Tap 100 giay tot','quyen','Viet Nam',3000),
		('TV04','Tap 200 giay tot','quyen','Viet Nam',5500),
		('TV05','Tap 100 trang','chuc','Viet Nam',23000),
		('TV06','Tap 200 trang','chuc','Viet Nam',53000),
		('TV07','Tap 100 trang','chuc','Trung Quoc',34000),
		('ST01','So tay 500 trang','quyen','Trung Quoc',40000),
		('ST02','So tay loai 1','quyen','Viet Nam',55000),
		('ST03','So tay loai 2','quyen','Viet Nam',51000),
		('ST04','So tay','quyen','Thai Lan',55000),
		('ST05','So tay mong','quyen','Thai Lan',20000),
		('ST06','Phan viet bang','hop','Viet Nam',5000),
		('ST07','Phan khong bui','hop','Viet Nam',7000),
		('ST08','Bong Bang','cai','Viet Nam',1000),
		('ST09','But long','cay','Viet Nam',5000),
		('ST10','But long','cay','Trung Quoc',7000)
	INSERT INTO HOADON(SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES
		(1001,'7/23/2006','KH01','NV01',320000),
		(1002,'8/12/2006','KH01','NV02',840000),
		(1003,'8/23/2006','KH02','NV01',100000),
		(1004,'9/1/2006','KH02','NV01',180000),
		(1005,'10/20/2006','KH01','NV02',3800000),
		(1006,'10/16/2006','KH01','NV03',2430000),
		(1007,'10/28/2006','KH03','NV03',510000),
		(1008,'10/28/2006','KH01','NV03',440000),
		(1009,'10/28/2006','KH03','NV04',200000),
		(1010,'11/1/2006','KH01','NV01',5200000),
		(1011,'11/4/2006','KH04','NV03',250000),
		(1012,'11/30/2006','KH05','NV03',21000),
		(1013,'12/12/2006','KH06','NV01',5000),
		(1014,'12/31/2006','KH03','NV02',3150000),
		(1015,'1/1/2007','KH06','NV01',910000),
		(1016,'1/1/2007','KH07','NV02',12500),
		(1017,'1/2/2007','KH08','NV03',35000),
		(1018,'1/13/2007','KH08','NV03',330000),
		(1019,'1/13/2007','KH01','NV03',30000),
		(1020,'1/14/2007','KH09','NV04',70000),
		(1021,'1/16/2007','KH10','NV03',67500)
	INSERT INTO CTHD(SOHD, MASP, SL) VALUES
		(1001, 'TV02', 10),
		(1001, 'ST01', 5),
		(1001, 'BC01', 5),
		(1001, 'BC02', 10),
		(1001, 'ST08', 10),
		(1002, 'BC04', 20),
		(1002, 'BB01', 20),
		(1002, 'BB02', 20),
		(1003, 'BB03', 10),
		(1004, 'TV01', 20),
		(1004, 'TV02', 10),
		(1004, 'TV03', 10),
		(1004, 'TV04', 10),
		(1005, 'TV05', 50),
		(1005, 'TV06', 50),
		(1006, 'TV07', 2),
		(1006, 'ST01', 30),
		(1006, 'ST02', 10),
		(1007, 'ST03', 10),
		(1008, 'ST04', 8),
		(1009, 'ST05', 10),
		(1010, 'TV07', 50),
		(1010, 'ST07', 50),
		(1010, 'ST08', 100),
		(1010, 'ST04', 50),
		(1010, 'TV03', 100),
		(1011, 'ST06', 50),
		(1012, 'ST07', 3),
		(1013, 'ST08', 5),
		(1014, 'BC02', 80),
		(1014, 'BB02', 100),
		(1014, 'BC04', 60),
		(1014, 'BB01', 50),
		(1015, 'BB02', 30),
		(1015, 'BB03', 7),
		(1016, 'TV01', 5),
		(1017, 'TV02', 1),
		(1017, 'TV03', 1),
		(1017, 'TV04', 5),
		(1018, 'ST04', 6),
		(1019, 'ST05', 1),
		(1019, 'ST06', 2),
		(1020, 'ST07', 10),
		(1021, 'ST08', 5),
		(1021, 'TV01', 7),
		(1021, 'TV02', 10)


--2. Tạo quan hệ SANPHAM1 và KHACHHANG1 chứa toàn bộ dữ liệu của SANPHAM và KHACHHANG:

Select *
Into KHACHHANG1
From KHACHHANG

Select *
Into SANPHAM1
From SANPHAM
--3.Cập nhật giá tăng 5% với những sản phẩm do 'Thai Lan' sản xuất (SANPHAM1):

Update SANPHAM1
	set GIA = GIA + (GIA * 5/100)
	where NUOCSX = 'Thai Lan'

--4.Cập nhật giá giảm 5% với những sản phẩm do 'Trung Quoc' sx có giá từ 10,000 trở xuống (SANPHAM1)
Update SANPHAM1
	set GIA = GIA - (GIA * 5/100)
	where NUOCSX = 'Trung Quoc' and GIA <= 10000
--5.LOAIKH = 'Vip' với khách hàng đăng ký thành viên trước ngày 1/1/2007 có doanh số từ 10.000.000 trở lên 
--													HOẶC sau ngày 1/1/2007 có doanh số từ 2.000.000 trở lên. (KHACHHANG1)

UPDATE KHACHHANG1
SET LOAIKH = 'Vip'
WHERE (NGDK < '1/1/2007' AND  DOANHSO >= 10000000) OR (NGDK > '1/1/2007' AND  DOANHSO >= 2000000)

--PHAN 3: TRUY VAN DU LIEU
--1
	SELECT MASP, TENSP
	FROM SANPHAM
	WHERE NUOCSX = 'Trung Quoc'
--2
	SELECT MASP, TENSP
	FROM SANPHAM
	WHERE DVT = 'cay' OR DVT = 'quyen'
--3
	SELECT MASP, TENSP
	FROM SANPHAM
	WHERE MASP LIKE 'B%01'
--4
	SELECT MASP, TENSP 
	FROM SANPHAM
	WHERE NUOCSX = 'Trung Quoc' AND GIA BETWEEN 30000 AND 40000
--5
	SELECT MASP, TENSP
	FROM SANPHAM
	WHERE (NUOCSX='Trung Quoc' OR NUOCSX='Thai Lan') AND GIA BETWEEN 30000 AND 40000
--6
	SELECT SOHD, TRIGIA
	FROM HOADON
	WHERE NGHD = '1/1/2007' OR NGHD = '1/2/2007'
--7
	SELECT SOHD, TRIGIA
	FROM HOADON
	WHERE MONTH(NGHD) = 1 AND YEAR(NGHD) = 2007
	ORDER BY NGHD ASC, TRIGIA DESC
--8
	SELECT K.MAKH, HOTEN
	FROM KHACHHANG K, HOADON H
	WHERE K.MAKH = H.MAKH
	AND NGHD = '1/1/2007'
--9
	SELECT SOHD, TRIGIA
	FROM HOADON H, NHANVIEN N
	WHERE H.MANV = N.MANV
	AND HOTEN = 'Nguyen Van B' AND NGHD = '10/28/2006'
--10
	SELECT S.MASP, TENSP
	FROM SANPHAM S, KHACHHANG K,HOADON H, CTHD C
	WHERE K.MAKH = H.MAKH AND H.SOHD = C.SOHD AND C.MASP = S.MASP
	AND HOTEN = 'Nguyen Van A'	AND MONTH(NGHD)=10 AND YEAR(NGHD)=2006
--32
	SELECT COUNT (*) FROM SANPHAM  WHERE NUOCSX = 'Trung Quoc'
--33
	SELECT NUOCSX, COUNT (*) AS TONGSP FROM SANPHAM GROUP BY NUOCSX