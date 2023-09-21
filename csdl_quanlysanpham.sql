/*
	
    3. Thêm các dữ liệu vào 2 bảng
    4. Tạo view gồm các sản phẩm có giá lớn hơn 20000 gồm các thông tin sau: 
    mã danh mục, tên danh mục, trạng thái danh mục, mã sản phẩm, tên sản phẩm, 
    giá sản phẩm, trạng thái sản phẩm
    5. Tạo các procedure sau:
    - procedure cho phép thêm, sửa, xóa, lấy tất cả dữ liệu, lấy dữ liệu theo mã
    của bảng danh mục và sản phẩm
    - procedure cho phép lấy ra tất cả các phẩm có trạng thái là 1
    bao gồm mã sản phẩm, tên sản phẩm, giá, tên danh mục, trạng thái sản phẩm
    - procedure cho phép thống kê số sản phẩm theo từng mã danh mục
    - procedure cho phép tìm kiếm sản phẩm theo tên sản phầm: mã sản phẩm, tên
    sản phẩm, giá, trạng thái sản phẩm, tên danh mục, trạng thái danh mục
    
*/
create database csdl_quanlysanpham;
use csdl_quanlysanpham;

/*
1. Tạo bảng Danh mục sản phẩm gồm các thông tin sau:
    - Mã danh mục - int - PK - auto increment
    - Tên danh mục - varchar(50) - not null - unique
    - Mô tả - text
    - Trạng thái - bit - default 1
*/

create table dmsanpham(
MaDM int primary key auto_increment,
TenDM varchar(50) not null unique,
Mota text,
trangthai bit default(1)
);

/*
2. Tạo bảng sản phẩm gồm các thông tin sau:
    - Mã sản phẩm - varchar(5) - PK
    - Tên sản phẩm - varchar(100) - not null - unique
    - Ngày tạo - date - default currentDate
    - Giá - float - default 0
    - Mô tả sản phẩm - text
    - Tiêu đề - varchar(200)
    - Mã danh mục - int - FK references Danh mục
    - Trạng thái - bit - default 1
*/
create table sanpham (
Masp varchar(5) primary key,
Tensp varchar(100) not null unique,
ngaytao datetime default current_timestamp,
gia float default 0,
motasp text,
tieude varchar(200),
maDM int,
trangthai bit default(1)
);

/*==========================TAO KHOA NGOAI==============================*/
Alter table sanpham 
add constraint dmsp_madm foreign key(maDM)
references dmsanpham(Madm);

/* 3. Thêm các dữ liệu vào 2 bảng */
/*=========Danh mục sản phẩm ============*/
Insert into dmsanpham(maDM,tenDM,Mota,trangthai)
values(1,'Máy tính','mới',1);
Insert into dmsanpham(maDM,tenDM,Mota,trangthai)
values(2,'Điện thoại','mới',1);
Insert into dmsanpham(maDM,tenDM,Mota,trangthai)
values(3,'Ipad','mới',1);
Insert into dmsanpham(maDM,tenDM,Mota,trangthai)
values(4,'Đồng hồ','mới',1);
Insert into dmsanpham(maDM,tenDM,Mota,trangthai)
values(5,'máy chơi game','mới',0);

/*=========Danh mục sản phẩm ============*/

Insert into sanpham(Masp,Tensp,ngaytao,gia,motasp,tieude,maDM,trangthai)
values('SP001','Iphone 15 promax','2023-09-19',37000000,'Apple','Mới ra mắt',2,1);

Insert into sanpham(Masp,Tensp,ngaytao,gia,motasp,tieude,maDM,trangthai)
values('SP002','Iphone 14 promax','2022-09-19',27000000,'Apple','ra mắt 2022',2,1);

Insert into sanpham(Masp,Tensp,ngaytao,gia,motasp,tieude,maDM,trangthai)
values('SP003','Markbook...','2023-09-19',27000000,'Apple','Mới ra mắt',2,1);

Insert into sanpham(Masp,Tensp,ngaytao,gia,motasp,tieude,maDM,trangthai)
values('SP004','apple watch ultra 2','2023-09-19',17000000,'Apple','Mới ra mắt',4,1);

Insert into sanpham(Masp,Tensp,ngaytao,gia,motasp,tieude,maDM,trangthai)
values('SP005','Ipad ...','2023-07-19',15000000,'Apple','Mới ra mắt',3,1);

Insert into sanpham(Masp,Tensp,ngaytao,gia,motasp,tieude,maDM,trangthai)
values('SP006','ipad pro','2023-08-19',20000000,'Apple','Mới ra mắt',2,1);

/*
4. Tạo view gồm các sản phẩm có giá lớn hơn 20 tr  gồm các thông tin sau: 
    mã danh mục, tên danh mục, trạng thái danh mục, mã sản phẩm, tên sản phẩm, 
    giá sản phẩm, trạng thái sản phẩm
    */
    
    create view vw_sp
    as
    select dmsanpham.madm,dmsanpham.tendm,dmsanpham.trangthai,sanpham.masp,sanpham.tensp,sanpham.gia
    from sanpham
    join dmsanpham on sanpham.madm = dmsanpham.madm
    where sanpham.gia>20000000;
    
    select * from vw_sp;
    
    /*
5. Tạo các procedure sau:
    - procedure cho phép thêm, sửa, xóa, lấy tất cả dữ liệu, lấy dữ liệu theo mã
    của bảng danh mục và sản phẩm
*/
DELIMITER //
create procedure get_all_dmsanpham()
BEGIN
	select * from dmsanpham;
END //
DELIMITER ;
call get_all_dmsanpham();
DELIMITER //
create procedure insert_DM(
in ma_DM int,
in ten_DM varchar(50),
in mota_DM text,
trangthai_DM bit
)
BEGIN
insert into dmsanpham
values (ma_DM,ten_DM,mota_DM,trangthai_DM);
END //
DELIMITER ; 
call insert_DM(6,'Danh mục 6','Danh mục test',0);
DELIMITER //
create procedure update_DM(
in ma_DM int,
in ten_DM varchar(50),
in mota_DM text,
trangthai_DM bit
)
BEGIN
update dmsanpham
set tendm = ten_DM,
mota = mota_DM,
trangthai = trangthai_DM
where madm = ma_DM;
END //
DELIMITER ;
call update_DM('6','DM6','DMT',0);
DELIMITER //
create procedure delete_DM(
ma_DM int
)
BEGIN
delete from dmsanpham where madm = ma_DM;
END //
DELIMITER ;
call delete_DM(6);
DELIMITER //
create procedure get_all_sanpham()
BEGIN
select * from sanpham;
END //
DELIMITER ;
call get_all_sanpham();
DELIMITER //
create procedure insert_SP(
Ma_SP varchar(5),
Ten_SP varchar(100),
NgayTao_SP date,
Gia_SP float,
Mota_SP text,
Tieude_SP varchar(200),
Ma_DM int ,
Trangthai_SP bit
)
BEGIN
insert into sanpham
values (Ma_SP, Ten_SP, NgayTao_SP, Gia_SP, Mota_SP, Tieude_SP, Ma_DM, Trangthai_SP);
END //
DELIMITER ;
call insert_SP('SP007','Sản phẩm 7','2023-09-20','3000000','Sản phẩm 7','Sản phẩm test',6,0);
DELIMITER //
create procedure update_SP(
Ma_SP varchar(5),
Ten_SP varchar(100),
NgayTao_SP date,
Gia_SP float,
Mota_SP text,
Tieude_SP varchar(200),
Ma_DM int ,
Trangthai_SP bit
)
BEGIN
update sanpham
set tensp = Ten_SP,
NgayTao =NgayTao_SP ,
gia= Gia_SP,
mota = Mota_SP,
tieude = Tieude_SP,
madm = ma_DM,
trangthai = Trangthai_SP
where masp = Ma_SP; 
END //
DELIMITER ;
call update_SP('SP008','SP 8','2023-09-20','3500000','SP 8','Sản phẩm 8',6,0);
DELIMITER //
create procedure delete_SP(
in ma_SP varchar(5)
)
BEGIN
delete from SP where masp = ma_SP;
END //
DELIMITER ;
call delete_SP('SP008');
/*
- procedure cho phép lấy ra tất cả các phẩm có trạng thái là 1
    bao gồm mã sản phẩm, tên sản phẩm, giá, tên danh mục, trạng thái sản phẩm
*/
DELIMITER //
create procedure getSP_by_trangthai()
BEGIN
select sanpham.masp,sanpham.tensp,sanpham.gia,dmsanpham.tendm, sanpham.trangthai
from sanpham join dmsanpham on sanpham.madm = dmsanpham.madm 
 where trangthai = 1;
END //
DELIMITER ;
call getSP_by_trangthai();
/*
- procedure cho phép thống kê số sản phẩm theo từng mã danh mục
*/
DELIMITER //
create procedure getSP_by_maDM()
BEGIN
select dmsanpham.madm, count(sanpham.masp)as 'Số sản phẩm'
from sanpham join dmsanpham on sanpham.madm = dmsanpham.madm 
group by dmsanpham.madm;
END //
DELIMITER ;
call getSP_by_maDM();
/*
- procedure cho phép tìm kiếm sản phẩm theo tên sản phầm: mã sản phẩm, tên
    sản phẩm, giá, trạng thái sản phẩm, tên danh mục, trạng thái danh mục
*/
DELIMITER //
create procedure getSP_by_tensp(
ten_SP varchar(100)
)
BEGIN
declare name_search varchar(32);
    set name_search = concat('%',ten_SP,'%');
select sanpham.masp, sanpham.tensp, sanpham.gia, sanpham.trangthai, dmsanpham.tendm, dmsanpham.trangthai
from sanpham
join dmsanpham on sanpham.madm = dmsanpham.madm 
where SP_name like name_search;
END //
DELIMITER ;
call getSP_by_tenSP('1');







