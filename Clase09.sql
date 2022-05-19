use negocio;
show tables;

-- total de nacimientos por mes
select month(fecha) mes, count(*) cantidad from nacimientos group by mes;

select (
		CASE 
			WHEN month(fecha) = 1 THEN 'Enero'
            WHEN month(fecha) = 2 THEN 'Febrero'
            WHEN month(fecha) = 3 THEN 'Marzo'
            WHEN month(fecha) = 4 THEN 'Abril'
            WHEN month(fecha) = 5 THEN 'Mayo'
            WHEN month(fecha) = 6 THEN 'Junio'
            WHEN month(fecha) = 7 THEN 'Julio'
            WHEN month(fecha) = 8 THEN 'Agosto'
            WHEN month(fecha) = 9 THEN 'Septiembre'
            WHEN month(fecha) = 10 THEN 'Octubre'
            WHEN month(fecha) = 11 THEN 'Noviembre'
            WHEN month(fecha) = 12 THEN 'Diciembre'
		end
    ) mes, 
    count(*) cantidad 
	from nacimientos 
    group by month(fecha);  
    
create table meses(
	codigo int primary key,
    nombre varchar(20) not null
);

insert into meses values
	(1,'Enero'),
    (2,'Febrero'),
    (3,'Marzo'),
    (4,'Abril'),
    (5,'Mayo'),
    (6,'Junio'),
    (7,'Julio'),
    (8,'Agosto'),
    (9,'Septiembre'),
    (10,'Octubre'),
    (11,'Noviembre'),
    (12,'Diciembre');
    
select * from meses;
    
-- total de nacimientos por mes
select month(fecha) mes, count(*) cantidad from nacimientos group by mes;
-- total de nacimientos por mes
select (select nombre from meses where codigo=month(fecha)) mes, count(*) cantidad 
	from nacimientos group by mes order by month(fecha);
    
select m.nombre mes, count(*) cantidad from nacimientos n, meses m where month(n.fecha)=m.codigo group by month(fecha);


-- Uso de JOIN
select m.nombre mes, count(*) cantidad from nacimientos n join meses m on month(n.fecha)=m.codigo group by month(fecha);


-- consulta del producto relacionado
select * from clientes, facturas where codigo=codigoCliente;
select * from clientes, facturas where clientes.codigo=facturas.codigoCliente;
select * from clientes c, facturas f where c.codigo=f.codigoCliente;

select * from clientes c join facturas f on c.codigo=f.codigoCliente;

-- Left Join
select * from clientes c left join facturas f on c.codigo=f.codigoCliente;

-- Right Join
select * from clientes c right join facturas f on c.codigo=f.codigoCliente;

-- Quienes (nombre,apellido) compraron el dia de hoy?
select distinct c.nombre, c.apellido 
	from clientes c join facturas f on c.codigo=f.codigoCliente 
    where f.fecha=curdate();
    
insert into facturas values	
	('c',4001,curdate(),6000,1),
    ('c',4002,curdate(),4000,1),
    ('c',4003,curdate(),6000,3),
    ('c',4004,curdate(),6000,2),
    ('c',4005,curdate(),6000,2);

-- Cuales son las facturas de Diego Torres?
select f.letra, f.numero, f.fecha, f.monto 
	from clientes c join facturas f on c.codigo=f.codigoCliente
    where c.nombre='Diego' and c.apellido='Torres';
    
select f.letra, f.numero, f.fecha, f.monto 
	from facturas f join clientes c on c.codigo=f.codigoCliente
    where c.nombre='Diego' and c.apellido='Torres';
    
-- creamos la vista clientes facturas
create view clientes_facturas as
	select * from clientes c join facturas f on c.codigo=f.codigoCliente;
    
show tables;

select * from clientes_facturas;

select letra,numero,fecha,monto from clientes_facturas where nombre='Diego' and apellido='Torres';

-- cuanto se factura a cada cliente (nombre,apellido) ?
select c.codigo, c.nombre, c.apellido, sum(monto) total 
	from clientes c join facturas f on c.codigo=f.codigoCliente
    group by c.codigo;

select codigo, nombre, apellido, sum(monto) total 
	from clientes_facturas
    group by codigo;

-- total facturado por fecha
select fecha, sum(monto) total
	from clientes_facturas
	group by fecha;
    
select fecha, sum(monto) total
	from facturas
	group by fecha;

-- creamos clave foranea de nacimientos a meses
alter table nacimientos add codigoMes int after fecha;
update nacimientos set codigoMes=month(fecha);
set sql_safe_updates=0;
select * from nacimientos;
alter table nacimientos
	add constraint FK_nacimiento_codigoMes
    foreign key(codigoMes)
    references meses(codigo);

-- ------------------------
-- Agrego la tabla detalles
-- ------------------------
use negocio;
create table detalles(
letra char(1) not null,
numero int not null,
codigo int not null,
cantidad int unsigned not null,
primary key(letra,numero,codigo)
);

describe detalles;

select * from facturas;
select * from articulos;

-- creamos la restricción FK de detalles_facturas
alter table detalles 
	add constraint FK_detalles_factura
    foreign key(letra,numero)
    references facturas(letra,numero);

-- creamos la restricción FK de detalle_articulos
alter table detalles
	add constraint FK_detalles_articulos
    foreign key(codigo)
    references articulos(codigo);

-- ------------------------
-- inserto detalles de las facturas
-- ------------------------

insert into detalles values('a',1,3,10);
insert into detalles values('a',1,1,3);
insert into detalles values('a',1,5,3);
insert into detalles values('a',2,3,10);
insert into detalles values('b',3,3,10);
insert into detalles values('a',2,1,10);
insert into detalles values('b',3,1,10);
insert into detalles values('b',4,1,10);
insert into detalles values('b',5,1,10);

select * from clientes,facturas,detalles,articulos; -- producto cartesiano

select count(*) cantidad from clientes;											--    26
select count(*) cantidad from facturas;											--    23
select count(*) cantidad from detalles;											--     5
select count(*) cantidad from articulos;										--     7
select 26*23*5*7 cantidad;														-- 20930
select count(*) cantidad from clientes,facturas,detalles,articulos;				-- 20930

-- ------------------------
-- Consulta respetando las relaciones
-- ------------------------

select * from clientes c, facturas f,detalles d,articulos a 
	where c.codigo=f.codigoCliente and f.letra=d.letra 
	and f.numero=d.numero and d.codigo=a.codigo;
    
select * from clientes c join facturas f on c.codigo=f.codigoCliente
			join detalles d on f.letra=d.letra and f.numero=d.numero
            join articulos a on d.codigo=a.codigo;

-- ------------------------
-- que compro (articulos) Juan Perez?
-- ------------------------
select a.codigo, a.nombre, a.precio, a.stock, d.cantidad from clientes c join facturas f on c.codigo=f.codigoCliente
			join detalles d on f.letra=d.letra and f.numero=d.numero
            join articulos a on d.codigo=a.codigo
            where c.nombre='Juan' and c.apellido='Perez';

-- Quienes (nombre,apellido) compraron destornillador?
select distinct c.codigo, c.nombre, c.apellido 
	from clientes c join facturas f on c.codigo=f.codigoCliente
			join detalles d on f.letra=d.letra and f.numero=d.numero
            join articulos a on d.codigo=a.codigo
            where a.nombre='destornillador';
