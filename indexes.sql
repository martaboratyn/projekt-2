
use zadanie2;

--transakcje
update orders
set delivery_date = '2022-03-10 10:00:00.0000000 +00:00'
where order_id = '6';

--indeksy

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


-- procedura

create procedure GetProductsBySupplier
    @supplierID INT
AS
BEGIN
    SELECT equipment_id
    FROM equipments
    WHERE supplier_id = @supplierID
END;

EXEC GetProductsBySupplier @supplierID = 1;

EXEC GetProductsBySupplier @supplierID = 3;