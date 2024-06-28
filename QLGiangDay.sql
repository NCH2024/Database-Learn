	/*
	Bài 2: Cơ sỡ dữ liệu QLGiangDay như sau:
	GIAOVIEN(MaGV, HoTen, #MaKhoa)
	MONHOC(MaMH,TenMH)
	PHONGHOC(Phong, ChucNang)
	KHOA(MaKhoa, TenKhoa)
	LOP(MaLop, TenLop, #MaKhoa)
	LICHDAY(#MaGV,#MaMH,#Phong,#MaLop,NgayDay,TuTiet,DenTiet,BaiDay,LyThuyet,GhiChu)
	*/
	--create database QLGiangDay
		Create DataBase QLGiangDay
		USE	QLGiangday
	-- create table MONHOC: PK MaMH
	Create Table MONHOC
		(
			MaMH	varchar(5)		not null,
			TenMH	Nvarchar(100)	not null,
			Constraint	PK_MONHOC Primary Key (MaMH)
		);
	--create table PHONGHOC: PK Phong
	Create Table PHONGHOC
		(
			Phong		varchar(5)		not null,
			ChucNang	Nvarchar(100)	not null,
			Constraint	PK_PHONGHOC Primary Key (Phong)
		);
	-- create table KHOA: Pk MaKhoa
	Create Table KHOA
		(
			MaKhoa		varchar(5)		 not null,
			TenKhoa		Nvarchar(100)	 not null,
			Constraint	PK_KHOA Primary Key (MAKhoa)
		);
	-- create table LOP: PK MaLop, FK MaKhoa
	Create Table LOP
		(
			MaLop	varchar(5)		not null,
			TenLop	Nvarchar(100)	not null,
			MaKhoa	Varchar(5)		not null,
			Constraint	PK_LOP		Primary Key (MaLop),
			Constraint	FK_LOP_KHOA Foreign Key (MaKhoa)
				References KHOA(MaKhoa)
				on delete cascade
				on update cascade
		);
	-- create table GIAOVIEN: PK MaGV, FK MaKhoa
	Create Table GIAOVIEN 
		(
			MaGV	varchar(5)		not null,
			HoTen	Nvarchar(50)	not null,
			MaKhoa	varchar(5)		not null,
			Constraint	PK_GIAOVIEN			Primary Key (MaGV),
			Constraint	FK_GIAOVIEN_KHOA	Foreign Key (MaKhoa)
				References KHOA(MaKhoa)
				on delete cascade
				on update cascade
		);
	-- create table LICHDAY: PK MaGV-MaMH-Phong-MaLop, FK MaGV,MaMH,Phong,Lop
	Create Table LICHDAY
		(
			MaGV		varchar(5)		not null,
			MaMH		varchar(5)		not null, 
			Phong		varchar(5)		not null,
			MaLop		varchar(5)		not null,
			NgayDay		DateTime		not null,
			TuTiet		int				not null,
			DenTiet		int				not null,
			BaiDay		Nvarchar(200)	not null,
			LyThuyet	Nvarchar(200)	not null,
			GhiChu		Nvarchar(300)	null,
			Constraint	PK_LICHDAY			Primary Key (MaGV, MaMH, Phong, MaLop),
			Constraint	FK_LICHDAY_GIAOVIEN	Foreign Key (MaGV)
				References GIAOVIEN(MaGV)
				on delete cascade
				on update cascade,
			Constraint	FK_LICHDAY_MONHOC	Foreign Key (MaMH)
				References MONHOC(MaMH)
				on delete cascade
				on update cascade,
			Constraint	FK_LICHDAY_PHONGHOC	Foreign Key (Phong)
				References PHONGHOC(Phong)
				on delete cascade
				on update cascade,
			Constraint	FK_LICHDAY_LOP		Foreign Key (MaLop)
				References LOP(MaLop)
		);
	-- 4. them cot ngay sinh, gioi tinh, tuoi vao GIAOVIEN
	Alter table GIAOVIEN
	add	NgaySinh	Datetime	not null,
		GioiTinh	varchar(3)	not null,
		Tuoi		int			not null;

	--5. Them cot suc chua vao PHONGHOC
	Alter table PHONGHOC
	add	SucChua	int not null
	--6. Them SoTC, so TCLT, so TCTH vao MONHOC
	Alter table MONHOC
	add	SoTC	int		not null,
		TCLT	int		not null,
		TCTH	int		not null;
	--7. Them SiSo vao LOP
	Alter table LOP
	add	SiSo	int		not null
	--Them rang buoc toan ven cho:
	Alter table LOP
	add	constraint C_SiSo check (SiSo > 50 and SiSo < 150);
	Alter table MONHOC
	add	constraint C_SoTC	Check (SoTC <= 5 and SoTC >= 1),
		constraint C_TCLT	Check (TCLT >=1 and TCLT <=2),
		constraint C_TCTH	Check (TCTH >=1 and TCTH <= 3);
	Alter table GIAOVIEN
	add	constraint C_Tuoi	Check (Tuoi >= 22 and Tuoi <=35);
	Alter table PHONGHOC
	add constraint C_SucChua Check (SucChua >=40 and SucChua <=60); 
