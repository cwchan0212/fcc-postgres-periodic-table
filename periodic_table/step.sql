alter table properties rename weight to atomic_mass;
alter table properties rename melting_point to melting_point_celsius;
alter table properties rename boiling_point to boiling_point_celsius;
alter table properties alter column melting_point_celsius set not null;
alter table properties alter column boiling_point_celsius set not null;
alter table elements add unique(symbol);
alter table elements add unique(name);
alter table elements alter column symbol set not null;
alter table elements alter column name set not null;
alter table properties add foreign key (atomic_number) references elements (atomic_number);
create table types (type_id serial primary key, type varchar(50) not null);
insert into types (type_id, type) values (1, 'nonmetal'), (2, 'metal'), (3,'metalloid');
alter table properties add column type_id int;
update properties set type_id = 1 where type = 'nonmetal';
update properties set type_id = 2 where type = 'metal';
update properties set type_id = 3 where type = 'metalloid';
alter table properties alter column type_id set not null;
alter table properties add foreign key (type_id) references types (type_id);
update elements set symbol = 'He' where symbol = 'he';
update elements set symbol = 'Li' where symbol = 'li';
update elements set symbol = 'Mt' where symbol = 'mT';
insert into elements (atomic_number, symbol, name) values (9, 'F', 'Fluorine'), (10, 'Ne', 'Neon');
insert into properties (atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) values (9, 'nonmetal', 18.998, -220, -188.1, 1), (10, 'nonmetal', 20.18, -248.6, -246.1, 1); 
UPDATE properties SET atomic_mass=trim(trailing '0' from atomic_mass::text)::numeric;


"SELECT elements.atomic_number, elements.name, elements.symbol, properties.type_id, types.type, properties.atomic_mass, properties.melting_point_celsius, boiling_point_celsius
FROM properties 
INNER JOIN elements ON elements.atomic_number = properties.atomic_number 
INNER JOIN types ON types.type_id = properties.type_id 
ORDER BY elements.atomic_number;"


SELECT elements.atomic_number, elements.name, elements.symbol, properties.type_id, types.type, properties.atomic_mass, properties.melting_point_celsius, boiling_point_celsius
FROM properties 
INNER JOIN elements ON elements.atomic_number = properties.atomic_number 
INNER JOIN types ON types.type_id = properties.type_id where elements.atomic_number = 1
ORDER BY elements.atomic_number limit 1;


select elements.atomic_number, elements.name, elements.symbol, properties.type_id, properties.atomic_mass, properties.melting_point_celsius, boiling_point_celsius from properties 
inner join elements on elements.atomic_number = properties.atomic_number 
inner join types on types.type_id = properties.type_id;

atomic_number | atomic_mass | melting_point_celsius | boiling_point_celsius | type_id | atomic_number | symbol |   name  |   type 