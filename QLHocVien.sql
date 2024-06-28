	/*	BAI 4:
			Mô tả CSDL quản lý học viên như sau
		HOCVIEN (MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, #MALOP)-
		LOP (MALOP, TENLOP, TRGLOP, SISO, MAGVCN)-
		KHOA (MAKHOA, TENKHOA, NGTLAP, TRGKHOA)-
		MONHOC (MAMH, TENMH, TCLT, TCTH, #MAKHOA)-
		DIEUKIEN (#MAMH, MAMH_TRUOC)-
		GIAOVIEN (MAGV, HOTEN, HOCVI,HOCHAM,GIOITINH, NGSINH, NGVL,HESO, 
				MUCLUONG, #MAKHOA)-
		GIANGDAY (#MALOP, #MAMH, #MAGV, HOCKY, NAM, TUNGAY, DENNGAY)
		KETQUATHI (#MAHV, #MAMH, LANTHI, NGTHI, DIEM, KQUA)
	*/

	-- Create DATABASE QLHocVien
		Create Database QLHocVien
		USE QLHocVien
	-- Create TABLE 1 KHOA
	Create Table KHOA
		(
			MAKHOA		varchar(4)		not null,
			TENKHOA		varchar(40)		not null,
			NGTLAP		smalldatetime	not null,
			TRGKHOA		char(4)			,
			Constraint	PK_KHOA	Primary Key	(MAKHOA)
		);
	-- Create TABLE 2 GIAOVIEN
	Create Table GIAOVIEN
		(
			MAGV		char(4)			not null,
			HOTEN		varchar(40)		not null,
			HOCVI		varchar(10)		not null,
			HOCHAM		varchar(10)		,
			GIOITINH	varchar(3)		not null,
			NGSINH		smalldatetime	not null,
			NGVL		smalldatetime	not null,
			HESO		numeric(4,2)	not null,
			MUCLUONG	money			not null,
			MAKHOA		varchar(4)		not null,
			Constraint	PK_GIAOVIEN			Primary Key	(MAGV),
			Constraint	FK_GIAOVIEN_KHOA	Foreign Key	(MAKHOA)
				references KHOA (MAKHOA)
				on delete cascade
				on update cascade
		);
	--Create TABLE 3 LOP
	Create Table LOP
		(
			MALOP	char(3)		not null,
			TENLOP	varchar(40)	not null,
			TRGLOP	char(5)		,
			SISO	tinyint		not null,
			MAGVCN	char(4)		not null,
			Constraint	PK_LOP	Primary Key	(MALOP)
		);
	--Create TABLE 4 HOCVIEN
	Create Table HOCVIEN
		(
			MAHV		char(5)			not null,
			HO			varchar(40)		not null,
			TEN			varchar(10)		not null,
			NGSINH		smalldatetime	not null,
			GIOITINH	varchar(3)		not null,
			NOISINH		varchar(40)		not null,
			MALOP		char(3)			not null,
			Constraint	PK_HOCVIEN			Primary Key (MAHV),
			Constraint	FK_HOCVIEN_LOP		foreign Key (MALOP)
				references	LOP(MALOP)
				on delete cascade
				on update cascade
		);
	-- Create TABLE 5 MONHOC
	Create Table MONHOC
		(
			MAMH	varchar(10)		not null,
			TENMH	varchar(40)		not null,
			TCLT	tinyint			not null,
			TCTH	tinyint			not null,
			MAKHOA	varchar(4)		not null,
			Constraint	PK_MONHOC			Primary Key	(MAMH),
			Constraint	FK_MONHOC_KHOA		foreign Key	(MAKHOA)
				references KHOA(MAKHOA)
				on update cascade
				on delete cascade
		);
	--Create TABLE 6 DIEUKIEN
	Create Table DIEUKIEN
		(
			MAMH		varchar(10)	not null,
			MAMH_TRUOC	varchar(10) not null,
			Constraint	PK_DIEUKIEN			Primary Key (MAMH, MAMH_TRUOC),
			Constraint	FK_DIEUKIEN_MONHOC	Foreign Key	(MAMH)
				references	MONHOC(MAMH)
				on delete cascade
				on update cascade
		);
	-- Create TABLE 7 GIANGDAY
	Create Table GIANGDAY
		(
			MALOP		char(3)				not null,
			MAMH		varchar(10)			not null,
			MAGV		char(4)				not null,
			HOCKY		tinyint				not null,
			NAM			smallint			not null,
			TUNGAY		smalldatetime		not null,
			DENNGAY		smalldatetime		not null,
			Constraint	PK_GIANGDAY				Primary Key (MALOP, MAMH),
			Constraint	FK_GIANGDAY_LOP			Foreign Key	(MALOP)
				references LOP(MALOP)
				on update cascade
				on delete cascade,
			Constraint	FK_GIANGDAY_MONHOC		Foreign Key	(MAMH)
				references MONHOC(MAMH)
				on update cascade
				on delete cascade,
			Constraint	FK_GIANGDAY_GIAOVIEN	Foreign Key	(MAGV)
				references GIAOVIEN(MAGV)
		);
	--Create TABLE 8 KETQUATHI
	Create Table KETQUATHI
		(
			MAHV	char(5)			not null,
			MAMH	varchar(10)		not null,
			LANTHI	tinyint			not null,
			NGTHI	smalldatetime	not null,
			DIEM	numeric(4,2)	not null,
			KQUA	varchar(10)		not null,
			Constraint	PK_KETQUATHI			Primary Key (MAHV, MAMH, LANTHI),
			Constraint	FK_KETQUATHI_HOCVIEN	Foreign Key	(MAHV)
				references	HOCVIEN(MAHV)
				on update cascade
				on delete cascade,
			Constraint	FK_KETQUATHI_MONHOC		Foreign Key	(MAMH)
				references	MONHOC(MAMH)
				on update cascade
				on delete cascade
		)
	--1.Them vao 3 thuoc tinh GHICHU, DIEMTB, XEPLOAI cho bang HOCVIEN
		Alter table HOCVIEN
		add	GHICHU	varchar(100),
			DIEMTB	int	,
			XEPLOAI	varchar(10);
	--2. Ma hoc vien gom 5 ky tu: 3 ky tu dau la Ma lop, 2 ky tu cuoi la so thu tu hoc vien
		Alter table HOCVIEN
		add constraint C_MAHV check (MAHV like '[A-Z][0-9][0-9][0-9][0-9]');
	--3. Gioi tinh chi co hai gia tri la nam hoac nu
		Alter table GIAOVIEN
		add constraint C_GIOITINH_GIAOVIEN check (GIOITINH = 'nam' or GIOITINH = 'nu');
		Alter table HOCVIEN
		add constraint C_GIOITINH_HOCVIEN check (GIOITINH = 'nam' or GIOITINH = 'nu');
	--4.Điểm số của một lần thi có giá trị từ 0 đến 10 và lưu đến hai số lẻ vd: 6.22 
		Alter table KETQUATHI
		add constraint C_DIEM check (DIEM >= 0 and DIEM <= 10 and DIEM = ROUND(DIEM,2));
	--8. Hoc vị của giáo viên có thể là :
		Alter table GIAOVIEN
		add constraint C_HOCVI check (HOCVI = 'CN' or HOCVI = 'KS' or HOCVI = 'Ths' or HOCVI = 'TS' or HOCVI = 'PTS');
	--9. Lớp trưởng của 1 lớp phải là học viên của lớp đó.
		Alter table LOP
		add constraint FK_LOP_HOCVIEN Foreign key (TRGLOP)
			references HOCVIEN(MAHV);
	--10. Trưởng khoa là giáo viên thuộc khoa và có học vị 'TS' hoặc 'PTS'
		ALTER TABLE KHOA
		ADD CONSTRAINT FK_KHOA_GIAOVIEN FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN(MAGV);

	--PHAN 2 : NHẬP DỮ LIỆU 
INSERT INTO KHOA (MAKHOA, TENKHOA, NGTLAP) VALUES 
('KHMT', 'Khoa hoc may tinh', '6/7/2005'), 
('HTTT', 'He thong thong tin', '2005-06-07'), 
('CNPM', 'Cong nghe phan mem', '2005-06-07'), 
('MTT', 'Mang va truyen thong', '2005-10-20'), 
('KTMT', 'Ky thuat may tinh', '2005-12-20')


INSERT INTO GIAOVIEN(MAGV,HOTEN,HOCVI,HOCHAM,GIOITINH,NGSINH,NGVL,HESO,MUCLUONG,MAKHOA) VALUES
('GV01', 'Ho Thanh Son', 'PTS', 'GS', 'Nam', '1950-05-02', '2004-01-11', 5.00, 2250000, 'KHMT'), 
('GV02', 'Tran Tam Thanh', 'TS', 'PGS', 'Nam', '1965-12-17', '2004-04-20', 4.50, 2025000, 'HTTT'), 
('GV03', 'Do Nghiem Phung', 'TS', 'GS', 'Nu', '1950-08-01', '2004-09-23', 4.00, 1800000, 'CNPM'), 
('GV04', 'Tran Nam Son', 'TS', 'PGS', 'Nam', '1961-02-22', '2005-01-12', 4.50, 2025000, 'KTMT'), 
('GV05', 'Mai Thanh Danh', 'ThS', 'GV', 'Nam', '1958-03-12', '2005-01-12', 3.00, 1350000, 'HTTT'), 
('GV06', 'Tran Doan Hung', 'TS', 'GV', 'Nam','1953-03-11','2005-01-12' ,4.50 ,2025000 ,'KHMT'), 
('GV07','Nguyen Minh Tien','ThS','GV','Nam','1971-11-23','2005-03-01' ,4.00 ,1800000 ,'KHMT'), 
('GV08','Le Thi Tran','KS',Null,'Nu','1974-03-26','2005-03-01' ,1.69 ,760500 ,'KHMT'), 
('GV09','Nguyen To Lan','ThS','GV','Nu','1966-12-31','2005-03-01' ,4.00 ,1800000 ,'HTTT'), 
('GV10','Le Tran Anh Loan','KS',Null,'Nu','1972-07-17','2005-03-01' ,1.86 ,837000 ,'CNPM'), 
('GV11','Ho Thanh Tung','CN', 'GV' ,'Nam' ,'1980 -01 -12' ,'2005 -05 -15' ,2.67 ,1201500 ,'MTT'), 
('GV12' ,'Tran Van Anh' ,'CN' ,Null ,'Nu' ,'1981 -03 -29' ,'2005 -05 -15' ,1.69 ,760500 ,'CNPM'), 
('GV13' ,'Nguyen Linh Dan' ,'CN' ,Null ,'Nu' ,'1980 -05 -23' ,'2005 -05 -15' ,1.69 ,760500 ,'KTMT'), 
('GV14' ,'Truong Minh Chau' ,'ThS', 'GV' ,'Nu' ,'1976 -11 -30' ,'2005 -05 -15' ,3.00 ,1350000,'MTT'), 
('GV15' ,'Le Ha Thanh' ,'ThS', 'GV' ,'Nam' ,'1978 -05 -04' ,'2005 -05 -15' ,3.00 ,1350000,'KHMT')

UPDATE KHOA
SET TRGKHOA = 'GV01' WHERE MAKHOA = 'KHMT'
UPDATE KHOA
SET TRGKHOA = 'GV02' WHERE MAKHOA = 'HTTT'
UPDATE KHOA
SET TRGKHOA = 'GV04' WHERE MAKHOA = 'CNPM'
UPDATE KHOA
SET TRGKHOA = 'GV03' WHERE MAKHOA = 'MTT'

insert into MONHOC(MAMH,TENMH,TCLT,TCTH,MAKHOA) values 
('THDC', 'Tin hoc dai cuong', 4, 1, 'KHMT'),
('CTRR', 'Cau truc roi rac', 5, 0, 'KHMT'),
('CSDL', 'Co so du lieu', 3, 1, 'HTTT'),
('CTDLGT', 'Cau truc du lieu va giai thuat', 3, 1, 'KHMT'),
('PTTKTT', 'Phan tich thiet ke thuat toan', 3, 0, 'KHMT'),
('DHMT', 'Do hoa may tinh', 3, 1, 'KHMT'),
('KTMT', 'Kien truc may tinh', 3, 0, 'KTMT'),
('TKCSDL', 'Thiet ke co so du lieu', 3, 1, 'HTTT'),
('PTTKHTTT', 'Phan tich thiet ke he thong thong tin', 4, 1, 'HTTT'),
('HDH', 'He dieu hanh', 4, 0, 'KTMT'),
('NMCNPM', 'Nhap mon cong nghe phan mem', 3, 0, 'CNPM'),
('LTCFW', 'Lap trinh C for win', 3, 1, 'CNPM'),
('LTHDT', 'Lap trinh huong doi tuong', 3, 1, 'CNPM')

INSERT INTO LOP(MALOP, TENLOP, SISO, MAGVCN) VALUES
('K11','Lop 1 khoa 1',11,'GV07'),
('K12','Lop 2 khoa 1',12,'GV09'),
('K13','Lop 3  khoa 1',12,'GV14')

INSERT INTO HOCVIEN (MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP)VALUES
('K1101', 'Nguyen Van', 'A', '1986-1-27', 'Nam', 'TpHCM', 'K11'),
('K1102', 'Tran Ngoc', 'Han', '1986-3-14', 'Nu', 'Kien Giang', 'K11'),
('K1103', 'Ha Duy', 'Lap', '1986-4-18', 'Nam', 'Nghe An', 'K11'),
('K1104', 'Tran Ngoc', 'Linh', '1986-3-30', 'Nu', 'Tay Ninh', 'K11'),
('K1105', 'Tran Minh', 'Long', '1986-2-27', 'Nam', 'TpHCM', 'K11'),
('K1106', 'Le Nhat', 'Minh', '1986-1-24', 'Nam', 'TpHCM', 'K11'),
('K1107', 'Nguyen Nhu', 'Nhut', '1986-1-27', 'Nam', 'Ha Noi', 'K11'),
('K1108', 'Nguyen Manh', 'Tam', '1986-2-27', 'Nam', 'Kien Giang', 'K11'),
('K1109', 'Phan Thi Thanh','Tam', '1986-1-27', 'Nu', 'Vinh Long', 'K11'),
('K1110', 'Le Hoai', 'Thuong', '1986-2-5', 'Nu', 'Can Tho', 'K11'),
('K1111', 'Le Ha', 'Vinh', '1986-12-25', 'Nam', 'Vinh Long', 'K11'),
('K1201', 'Nguyen Van', 'B', '1986-2-11', 'Nam', 'TpHCM', 'K12'),
('K1202', 'Nguyen Thi Kim','Duyen', '1986-1-18', 'Nu', 'TpHCM', 'K12'),
('K1203', 'Tran Thi Kim','Duyen', '1986-9-17', 'Nu', 'TpHCM', 'K12'),
('K1204', 'Truong My', 'Hanh', '1986-5-19', 'Nu', 'Dong Nai', 'K12'),
('K1205', 'Nguyen Thanh', 'Nam', '1986-4-17', 'Nam', 'TpHCM', 'K12'),
('K1206', 'Nguyen Thi Truc','Thanh', '1986-3-4', 'Nu', 'Kien Giang', 'K12'),
('K1207', 'Tran Thi Bich','Thuy', '1986-2-8', 'Nu', 'Nghe An', 'K12'),
('K1208', 'Huynh Thi Kim','Trieu', '1986-4-8', 'Nu', 'Tay Ninh', 'K12'),
('K1209', 'Pham Thanh', 'Trieu', '1986-2-23', 'Nam', 'TpHCM', 'K12'),
('K1210', 'Ngo Thanh', 'Tuan', '1986-2-14', 'Nam', 'TpHCM', 'K12'),
('K1211', 'Do Thi', 'Xuan', '1986-3-9', 'Nu', 'Ha Noi', 'K12'),
('K1212', 'Le Thi Phi','Yen', '1986-3-12', 'Nu', 'TpHCM', 'K12'),
('K1301', 'Nguyen Thi Kim', 'Cuc', '1986-6-9', 'Nu', 'Kien Giang', 'K13'),
('K1302', 'Truong Thi My','Hien', '1986-3-18', 'Nu', 'Nghe An', 'K13'),
('K1303', 'Le Duc', 'Hien', '1986-3-21', 'Nam', 'Tay Ninh', 'K13'),
('K1304', 'Le Quang', 'Hien', '1986-4-18', 'Nam', 'TpHCM', 'K13'),
('K1305', 'Le Thi', 'Huong', '1986-3-27', 'Nu', 'TpHCM', 'K13'),
('K1306', 'Nguyen Thai', 'Huu', '1986-3-30', 'Nam', 'Ha Noi', 'K13'),
('K1307', 'Tran Minh', 'Man', '1986-5-28', 'Nam', 'TpHCM', 'K13'),
('K1308', 'Nguyen Hieu', 'Nghia', '1986-4-8', 'Nam', 'Kien Giang', 'K13'),
('K1309', 'Nguyen Trung', 'Nghia', '1987-1-18', 'Nam', 'Nghe An', 'K13'),
('K1310', 'Tran Thi Hong' ,'Tham', '1986-4-22', 'Nu', 'Tay Ninh', 'K13'),
('K1311', 'Tran Minh', 'Thuc', '1986-4-4', 'Nam', 'TpHCM', 'K13'),
('K1312', 'Nguyen Thi Kim','Yen', '1986-9-7', 'Nu', 'TpHCM', 'K13')

UPDATE LOP SET TRGLOP = 'K1108' WHERE MALOP = 'K11'
UPDATE LOP SET TRGLOP = 'K1205' WHERE MALOP = 'K12'
UPDATE LOP SET TRGLOP = 'K1305' WHERE MALOP = 'K13'


INSERT INTO KETQUATHI (MAHV, MAMH, LANTHI, NGTHI, DIEM, KQUA) VALUES 
		('K1101', 'CSDL', 1, '2006-07-20', 10.00, 'Dat'),
       ('K1101', 'CTDLGT', 1, '2006-12-28', 9.00, 'Dat'),
       ('K1101', 'THDC', 1, '2006-05-20', 9.00, 'Dat'),
       ('K1101', 'CTRR', 1, '2006-05-13', 9.50, 'Dat'),
       ('K1102', 'CSDL', 1, '2006-07-20', 4.00, 'K Dat'),
       ('K1102', 'CSDL', 2, '2006-07-27', 4.25, 'K Dat'),
       ('K1102', 'CSDL', 3, '2006-08-10', 4.50, 'K Dat'),
       ('K1102', 'CTDLGT', 1, '2006-12-28', 4.50, 'K Dat'),
       ('K1102', 'CTDLGT', 2, '2007-01-05', 4.00, 'K Dat'),
       ('K1102', 'CTDLGT', 3, '2007-01-15', 6.00, 'Dat'),
       ('K1102', 'THDC', 1, '2006-05-20', 5.00, 'Dat'),
       ('K1102', 'CTRR', 1, '2006-05-13', 7.00, 'Dat'),
       ('K1103', 'CSDL', 1, '2006-07-20', 3.50, 'K Dat'),
       ('K1103', 'CSDL', 2, '2006-07-27', 8.25, 'Dat'),
       ('K1103', 'CTDLGT', 1, '2006-12-28', 7.00, 'Dat'),
       ('K1103', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
       ('K1103', 'CTRR', 1, '2006-05-13', 6.50, 'Dat'),
       ('K1104', 'CSDL', 1, '2006-07-20', 3.75, 'K Dat'),
       ('K1104', 'CTDLGT', 1, '2006-12-28', 4.00, 'K Dat'),
       ('K1104', 'THDC', 1, '2006-05-20', 4.00, 'K Dat'),
       ('K1104', 'CTRR', 1, '2006-05-13', 4.00, 'K Dat'),
       ('K1104', 'CTRR', 2, '2006-05-20', 3.50, 'K Dat'),
       ('K1104', 'CTRR', 3, '2006-06-30', 4.00, 'K Dat'),
       ('K1201', 'CSDL', 1, '2006-07-20', 6.00, 'Dat'),
       ('K1201', 'CTDLGT', 1, '2006-12-28', 5.00, 'Dat'),
       ('K1201', 'THDC', 1, '2006-05-20', 8.50, 'Dat'),
       ('K1201', 'CTRR' , 1, '2006-05-13', 9.00, 'Dat'),
       ('K1202', 'CSDL', 1, '2006-07-20', 8.00, 'Dat'),
       ('K1202', 'CTDLGT', 1, '2006-12-28', 4.00, 'K Dat'),
       ('K1202', 'CTDLGT', 2, '2007-01-05', 5.00, 'Dat'),
       ('K1202', 'THDC', 1, '2006-05-20', 4.00, 'K Dat'),
       ('K1202', 'THDC', 2, '2006-05-27', 4.00, 'K Dat'),
       ('K1202', 'CTRR', 1, '2006-05-13', 3.00, 'K Dat')
INSERT INTO KETQUATHI (MAHV, MAMH, LANTHI, NGTHI, DIEM, KQUA) VALUES
    ('K1202', 'CTRR', 2, '2006-05-20', 4.00, 'K Dat'),
    ('K1202', 'CTRR', 3, '2006-06-30', 6.25, 'Dat'),
    ('K1203', 'CSDL', 1, '2006-07-20', 9.25, 'Dat'),
    ('K1203', 'CTDLGT', 1, '2006-12-28', 9.50, 'Dat'),
    ('K1203', 'THDC', 1, '2006-05-20', 10.00, 'Dat'),
    ('K1203', 'CTRR', 1, '2006-05-13', 10.00, 'Dat'),
    ('K1204', 'CSDL', 1, '2006-07-20', 8.50, 'Dat'),
    ('K1204', 'CTDLGT', 1, '2006-12-28', 6.75, 'Dat'),
    ('K1204', 'THDC', 1, '2006-05-20', 4.00, 'K Dat'),
    ('K1204', 'CTRR', 1, '2006-05-13', 6.00, 'Dat'),
    ('K1301', 'CSDL', 1, '2006-12-20', 4.25, 'K Dat'),
    ('K1301', 'CTDLGT', 1, '2006-07-25', 8.00, 'Dat'),
    ('K1301', 'THDC', 1, '2006-05-20', 7.75, 'Dat'),
    ('K1301', 'CTRR', 1, '2006-05-13', 8.00, 'Dat'),
    ('K1302', 'CSDL', 1, '2006-12-20', 6.75, 'Dat'),
    ('K1302', 'CTDLGT', 1, '2006-07-25', 5.00, 'Dat'),
    ('K1302', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
    ('K1302', 'CTRR', 1, '2006-05-13', 8.50, 'Dat'),
    ('K1303', 'CSDL', 1, '2006-12-20', 4.00, 'K Dat'),
    ('K1303', 'CTDLGT', 1, '2006-07-25', 4.50, 'K Dat'),
    ('K1303', 'CTDLGT', 2, '2006-08-07', 4.00, 'K Dat'),
    ('K1303', 'CTDLGT', 3, '2006-08-15', 4.25, 'K Dat'),
    ('K1303', 'THDC', 1, '2006-05-20', 4.50, 'K Dat'),
    ('K1303', 'CTRR', 1, '2006-05-13', 3.25, 'K Dat'),
    ('K1303', 'CTRR', 2, '2006-05-20', 5.00, 'Dat'),
    ('K1304', 'CSDL', 1, '2006-12-20', 7.75, 'Dat'),
    ('K1304', 'CTDLGT', 1, '2006-07-25', 9.75, 'Dat'),
    ('K1304', 'THDC', 1, '2006-05-20', 5.50, 'Dat'),
    ('K1304', 'CTRR', 1, '2006-05-13', 5.00, 'Dat'),
    ('K1305', 'CSDL', 1, '2006-12-20', 9.25, 'Dat'),
    ('K1305', 'CTDLGT', 1, '2006-07-25', 10.00, 'Dat'),
    ('K1305', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
    ('K1305', 'CTRR', 1, '2006-05-13', 10.00, 'Dat')

	INSERT INTO GIANGDAY (MALOP, MAMH, MAGV, HOCKY, NAM, TUNGAY, DENNGAY) VALUES
    ('K11', 'THDC', 'GV07', 1, 2006, '2006-01-02', '2006-05-12'),
    ('K12', 'THDC', 'GV06', 1, 2006, '2006-01-02', '2006-05-12'),
    ('K13', 'THDC', 'GV15', 1, 2006, '2006-01-02', '2006-05-12'),
    ('K11', 'CTRR', 'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
    ('K12', 'CTRR', 'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
    ('K13', 'CTRR', 'GV08', 1, 2006, '2006-01-09', '2006-05-17'),
    ('K11', 'CSDL', 'GV05', 2, 2006, '2006-06-01', '2006-07-15'),
    ('K12', 'CSDL', 'GV09', 2, 2006, '2006-06-01', '2006-07-15'),
    ('K13', 'CTDLGT', 'GV15', 2, 2006, '2006-06-01', '2006-07-15'),
    ('K13', 'CSDL', 'GV05', 3, 2006, '2006-08-01', '2006-12-15'),
    ('K13', 'DHMT', 'GV07', 3, 2006, '2006-08-01', '2006-12-15'),
    ('K11', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
    ('K12', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
    ('K11', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-02-18'),
    ('K12', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-03-20'),
    ('K11', 'DHMT', 'GV07', 1, 2007, '2007-02-18', '2007-03-20')
	INSERT INTO DIEUKIEN (MAMH, MAMH_TRUOC) VALUES
    ('CSDL', 'CTRR'),
    ('CSDL', 'CTDLGT'),
    ('CTDLGT', 'THDC'),
    ('PTTKTT', 'THDC'),
    ('PTTKTT', 'CTDLGT'),
    ('DHMT', 'THDC'),
    ('LTHDT', 'THDC'),
    ('PTTKHTTT', 'CSDL')

	--PHAN 3: TRUY VAN DU LIEU
	--1
	SELECT MAHV, HO , TEN , NGSINH, H.MALOP
	FROM HOCVIEN H, LOP L
	WHERE H.MAHV = L.TRGLOP AND MAHV = TRGLOP
	--2
	SELECT H.MAHV,HO,TEN,LANTHI,DIEM
	FROM HOCVIEN H, KETQUATHI K, LOP L
	WHERE  H.MAHV = K.MAHV AND H.MALOP = L.MALOP
	AND MAMH = 'CTRR' AND L.MALOP = 'K12'
	ORDER BY TEN , HO ASC
	--3
	SELECT H.MAHV, H.HO, TEN, MAMH
	FROM HOCVIEN H, KETQUATHI K
	WHERE H.MAHV = K.MAHV 
	AND LANTHI = 1 AND KQUA = 'Dat'
	--4
	SELECT H.MAHV, HO, TEN
	FROM HOCVIEN H, KETQUATHI K
	WHERE H.MAHV = K.MAHV
	AND MALOP ='K11' AND MAMH = 'CTRR' AND KQUA = 'K Dat'
	--5
	SELECT H.MAHV, HO, TEN
	FROM HOCVIEN H, KETQUATHI K
	WHERE H.MAHV = K.MAHV
	AND MALOP LIKE 'K%' AND MAMH = 'CTRR' AND KQUA = 'K Dat'
	--6
	SELECT DISTINCT M.MAMH, TENMH
	FROM MONHOC M, GIAOVIEN G, GIANGDAY GD
	WHERE M.MAMH = GD.MAMH AND G.MAGV = GD.MAGV
	AND HOTEN = 'Tran Tam Thanh'AND HOCKY= 1 AND NAM = 2006
	--7
	SELECT M.MAMH,TENMH
	FROM LOP L, MONHOC M, GIANGDAY GD
	WHERE M.MAMH =GD.MAMH AND GD.MAGV = L.MAGVCN
	AND L.MALOP = 'K11' AND HOCKY = 1 AND NAM = 2006
	--8
	SELECT HO,TEN,TENLOP
	FROM HOCVIEN H, GIANGDAY GD, GIAOVIEN G, MONHOC M, LOP L
	WHERE H.MALOP=GD.MALOP AND GD.MAGV=G.MAGV AND M.MAMH=GD.MAMH AND GD.MALOP=L.MALOP
	AND HOTEN = 'Nguyen To Lan' AND TENMH = 'Co So Du Lieu' AND MAHV = TRGLOP
	--9
	SELECT DK.MAMH,TENMH
	FROM MONHOC M, DIEUKIEN DK
	WHERE M.MAMH=DK.MAMH_TRUOC
	AND TENMH = 'Co So Du Lieu'
