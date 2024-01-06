use zadanie2;

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
    (5, 'E-Commerce Solutions', 'ul.Zimna', 'Pary¿', '93-298', 'Kanada', '989 898 989');

insert into categories(category_id, category)
values
	(1, 'akcesoria_do_komputerów'),
    (2, 'komputery'),
    (3, 'pamiêæ masowa'),
    (4, 'audio'),
    (5, 'bezpieczeñstwo');

insert into equipments(equipment_id, category_id, equipment_name, serial_number, supplier_id, price_list_id, specification)
values
	(1, 3,'pendrive', 257, 1, 1, 'pojemnoœæ: 64 GB, typ: USB 3.0, materia³: metal/plastik'),
    (2, 5,'czytniki biometryczne', 637, 3, 2, 'technologia: skanowanie linii papilarnych, interfejs: USB, kompatybilnoœæ: Windows, macOS, zabezpieczenia: AES-256, szybkoœæ rozpoznawania: poni¿ej 1 sekundy, wymiary: 30mm x 20mm x 5mm'),
    (3, 2,'laptop', 5687, 2, 3, 'marka: Hp, model: ABC123, procesor: Intel Core i7, pamiêæ RAM: 16 GB DDR4, pojemnoœæ dysku: 512 GB SSD, ekran:15.6 cala Full HD, syste operacyjny:Windows 10, waga:1.8 kg'),
    (4, 4,'s³uchawki', 3752, 2, 4, 'typ: nauszne, dŸwiêk: przestrzenny 7.1, mikrofon: od³¹czalny, regulacja g³oœnoœci: na kablu, z³¹cze: 3.5mm, materia³: skóra sztuczna skóra, kolor: czarny, d³ugoœæ kabla: 2 metry'),
    (5, 1,'klawiatura', 634678, 5, 5, 'rozmiar:27 cali, typ matrycy: IPS, rozdzielczoœæ: 2560 x 1440,format obrazu: 16:9, czêstotliwoœæ odœwie¿ania: 75 H, wejœcia: HDMI, DisplayPort, wysokoœæ: regulowana, kolor: srebrny/czarny'),
    (6, 1,'projektor', 47824, 5, 4, NULL);





insert into branches(branch_id, city, adress, phone_number)
values
	(1, 'Legnica', 'ul.Chojnowska 2', '666 666 666'),
    (2, 'Piotrków Trybunalski', 'ul. Legnicka 88', '583 692 619'),
    (3, 'Radom', 'ul.Serka 8/a', '592 999 222'),
    (4, 'Wroc³aw', 'ul.Edwarda Wittiga', '866 386 372'),
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
    (2, 'Jacek', 'Kowalski', 'analityk', 1, '999 999 999', '1963-08-27', 'mê¿czyzna'),
    (3, 'Anna', 'Œliwa', 'programista', 1, '777 777 777', '1963-06-30', 'kobieta'),
    (4, 'Kornel', 'Chrzanowski', 'tester oprogramowania', 1, '666 666 666', '1979-11-07', 'mê¿czyzna'),
    (5, 'Natalia', 'Mach', 'analityk', 2, '333 333 333', '1999-03-02', 'kobieta'),
    (6, 'Weronika', 'Mucha', 'manager', 3, '111 111 111', '2003-02-01', 'kobieta'),
    (7, 'Aleksandra', 'Domaga³a', 'manager', 2,  '555 555 555', '1967-04-02', 'kobieta'),
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