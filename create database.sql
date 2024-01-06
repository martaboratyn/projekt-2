create database zadanie2;
go

use zadanie2;

create table suppliers(
    supplier_id int primary key,
    company_name nvarchar(20),
    adress nvarchar(20),
	city nvarchar(20),
	zip_code nvarchar(20),
	country nvarchar(20),
	phone_number nvarchar(20)
);
create table price_list(
    price_list_id int primary key,
    equipment_id int,
	price money,
    entry_date datetimeoffset(7)
);
create table categories(
    category_id int primary key,
    category varchar(50)
);
create table equipments(
    equipment_id int primary key,
    equipment_name varchar(50),
	category_id int,
    serial_number int,
	supplier_id int,
	specification text,
	price_list_id int,
	constraint FK_supplier foreign key (supplier_id) references suppliers(supplier_id),
	constraint FK_category foreign key (category_id) references categories(category_id),
	constraint FK_price foreign key (price_list_id) references price_list(price_list_id)
);




create table branches(
    branch_id int primary key,
    city nvarchar(20),
    adress nvarchar(20),
	phone_number nvarchar(20)
);

create table invoices(
    invoice_id int primary key,
    invoices_number nvarchar(20),
    issue_date date,
	payment_method nchar(10) 
);

create table inventories(
    inventory_id int primary key,
    equipment_id int,
    branch_id int,
	amount int,
	warranty_expiration_date datetimeoffset(7),
	constraint FK_equipment_1 foreign key (equipment_id) references equipments(equipment_id),
	constraint FK_branch foreign key (branch_id) references branches(branch_id)
);




create table employees(
    employee_id int primary key,
    first_name nvarchar(20),
    last_name nvarchar(20),
	position nvarchar(50),
	branch_id int,
	phone_number nvarchar(20),
	date_of_birth date,
	sex nvarchar(10),
	constraint FK_branch_1 foreign key (branch_id) references branches(branch_id)
);



create table order_details(
    order_details_id int primary key,
    equipment_id int,
    amount int,
	employee_id int,
	invoice_id int,
	supplier_id int,
	branch_id int,
	constraint FK_supplier_1 foreign key (supplier_id) references suppliers(supplier_id),
	constraint FK_invoice foreign key (invoice_id) references invoices(invoice_id),
	constraint FK_employee foreign key (employee_id) references employees(employee_id),
	constraint FK_equipment_2 foreign key (equipment_id) references equipments(equipment_id)
);

create table orders(
    order_id int primary key,
    equipment_id int,
    order_date datetimeoffset(7),
	delivery_date datetimeoffset(7),
	constraint FK_equipment_3 foreign key (equipment_id) references equipments(equipment_id)
);


