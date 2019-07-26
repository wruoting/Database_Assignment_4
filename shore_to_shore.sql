-- Number 1
-- I am making an assumption that all building materials are labeled BL or WP
select shipment.*
from shipment
join captain on shipment.capt_id = captain.capt_id 
join shipment_line on shipment.shipment_id = shipment_line.shipment_id
join item on shipment_line.item_no = item.item_no 
where (item.item_type='BL' or item.item_type='WP') and 
shipment.destination='LONDON'
and 
(captain.capt_id=(select capt_id from captain where captain.fname='Cliff' and captain.lname='Walker') or
captain.capt_id=(select capt_id from captain where captain.fname='John' and captain.lname='Smith'));

-- Number 2
-- From these shore to shore scripts, it doesn't look like there are dates past 2011
select captain.* 
from captain
join shipment on captain.capt_id = shipment.capt_id
where shipment.destination='LONDON' and shipment.arrival_date > to_date('01-MAR-17','DD-MON-RR');

-- Number 3
select item.* from item 
join shipment_line on item.item_no=shipment_line.item_no
join shipment on shipment_line.shipment_id=shipment.shipment_id
where shipment.origin='SEATTLE';

-- Number 4
select item.item_no from item 
join shipment_line on item.item_no=shipment_line.item_no
join shipment on shipment_line.shipment_id=shipment.shipment_id
where shipment.origin='SEATTLE' 
group by item.item_no
having count(item.item_no) > 1;


-- Number 5
select captain.*
from shipment
join captain on shipment.capt_id = captain.capt_id 
join shipment_line on shipment.shipment_id = shipment_line.shipment_id
join item on shipment_line.item_no = item.item_no 
where item.description='Toyota Camry';

-- Number 6
select captain.* from captain 
join shipment on captain.capt_id = shipment.capt_id
where shipment.ship_no in
(select shipment.ship_no
from shipment
join shipment_line on shipment.shipment_id = shipment_line.shipment_id
join item on shipment_line.item_no = item.item_no 
where item.description='Toyota Camry');

-- Number 7
select origin, count(distinct(capt_id)) as Unique_Captains from shipment group by origin;
