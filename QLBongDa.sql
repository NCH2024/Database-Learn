	--create database QLBongDa
	create database QLBongDa
	USE QLBongDa

	--create table QUOCGIA
	create table QUOCGIA
		(
			MAQG	varchar(5)		not null,
			TenQG	nvarchar(20)	not null,
			constraint	PK_QUOCGIA	Primary key (MAQG),
		)
	--Create table TINH
	create table TINH
		(
			MATINH	varchar(5)		not null,
			TENTINH nvarchar(100)	not null,
			constraint	PK_TINH		Primary key (MATINH),
		)
	--Create table SANVD
	create table SANVD
		(
			MASAN	varchar(5)		not null,
			TENSAN	Nvarchar(100)	not null,
			DIACHI	nvarchar(200)	null,
			constraint	PK_SANVD	Primary key (MASAN),
		)
	--create table CAULACBO
	create table CAULACBO
		(
			MACLB	varchar(5)		not null,
			TENCLB	Nvarchar(100)	not null,
			MASAN	varchar(5)		not null,
			MATINH	varchar(5)		not null,
			constraint	PK_CAULACBO			primary key (MACLB),
			constraint	FK_CAULACBO_SANVD	foreign key (MASAN) 
				references SANVD(MASAN)
				on delete cascade 
				on update cascade,
			constraint	FK_CAULACBO_TINH	foreign key (MATINH)
				references TINH(MATINH)
				on delete cascade
				on update cascade,
		)
	--create table CAUTHU
	create table CAUTHU
		(
			MACT		Numeric			not null,
			HOTEN		nvarchar(100)	not null,
			VITRI		nvarchar(20)	not null,
			NGAYSINH	Datetime		null,
			DIACHI		nvarchar(200)	null,
			MACLB		varchar(5)		not null,
			MAQG		varchar(5)		not null,
			SO			int				not null,

			constraint	PK_CAUTHU			primary key (MACT),
			constraint	FK_CAUTHU_CAULACBO	foreign key (MACLB)
				references CAULACBO(MACLB)
				on delete cascade
				on update cascade,
			constraint	FK_CAUTHU_QUOCGIA	foreign key (MAQG)
				references QUOCGIA(MAQG)
				on delete cascade
				on update cascade,
		)
	--create table HLV
	create table HUANLV
		(
			MAHLV		varchar(5)		not null,
			TENHLV		Nvarchar(100)	not null,
			NGAYSINH	datetime		null,
			DIACHI		nvarchar(200)	null,
			DIENTHOAI	nvarchar(20)	null,
			MAQG		varchar(5)		not null,

			constraint	PK_HUANLV			primary key (MAHLV),
			constraint	FK_HUANLV_QUOCGIA	foreign key (MAQG)
				references QUOCGIA(MAQG)
				on delete cascade
				on update cascade,
		)
	--create table HLV-CLB
	create table HLVCLB
		(
			MAHLV	varchar(5)		not null,
			MACLB	varchar(5)		not null,
			VAITRO	Nvarchar(100)	not null,
			constraint	PK_HLV_CLB			primary key (MAHLV,MACLB),
			constraint	FK_HLVCLB_HUANLV	foreign key (MAHLV)
				references HUANLV(MAHLV)
				on delete cascade
				on update cascade,
			constraint	FK_HLVCLB_CAULACBO	foreign key (MACLB)
				references CAULACBO(MACLB)
				on delete cascade
				on update cascade,
		)
	--create table TRANDAU
	create table TRANDAU
		(
			MATRAN	numeric			not null,
			NAM		int				not null,
			VONG	int				not null,
			NGAYTD	DATE			not null,
			MACLB	varchar(5)		not null,
			MASAN	varchar(5)		not null,
			KETQUA	varchar(5)		not null,

			constraint	PK_TRANDAU			primary key (MATRAN),
			constraint	FK_TRANDAU_CAULACBO	foreign key (MACLB)
				references CAULACBO(MACLB)
				on delete cascade
				on update cascade,
			constraint	FK_TRANDAU_SANVD	foreign key (MASAN)
				references SANVD(MASAN)
		)
	--create table BANGXH
	create table BANGXH
		(
			MACLB	varchar(5)	not null,
			NAM		int			not null,
			VONG	int			not null,
			SOTRAN	int			not null,
			THANG	int			not null,
			HOA		int			not null,
			THUA	int			not null,
			HIEUSO	varchar(5)	not null,
			DIEN	int			not null,
			HANG	int			not null,
			constraint	PK_BANGXH			primary key (MACLB, NAM, VONG),
			constraint	FK_BANGXH_CAULACBO	foreign key (MACLB)
				references CAULACBO(MACLB)
				on delete cascade
				on update cascade,
		)

		USE QLBongDa
--1. Nhập dữ liệu (đã nhập bằng giao diện DESIGN)
INSERT INTO QUOCGIA(MAQG,TenQG) VALUES
	('VN',N'Việt Nam'),
	('ANH',N'Anh Quốc'),
	('TBN',N'Tây Ban Nha'),
	('BDN',N'Bồ Đào Nha'),
	('BRA',N'Bra-xin'),
	('ITA',N'Ý'),
	('THA',N'Thái Lan')
INSERT INTO TINH(MATINH,TENTINH) VALUES
	('BD',N'Bình Dương'),
	('GL',N'Gia Lai'),
	('DN',N'Đà Nẵng'),
	('KH',N'Khánh Hòa'),
	('PY',N'Phú Yên'),
	('LA',N'Long An')
INSERT INTO SANVD(MASAN,TENSAN,DIACHI) VALUES
	('GD',N'Gò Đậu',N'123 QL1, TX Thủ Dầu Một, Bình Dương'),
	('PL',N'Pleiku',N'22 Hồ Tùng Mậu, Thống Nhất, Thị xã Pleiku, Gia Lai'),
	('CL',N'Chi Lăng',N'127 Võ Văn Tần, Đà Nẵng'),
	('NT',N'Nha Trang',N'128 Phan Chu Trinh, Nha Trang, Khánh Hòa'),
	('TH',N'Tuy Hòa',N'57 Trường Chinh, Tuy Hòa, Phú Yên'),
	('LA',N'Long An',N'102 Hùng Vương, Tp Tân An, Long An')
INSERT INTO CAULACBO(MACLB,TENCLB,MASAN,MATINH) VALUES
	('BBD',N'BECAMEX BÌNH DƯƠNG','GD','BD'),
	('HAGL',N'HOÀNG ANH GIA LAI','PL','GL'),
	('SDN',N'SHB ĐÀ NẴNG','CL','DN'),
	('KKH',N'KHATACO KHÁNH HÒA','NT','KH'),
	('TPY',N'THÉP PHÚ YÊN','TH','PY'),
	('GDT',N'GẠCH ĐỒNG TÂM LONG AN','LA','LA')
INSERT INTO CAUTHU(MACT,HOTEN,VITRI,NGAYSINH,MACLB,MAQG,SO) VALUES
	(1,N'Nguyễn Vũ Phong',N'Tiền vệ','20/02/1990','BBD','VN',17),
	(2,N'Nguyễn Công Vinh',N'Tiền đạo','10/03/1992','HAGL','VN',9),
	(4,N'Trần Tấn Tài',N'Tiền vệ','12/11/1989','BBD','VN',8),
	(5,N'Phan Hồng Sơn',N'Thủ môn','10/06/1991','HAGL','VN',1),
	(6,N'Ronaldo',N'Tiền vệ','12/12/1989','SDN','BRA',7),
	(7,N'Ronaldo',N'Tiền vệ','12/10/1989','SDN','BRA',8),
	(8,N'Vidie',N'Hậu vệ','15/10/1987','HAGL','ANH',3),
	(9,N'Trần Văn Santos',N'Thủ môn','21/10/1990','BBD','BRA',1),
	(10,N'Nguyễn Trường Sơn',N'Hậu vệ','26/8/1993','BBD','VN',4)
INSERT INTO HUANLV(MAHLV,TENHLV,NGAYSINH,DIENTHOAI,MAQG) VALUES
	('HLV01',N'Vital','15/10/1995','0918011075','BDN'),
	('HLV02',N'Lê Huỳnh Đức','20/05/1972','01223456789','VN'),
	('HLV03',N'Kiatisuk','11/12/1970','01990123456','THA'),
	('HLV04',N'Hoàng Anh Tuấn','10/06/1970','0989112233','VN'),
	('HLV05',N'Trần Công Vinh','07/07/1973','0909099990','VN'),
	('HLV06',N'Trần Văn Phúc','02/03/1965','01650101234','VN')
INSERT INTO HLVCLB(MAHLV,MACLB,VAITRO) VALUES
	('HLV01','BBD',N'HLV Chính'),
	('HLV02','SDN',N'HLV Chính'),
	('HLV03','HAGL',N'HLV Chính'),
	('HLV04','KKH',N'HLV Chính'),
	('HLV05','GDT',N'HLV Chính'),
	('HLV06','BBD',N'HLV Thủ môn')
INSERT INTO TRANDAU(MATRAN,NAM,VONG,NGAYTD,MACLB,MASAN,KETQUA) VALUES
	(1,2009,1,'7/2/2009','BBD','GD','3-0'),
	(2,2009,1,'7/2/2009','KKH','NT','1-1'),
	(3,2009,2,'16/2/2009','SDN','CL','2-2'),
	(4,2009,2,'16/2/2009','TPY','TH','5-0'),
	(5,2009,3,'1/3/2009','TPY','TH','0-2'),
	(6,2009,3,'1/3/2009','KKH','NT','0-1'),
	(7,2009,4,'7/3/2009','KKH','NT','1-0'),
	(8,2009,4,'7/3/2009','BBD','GD','2-2')
INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEN) VALUES
	('BBD',2009,1,1,1,0,0,'3-0',3,1),
	('KKH',2009,1,1,0,1,0,'1-1',1,2),
	('TPY',2009,1,0,0,0,0,'0-0',0,4),
	('SDN',2009,1,1,0,0,1,'0-3',0,5),
	('TPY',2009,2,1,1,0,0,'5-0',3,1),
	('BBD',2009,2,2,1,0,1,'3-5',3,2),
	('KKH',2009,2,2,0,2,0,'3-3',2,3),
	('',,,,,,,'',,),
--2. Xóa cầu thủ 'Nguyễn Vũ Phong
Delete CAUTHU
	where HOTEN = N'Nguyễn Vũ Phong'
--3. Xóa các cầu thủ có tuổi trên 40 
Delete CAUTHU
	where (YEAR(getdate()) - year(NGAYSINH)) > 40
--4. Xoa các cầu thủ có tuổi trên 35 ở câu lạc bộ 'BBD'
Delete CAUTHU
	where MACLB = 'BBD' and (YEAR(getdate()) - year(NGAYSINH)) > 35
--5. Xoa cac cau thu co tuoi tren 35 o cau lac bo 'BECMEX BÌNH DƯƠNG'
Delete CAUTHU
from CAULACBO CLB, CAUTHU CT
Where CLB.MACLB = CT.MACLB 
AND TENCLB = N'BECMEX BÌNH DƯƠNG'
AND (year(getdate())-year(NGAYSINH))> 35

--6. Dổi vị trí cầu thủ 'Nguyễn Trường Sơn' thành 'Tiền đạo'
Update CAUTHU
	set VITRI = N'Tiền đạo'
	where HOTEN = N'Nguyễn Trường Sơn'
--7. Ghi nhận địa chỉ của huấn luyện viên ‘Lê Huỳnh Đức’ là ‘TP.HCM’
Update HUANLV
	set DIACHI = 'TP.HCM'
	where TENHLV = N'Lê Huỳnh Đức'
--8. Đổi vị trí của cầu thủ ‘Nguyễn Công Vinh’ với cầu thủ ‘Trần Tấn Tài’
Update CAUTHU
	set VITRI = N'Tiền vệ'
	where HOTEN = N'Nguyễn Công Vinh'
Update CAUTHU
	set VITRI = N'Tiền đạo'
	where HOTEN = N'Trần Tấn Tài'
--9. Thay huấn luyện viên mới của ‘GẠCH ĐỒNG TÂM LONG AN’ là ‘Nguyễn Đức Thắng’.
UPDATE HUANLV
SET TENHLV = N'Nguyễn Đức Thắng'
from CAULACBO CLB, HUANLV HL, HLVCLB HB
Where CLB.MACLB = HB.MACLB AND HB.MAHLV = HL.MAHLV
AND TENCLB = N'GẠCH ĐỒNG TÂM LONG AN'
--10. Đổi tên câu lạc bộ ‘BECAMEX BÌNH DƯƠNG’ thành ‘BÌNH DƯƠNG’
update CAULACBO
	set TENCLB = N'BÌNH DƯƠNG'
	where TENCLB = N'BECAMEX BÌNH DƯƠNG'