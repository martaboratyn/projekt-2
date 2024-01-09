
use zadanie2;

--transakcje
update orders
set delivery_date = '2022-03-10 10:00:00.0000000 +00:00'
where order_id = '6';

--indeksy
-- branches
create nonclustered index bran on branches(city)
-- categories
create nonclustered index cat on categories(category)
-- employees
create nonclustered index emp_1 on employees(first_name)
create nonclustered index emp_2 on employees(last_name)
--eqiupments
create nonclustered index equip on equipments(equipment_name)
-- inventories
create nonclustered index inven on inventories(warranty_expiration_date)
--invoices
create nonclustered index invo on invoices(issue_date)
--order details
create nonclustered index ord_det on order_details(equipment_id)
--orders
create nonclustered index ord on orders(order_date)
--price list
create nonclustered index price on price_list(price)
--suppliers
create nonclustered index supp on suppliers(company_name)
-- procedura



create procedure UpdatePrice
    @equipmentID int,
    @PercentageChange decimal(5, 2),
    @Min int
as
begin
    declare @NewPrice decimal(10, 2)
    declare @OrderQuantity int

    select @OrderQuantity = COUNT(*)
    from order_details
    where equipment_id = @equipmentID

   --warunek wiêksza lub równa
    if @OrderQuantity >= @Min
    begin
        select @NewPrice = price
        from price_list
        where equipment_id = @equipmentID

        -- nowa cena
        set @NewPrice = @NewPrice * (1 + @PercentageChange / 100)

        update price_list
        set price = @NewPrice
        where equipment_id = @equipmentID
		print 'Aktualizacja ceny zosta³a wykonana.'
    end
    else
    begin
        print 'Liczba produktów w zamówieniu jest mniejsza od minimalnej wymaganej. Brak aktualizacji ceny.'
    end
end

exec UpdatePrice  @equipmentID=1, @PercentageChange=10, @Min=1

exec UpdatePrice  @equipmentID=6, @PercentageChange=50, @Min=1

exec UpdatePrice  @equipmentID=7, @PercentageChange=80, @Min=1