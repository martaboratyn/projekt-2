


![diag](https://github.com/martaboratyn/projekt-2/assets/151691738/78610d4d-83de-48c2-a8b5-c7c68d4679cf)

Zadanie 2 pragramistyczne dokumentacja:
# Opis bazy

Tabele w bazie:
•	Pracownicy – spis pracowników firmy z uwzględnieniem ich wieku, stanowiska, płci i działu, w którym pracują
•	Sprzęty -  nazwa sprzętu , oraz jego opis (json).
•	Kategoria- spis kategorii, w które zostały usegregowane sprzęty.
•	zamówienia z podaniem daty zamówienia i dostarczenia (typ datetimeoffset)
•	Szczegóły zamówienia, które zawierają informację takie jak: jaki sprzęt został zamówiony, do którego działu, kto zamówi i  w jakiej ilości.
•	Faktury-  spis faktur  z numerem, datą wystawienia oraz metodą płatności.
•	Dostawcy - spis dostawców, wraz z numerem telefonu i adresami firm.
•	Dział - spis oddziałów firmy z kolumnami takimi jak miasto, adres i numer.
•	Inwentaryzacja, w której uwzględniamy liczbę danego sprzętu o danej dacie gwarancji i oddziale firmy.
•	Cennik z cenami sprzętu używanego w firmie (cena – typ money).
•	Wydatki na sprzedaż 	z przypisaniem faktury do konkretnego wydatku.
Założenia przyjęte w bazie:
•	Każdy pracownik może być odpowiedzialny za zamówienie sprzętu.
•	Każdy sprzęt w bazie ma jedną cenę.
•	Ten sam sprzęt może pochodzić od różnych dostawców.
•	Pracownik może zamówić sprzęt do innego działu.
•	Każde zamówienie uwzględnia tylko jeden typ sprzętu.
•	Każde zamówienie ma swoją fakturę.
Klucze obce w bazie:
•	Wydatek_id w tabeli faktury (1 – 1), każdy wydatek w tabeli jest przypisany do konkretnej faktury.
•	Faktura_id w szczegółach zamówienia (1 – 1), każda faktura jest przypisana konkretnemu zamówieniowi.
•	Pracownik_id w szczegółach zamówienia (1-M), jeden pracownik może być odpowiedzialny za kilka zamówień.
•	Zamówienie_id w szczegółach zamówienia (1-1), w tabeli zamówienia znajdują się daty zamówienia i dostarczenia konkretnego zamówienia.
•	Dostawca_id w szczegółach zamówienia (1-M), jeden dostawca może mieć wiele zamówień.
•	Dział_id w szczegółach zamówienia (1-M), każdy dział może mieć wiele zamówień.
•	Dział_id w inwentaryzacji (1-M), każdy dział występuję w kilku inwentaryzacjach.
•	Inwentaryzacja_id w tabeli sprzęt (1-M), sprzęt może wystąpić wiele razy w inwentaryzacjach.
•	Cennik_id w tabeli sprzęt (1-1),  każdy sprzęt ma jedną cenę.
•	Kategoria_id w tabei sprzęt(1-M), w jednej kategorii występuje wiele sprzętu.
•	Sprzęt_id w tabeli szczegóły zamówienia(1-1), każde zamówienie uwzględnia jeden rodzaj sprzętu. 

#	Stworzenie bazy danych:

```
create database zadanie_domowe_2;
go

use zadanie_domowe_2;
```

#	Stworzenie odpowiednich tabel:

## Suppliers – firma dostawcza, nazwa, adres, numer telefonu

```
create table suppliers(
    supplier_id int primary key,
    company_name nvarchar(20),
    adress nvarchar(20),
	city nvarchar(20),
	zip_code nvarchar(20),
	country nvarchar(20),
	phone_number nvarchar(20)
);
```

## price_list – ceny sprzętu wraz z datą

```
create table price_list(
    price_list_id int primary key,
    equipment_id int,
	price money,
    entry_date datetimeoffset(7)
);
```

## Categories – kategoria sprzętów

```
create table categories(
    category_id int primary key,
    category varchar(50)
);
```

## Equipments – nazwa sprzętu, numer seryjny, dostawca, cena, opis

```
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
```

## Branches – miasto, adres, numer telefonu

```
create table branches(
    branch_id int primary key,
    city nvarchar(20),
    adress nvarchar(20),
	phone_number nvarchar(20)
);
```

## Invoices – numer faktury, data wystawienia, metoda płatności

```
create table invoices(
    invoice_id int primary key,
    invoices_number nvarchar(20),
    issue_date date,
	payment_method nchar(10) 
);
```
## Inventories – sprzęt, odział id, liczba, data wygaśnięcie gwarancji

```
create table inventories(
    inventory_id int primary key,
    equipment_id int,
    branch_id int,
	  amount int,
	  warranty_expiration_date datetimeoffset(7),
	  constraint FK_equipment_1 foreign key (equipment_id) references equipments(equipment_id),
	  constraint FK_branch foreign key (branch_id) references branches(branch_id)
);
```
## Employees – imię, nazwisko pracownika, stanowisko, odział

```
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
```

## Order_details – sprzęt, liczba, pracownik odpowiedzialny za zamówienie, faktura, oddział

```
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
```
## Orders – sprzęt, data zamówienia, data dostawy

```
create table orders(
    order_id int primary key,
    equipment_id int,
    order_date datetimeoffset(7),
	delivery_date datetimeoffset(7),
	constraint FK_equipment_3 foreign key (equipment_id) references equipments(equipment_id)
);
```
#	Dodanie rekordów do stworzonych tabel.

```
insert into price_list(price_list_id, price, entry_date)
values
    (1, 60.0000, '2018-12-25'),
    (2, 1200.0000, '2018-12-27'),
    (3, 800.0000, '2019-01-30'),
    (4, 50.0000, '2019-02-28'),
    (5, 300.0000, '2020-06-04');

insert into suppliers(supplier_id, company_name, adress, city, zip_code, country, phone_number)
values
	(1, 'Firma TechnoPlus', 'al. Rozwoju 45', 'Technopolis', '74-482', 'Polska', '937 539 355'),
    (2, 'ITMasters Sp. z o.o.', 'ul.Handlowa 67A', 'Technopolis', '74-287', 'Polska', '535 536 636'),
    (3, 'TechSupplies', 'ul.Dasz 55', 'Legnica', '59-220', 'Egipt', '632 578 397'),
    (4, 'NetConnectors', 'ul. Smocza', 'Warszawa', '85-384', 'Chiny', '555 555 555'),
    (5, 'E-Commerce Solutions', 'ul.Zimna', 'Paryż', '93-298', 'Kanada', '989 898 989');

insert into categories(category_id, category)
values
	(1, 'akcesoria_do_komputerów'),
    (2, 'komputery'),
    (3, 'pamięć masowa'),
    (4, 'audio'),
    (5, 'bezpieczeństwo');

insert into equipments(equipment_id, category_id, equipment_name, serial_number, supplier_id, price_list_id, specification)
values
	(1, 3,'pendrive', 257, 1, 1, 'pojemność: 64 GB, typ: USB 3.0, materiał: metal/plastik'),
    (2, 5,'czytniki biometryczne', 637, 3, 2, 'technologia: skanowanie linii papilarnych, interfejs: USB, kompatybilność: Windows, macOS, zabezpieczenia: AES-256, szybkość rozpoznawania: poniżej 1 sekundy, wymiary: 30mm x 20mm x 5mm'),
    (3, 2,'laptop', 5687, 2, 3, 'marka: Hp, model: ABC123, procesor: Intel Core i7, pamięć RAM: 16 GB DDR4, pojemność dysku: 512 GB SSD, ekran:15.6 cala Full HD, syste operacyjny:Windows 10, waga:1.8 kg'),
    (4, 4,'słuchawki', 3752, 2, 4, 'typ: nauszne, dźwięk: przestrzenny 7.1, mikrofon: odłączalny, regulacja głośności: na kablu, złącze: 3.5mm, materiał: skóra sztuczna skóra, kolor: czarny, długość kabla: 2 metry'),
    (5, 1,'klawiatura', 634678, 5, 5, 'rozmiar:27 cali, typ matrycy: IPS, rozdzielczość: 2560 x 1440,format obrazu: 16:9, częstotliwość odświeżania: 75 H, wejścia: HDMI, DisplayPort, wysokość: regulowana, kolor: srebrny/czarny'),
    (6, 1,'projektor', 47824, 5, 4, NULL);





insert into branches(branch_id, city, adress, phone_number)
values
	(1, 'Legnica', 'ul.Chojnowska 2', '666 666 666'),
    (2, 'Piotrków Trybunalski', 'ul. Legnicka 88', '583 692 619'),
    (3, 'Radom', 'ul.Serka 8/a', '592 999 222'),
    (4, 'Wrocław', 'ul.Edwarda Wittiga', '866 386 372'),
    (5, 'Warszawa', 'ul. Koszykowa', '729 470 163');

insert into invoices(invoice_id, invoices_number, issue_date, payment_method)
values
	(1, 78236, '2016-11-23', 'gotówka'),
    (2, 83662, '2022-03-07', 'karta'),
    (3, 26317, '2022-07-12', 'przelew'),
    (4, 45824, '2023-03-14', 'karta'),
    (5, 36777, '2023-05-01', 'przelew'),
    (6, 84382, '2023-11-28', 'karta');

insert into inventories(inventory_id, equipment_id, branch_id, amount , warranty_expiration_date)
values
	(1, 5, 1, 3, '2023-11-20 15:30:00.0000000 +00:00'),
    (2, 4, 1, 1, '2023-12-05 18:30:00.0000000 +00:00'),
    (3, 3, 2, 50, '2024-12-05 17:30:00.0000000 +00:00'),
    (4, 5, 3, 80, '2024-12-05 17:30:00.0000000 +00:00'),
    (5, 1, 3, 6, '2030-12-05 17:30:00.0000000 +00:00');



insert into employees(employee_id, first_name, last_name, position, branch_id, phone_number, date_of_birth, sex)
values
	(1, 'Marta', 'Boratyn', 'manager', 1, '888 888 888', '2000-12-25', 'kobieta'),
    (2, 'Jacek', 'Kowalski', 'analityk', 1, '999 999 999', '1963-08-27', 'mężczyzna'),
    (3, 'Anna', 'Śliwa', 'programista', 1, '777 777 777', '1963-06-30', 'kobieta'),
    (4, 'Kornel', 'Chrzanowski', 'tester oprogramowania', 1, '666 666 666', '1979-11-07', 'mężczyzna'),
    (5, 'Natalia', 'Mach', 'analityk', 2, '333 333 333', '1999-03-02', 'kobieta'),
    (6, 'Weronika', 'Mucha', 'manager', 3, '111 111 111', '2003-02-01', 'kobieta'),
    (7, 'Aleksandra', 'Domagała', 'manager', 2,  '555 555 555', '1967-04-02', 'kobieta'),
    (8, 'Maria', 'Antonina', 'programista', 3, '345 345 345', '1980-12-03', 'kobieta');



insert into order_details(order_details_id, equipment_id, amount, employee_id, invoice_id, supplier_id, branch_id)
values
	(1, 1, 500, 5, 3, 1, 5),
    (2, 2, 6  , 4, 5, 2, 4),
    (3, 3, 15 , 3, 2, 3, 3),
    (4, 4, 58 , 2, 2, 4, 2),
    (5, 5,  2 , 1, 1, 5, 1),
    (6, 6, 200, 4,NULL, 5, 4);

insert into orders(order_id, equipment_id, order_date, delivery_date)
values
	(1, 1,'2022-09-01 18:45:00.0000000 +00:00', '2022-09-05 13:45:00.0000000 +00:00'),
    (2, 2,'2023-09-15 19:45:00.0000000 +00:00', '2023-09-16 18:45:00.0000000 +00:00'),
    (3, 3,'2023-12-28 23:59:59.0000000 +00:00', NULL),
    (4, 4,'2023-12-14 23:59:59.0000000 +00:00', '2023-12-28 23:59:59.0000000 +00:00'),
    (5, 5,'2023-12-31 23:59:59.0000000 +00:00', '2023-12-31 12:00:00.0000000 +00:00'),
    (6, 6,'2022-03-07 10:00:00.0000000 +00:00', NULL);
```
# Transakcja przetwarzania danych

```
update orders
set delivery_date = '2022-03-10 10:00:00.0000000 +00:00'
where order_id = '6';
```
# 	Procedura składowana
```
create procedure GetProductsBySupplier
    @supplierID INT
AS
BEGIN
    SELECT equipment_id
    FROM equipments
    WHERE supplier_id = @supplierID
END;
```

# 	Niezbędne indeksy w bazie

```
create index branch_id on employees (branch_id);

create index supplier_id on equipments (supplier_id);

create index price_list_id on equipments (price_list_id);

create index equipment_id on inventories (equipment_id);

create index branch_id on inventories (branch_id);

create index invoice_id on invoices (invoice_id);

create index employee_id on order_details (employee_id);

create index invoice_id on order_details (invoice_id);

create index supplier_id on order_details (supplier_id);

create index branch_id on order_details (branch_id);

create index equipment_id on orders (equipment_id);

create index equipment_id on price_list (equipment_id);
```
