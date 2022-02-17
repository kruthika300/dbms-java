-- 2. Create Tables with necessary constraints pertaining to the relational schema using appropriate DDL statements
create table EMPLOYEE(
 e_id varchar(10) primary key,
 E_name varchar(20) ,
email varchar(50) ,
city varchar(100),
	ph_no int,
	salary int ,
	dojoin date
);
create table FILE_DETAILS(
 file_id varchar(10) primary key,
	 paper_type varchar(5),
	 file_name varchar(10),
	 color varchar(10),
	 print_type varchar(15),
	 check(  print_type in ('single', 'double' ))
 );
 
 create table STAFF(
  s_id varchar(10) primary key,
	 room_no int ,
	 course varchar(10),
	 s_yoexp int,
	 job varchar(50),
	 s_age int,
	 foreign key (s_id) references EMPLOYEE(e_id)
 );
 
 create table CLERK(
 c_id varchar(10) primary key,
	 c_yoexp int,
	 clerk_type varchar(20),
	 c_age int,
	foreign key (c_id) references EMPLOYEE(e_id)
	 );

create table DELIVERYBOY(
  dely_id varchar(10) primary key,
	  no_of_dely int,
	d_age int,
	foreign key(dely_id) references employee(e_id)
  );
  
   create table request(
   req_id varchar(10) primary key,
	   req_date date,
	    req_type varchar(10),
	   s_id varchar(10),
	   file_id varchar(10),
	   foreign key(file_id) references file_details(file_id),
	   foreign key(s_id) references staff(s_id),
	   check(req_type in ('official', 'personal' )) 
	   
   );

   create table validity(
   validity_id varchar(10) primary key,
	   req_validity char,
	    staff_eligibility varchar(20),
	    cost int,
	   check(req_validity in ('Y', 'N' )),
	   foreign key(validity_id) references request(req_id),
	   check(staff_eligibility in ('eligible', 'not eligible' ))  
   );
    create table delivery(
	delivery_id varchar(10) primary key,
		print_time time,
	   print_date date,
		foreign key(delivery_id) references validity(validity_id)
	);
	
   
   
-- 3. Populate tables with few tuples 
insert into EMPLOYEE values ('e001','jack','jack1@gmail.com','sringar',9848312,10000,'12/11/12' ),
 ('e002','alex','alex1@gamil.com','kochi',70742,30000,'3/8/13'),
 ('e013','siria','siria1@gmail.com','munnar',95126,15000,'12/1/15'),
 ('e104','jones','jones1@gmail.com','amrithapuri',98764,12000,'4/10/02'),
 ('e015','sira','sira1@gmail.com','kollam',75345,12000,'11/11/2011'),
 ('e006', 'venky','venky1@gmail.com','kovalam',78656,15000,'9/11/15'),
 ('e007','chintu','chintu1@gmail.com','cochin',9577344,10000,'6/10/05'),
 ('e018','chitra','chitra1@gmail.com','alleppey',9623486,12000,'5/5/05'),
 ('e019','avi','avi1@gmail.com','palakkad',7684593,16000,'4/4/04'),
  ('e110','harish','har13@gmail.com','varkala',907865,12000,'2/9/19'),
  ('e111','charitra','charu13@gmail.com','chrankil',90765,20000,'9/5/89'),
 ('e112','nytra','niu56@gmail.com','balarampuram',78569,45000,'4/6/99'),
  ('e105', 'mythri','my12@gmail.com','cochin',445633,26700,'4/6/17'),
 ('e106','hrishi','hrishi@gmail.com','allapy',676656,24600,'6/6/10');

 insert into FILE_DETAILS values('f101','A3','research','black','single'),
	 ('f102','A4','GRADE','color','double'),
	 ('f103','A4','project','color','single'),
	 ('f104','A4','project','black','double'),
	 ('f105','A3','notes','color','single'),
	 ('f106','A4','ASSIGNMENT','black','double');
	 

 insert into STAFF values('e013',10,'cse',12,'Professor',23),
('e111',11,'ece',12,'Assitent',34),
 ('e110',12,'mec',13,'Professor',45),
 ('e007',13,'cse',10,'Mentor',34),
 ('e112',11,'eee',5,'Consellor',33),
 ('e019',1,'ece',12,'Consellor',44);


 insert into CLERK values ('e001',12,'senior',23),
 ('e104',5,'junior',22),
 ('e015',20,'senior',45),
 ('e002',10,'junior',34);
 

insert into DELIVERYBOY values('e006',1,23),
('e105',6,22),
('e110',4,34),
('e106',2,33);

insert into request values('r001','4/6/20','official','e111','f101'),
('r002','5/6/20','personal','e013','f102'),
('r003','21/9/20','official','e110','f103'),
('r004','30/8/19','official','e007','f104'),
('r005','12/4/20','personal','e019','f105');

insert into validity values
('r001','Y','eligible',50),
('r002','N','not eligible',30),
('r003','Y','eligible',40),
('r004','Y','eligible',35),
('r005','N','not eligible',20);

 insert into delivery values
 ( 'r001','5:30:39','5/6/20'),
  ('r003','7:40:12','22/9/20'),
  ('r004','13:30:18','30/8/19');   
				
 select * from employee						
full outer join						
staff on employee.e_id=staff.s_id						
full outer join						
clerk ON COALESCE(employee.e_id,staff.s_id)=clerk.c_id						
full outer join						
deliveryboy ON COALESCE(employee.e_id,staff.s_id,clerk.c_id)=deliveryboy.dely_id
full outer join			
request on staff.s_id=request.s_id			
full outer join			
validity on request.req_id=validity.validity_id			
full outer join			
delivery on validity.validity_id=delivery.delivery_id			

