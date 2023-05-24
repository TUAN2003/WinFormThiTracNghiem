create database [QuanLyThiTracNghiem]
use [QuanLyThiTracNghiem]

--xong
create table tblMonThi(
	vcMaMonThi varchar(5) primary key,
	nvcTenMonThi nvarchar(50) not null,
	iSoTinChi int not null,
	iSoCauHoi int not null,
	nvcHocKy nvarchar(30) not null,
	dtNgayBatDauThi datetime not null
)

--xong
create table tblKhoCauHoi(
	iMaCauHoi int identity(1,1) primary key,
	nvcNoiDung nvarchar(max) not null,
	nvcDapAnA nvarchar(max) not null,
	nvcDapAnB nvarchar(max) not null,
	nvcDapAnC nvarchar(max) not null,
	nvcDapAnD nvarchar(max) not null,
	iDapAnDung int not null check(iDapAnDung between 1 and 4),
	iDoKho int not null check(iDoKho between 1 and 4),
	vcMaMonThi varchar(5) not null,
	nvcTenChuong nvarchar(30) not null,
	nvcDuongDanFileAnh nvarchar(max) null
)
alter table tblKhoCauHoi
add constraint fk_tblKhoCauHoi_tblMonThi foreign key(vcMaMonThi) references tblMonThi(vcMaMonThi)
alter table tblKhoCauHoi
add constraint fk_tblKhoCauHoi_tblChuong foreign key(nvcTenChuong) references tblChuong(nvcTenChuong)


--xong
create table tblChuong(
	vcMaMonThi varchar(5) not null,
	nvcTenChuong nvarchar(30) primary key
)
alter table tblChuong
add constraint fk_tblChuong_tblMonThi foreign key(vcMaMonThi) references tblMonThi(vcMaMonThi)

--xong
create table tblMaDeThi(
	vcMaMonThi varchar(5) not null,
	iMaDeThi int primary key 
)
alter table tblMaDeThi
add constraint fk_tblMaDeThi_tblMonThi foreign key(vcMaMonThi) references tblMonThi(vcMaMonThi)

--xong
create table tblDeThi(
	iMaCauHoi int not null,
	iMaDeThi int not null,
	primary key(iMaDeThi,iMaCauHoi)
)
alter table tblDeThi
add constraint fk_tblDeThi_tblMonThi foreign key(iMaDeThi) references tblMaDeThi(iMaDeThi)
alter table tblDeThi
add constraint fk_tblDeThi_tblKhoCauHoi foreign key(iMaCauHoi) references tblKhoCauHoi(iMaCauHoi)

--xong
create table tblKetQuaThi(
	iMaKetQuaThi int identity(1,1) primary key,
	vcMaMonThi varchar(5) not null,
	iMaDeThi int not null,
	vcMaSinhVien varchar(12) not null,
	iSoCauDung int not null,
	iSoCauSai int not null
)
alter table tblKetQuaThi
add constraint fk_tblKetQuaThi_tblMonThi foreign key(vcMaMonThi) references tblMonThi(vcMaMonThi)
alter table tblKetQuaThi
add constraint fk_tblKetQuaThi_tblSinhVien foreign key(vcMaSinhVien) references tblSinhVien(vcMaSinhVien)
alter table tblKetQuaThi
add constraint fk_tblKetQuaThi_tblMaDeThi foreign key(iMaDeThi) references tblMaDeThi(iMaDeThi)

--xong
create table tblChiTietKetQuaThi(
	iMaKetQuaThi int not null,
	iMaCauHoi int not null,
	iCauTraLoi int not null,
	primary key(iMaKetQuaThi,iMaCauHoi)
)
alter table tblChiTietKetQuaThi
add constraint fk_tblChiTietKetQuaThi_tblKetQuaThi foreign key(iMaKetQuaThi) references tblKetQuaThi(iMaKetQuaThi)
alter table tblChiTietKetQuaThi
add constraint fk_tblChiTietKetQuaThi_tblKhoCauHoi foreign key(iMaCauHoi) references tblKhoCauHoi(iMaCauHoi)

--xong
create table tblDanhSachThi(
	vcMaMonThi varchar(5) not null,
	vcMaSinhVien varchar(12) not null,
	bTrangThaiThi bit not null default 0,
	vcMaXacNhan varchar(5) not null,
	primary key(vcMaMonThi,vcMaSinhVien)
)
alter table tblDanhSachThi
add constraint fk_tblDanhSachThi_tblMonThi foreign key(vcMaMonThi) references tblMonThi(vcMaMonThi)
alter table tblDanhSachThi
add constraint fk_tblDanhSachThi_tblSinhVien foreign key(vcMaSinhVien) references tblSinhVien(vcMaSinhVien)

--xong
create table tblSinhVien(
	vcMaSinhVien varchar(12) primary key,
	nvcTenSinhVien nvarchar(30) not null,
	dtNgaySinh datetime not null,
	nvcGioiTinh nvarchar(5) not null check(nvcGioiTinh in (N'Nam',N'Nữ')),
	vcMaLopHanhChinh varchar(7) not null
)
alter table tblSinhVien
add constraint fk_tblSinhVien_tblLopHanhChinh foreign key(vcMaLopHanhChinh) references tblLopHanhChinh(vcMaLopHanhChinh)

--xong
create table tblTaiKhoan(
	vcTenDangNhap varchar(30) primary key,
	vcMatKhau varchar(20) not null,
	iQuyenTruyCap int not null check(iQuyenTruyCap in (1,2)),
	vcMaSinhVien varchar(12)  null
)
alter table tblTaiKhoan
add constraint fk_tblTaiKhoan_tblSinhVien foreign key(vcMaSinhVien) references tblSinhVien(vcMaSinhVien)

--xong
create table tblLopHanhChinh(
	vcMaLopHanhChinh varchar(7) primary key
)

select * from tblChiTietKetQuaThi
select * from tblChuong
select * from tblDanhSachThi
select * from tblDeThi
select * from tblKetQuaThi
select * from tblKhoCauHoi
select * from tblLopHanhChinh
select * from tblMaDeThi
select * from tblMonThi
select * from tblSinhVien
select * from tblTaiKhoan
go
alter table tblMonThi
alter column  tThoiGianThi time(0)

go

delete tblChiTietKetQuaThi
delete tblKetQuaThi
delete tblDanhSachThi
delete tblDeThi
delete tblKhoCauHoi
go
create proc sp_khoCauHoi
as
begin
	select * from tblKhoCauHoi
end

update tblMonThi
set
tThoiGianThi = '07:30'

select * from tblMonThi
where 1=1 and [dtNgayBatDauThi] = '2023/05/23 12:00:00'
