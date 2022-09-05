-- Create Data
drop database if exists testing_mysql;
create database			testing_mysql;
use						testing_mysql;

-- Create table customer
drop table if exists Customer;
create table Customer (
	CustomerID			int auto_increment primary key,
    `Name`				varchar(50) not null,
    Phone				char(13) not null,
    Email				varchar(50) unique not null,
    Address				varchar(100) not null,
    Note				varchar(500) not null
);

-- Create table Car
drop table if exists Car;
create table Car (
	CarID				int auto_increment primary key,
    Maker				enum('HONDA', 'TOYOTA', 'NISSAN') not null,
    Model				varchar(50) not null,
    `Year`				datetime not null,
    color				varchar(50) not null,
    Note				varchar(500) not null
);

-- Create table car_order
drop table if exists Car_order;
create table Car_order (
	OrderID				int auto_increment primary key,
    CustomerID			int,
    CarID				int,
    Amount				smallint default 1,
    SalePrice			double,
    OrderDate			date,
    DeliveryDate		date,
    DeliveryAddress		varchar(100),
    `Status`			tinyint(2) default 1 not null,
    Note				varchar(500),
    
    foreign key (CustomerID) references  Customer(CustomerID) on delete cascade,
    foreign key (CarID) references Car(CarID) on delete cascade
);


-- Insert data
-- insert table Customer
insert into Customer (Name,			          Phone,			Email, 					Address,			Note  )
values				('Nguyen Tuan Anh ',	  '090111222',	   'nguyena@gmail.com',	    'HA NOI'   ,		'a'   ),
					('Le Van Ba'       ,	  '090333444',	   'leb@gmail.com'    ,		'HA NOI'   ,		'ab'  ),
                    ('Tran Thi Chinh'  ,	  '090999123',	   'ctran@gmail.com'  ,		'VINH PHUC',		'abc' ),
                    ('Hoang Van Dat'   ,	  '090555666',	   'dhoang@gmail.com' ,		'PHU THO'  ,		'xyz' ),
                    ('Doan Thi Em'     ,	  '090777888',	   'edoan@gmail.com'  ,		'HAI PHONG',		'acd' );
                    
-- Insert table Car
insert into Car (Maker,			Model,			Year,					color,			Note)
values			('HONDA',		'HONDA1',		'2018-11-22',			'BLACK',		'a123'),
				('TOYOTA',		'TOYOTA1',		'2017-10-12',			'WHITE',		'abc1'),
                ('NISSAN',		'NISSAN1',		'2019-01-20',			'BLUE',			'1234');
                
-- Insert table Car_order
insert into		Car_order 
				(CustomerID,			CarID,				Amount,					SalePrice, 			OrderDate, 			DeliveryDate, 	 DeliveryAddress ,    `Status`,	     	Note)
value                                                                                                                                                        
				(1,						3,					2,						 5.000000,	       '2022-08-01',		'2022-08-10',	  'HA NOI'        ,	    1,			'123'	),
				(2,						2,					3,						 8.000000,	       '2022-08-02',		'2022-08-11',     'HAI PHONG'     ,	    1,	     	'1234'	),
				(2,						2,					3,						 8.000000,	       '2022-08-03',		'2022-08-12',     'PHU THO'       ,	    1,	     	'1235'	),
				(3,						1,					6,						 7.000000,	       '2022-08-04',		'2022-08-13',     'VINH PHUC'     ,	    0,		 	'1235'	),
                (3,						3,					4,						 7.000000,	       '2022-08-05',		'2022-08-14',     'DIEN BIEN'     ,	    2,		 	'1235'	),
                (4,						2,					5,						 6.000000,	       '2022-08-06',		'2022-08-15',     'LAM DONG'      ,	    1,		 	'1235'	),
                (4,						2,					6,						 9.000000,	       '2022-08-07',		'2022-08-16',     'SAI GON'       ,	    1,		 	'1235'	),
                (4,						1,					7,						 4.000000,	       '2022-08-08',		'2022-08-17',     'THAI NGUYEN'   ,	    2,		 	'1235'	);
              
              set global @@sql_mode='';
              set global sql_mode=',STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'; 
                SELECT @@sql_mode; 
                SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode, 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION', ''));

select * from Customer as c group by c.Address ORDER BY CustomerID DESC;
                
SELECT A.*,COUNT(B.CustomerID) SoluongOTO
FROM  Customer A
LEFT JOIN  Car_order B ON A.CustomerID = B.CustomerID
GROUP BY B.CustomerID
ORDER BY SoluongOTO DESC;z