show databases;
use negocio;
show tables;

-- Tema pendiente GROUP BY  
select letra,sum(monto) total from facturas where letra='a';
select letra,sum(monto) total from facturas where letra='b';
select letra,sum(monto) total from facturas where letra='c';
select letra,sum(monto) total from facturas where letra='f';

/*
		Total facturado por letra de factura
		letra		total
        a			3890
        b			1000
        c 			 300
        f			 700
*/

select sum(monto) total from facturas;					-- 5890
select 
	(select sum(monto) from facturas where letra='a')+
    (select sum(monto) from facturas where letra='b')+
    (select sum(monto) from facturas where letra='c')+
    (select sum(monto) from facturas where letra='f')
    total;												-- 5890


select distinct letra from facturas;
-- cantidad de facturas;
select count(distinct letra) cantidad_de_letras from facturas;

-- cantidad de estableciemintos;
select distinct establecimiento from nacimientos;
select count(distinct establecimiento) cantidad from nacimientos;

select * from nacimientos;

-- cantidad de nacimientos por estado civil de madre
select distinct estado_civil_madre from nacimientos;

select estado_civil_madre, count(*) cantidad from nacimientos where estado_civil_madre='Soltera';
select estado_civil_madre, count(*) cantidad from nacimientos where estado_civil_madre='Casada';
select estado_civil_madre, count(*) cantidad from nacimientos where estado_civil_madre='Concubinato';
select estado_civil_madre, count(*) cantidad from nacimientos where estado_civil_madre='Divorciada';
select estado_civil_madre, count(*) cantidad from nacimientos where estado_civil_madre='Desconocido';

/*
		estado_civil_madre		cantidad
        Soltera					141673
        Casada					 50885
        Concubinato				   564
        Divorciada				    50
        Desconocido				    12
*/

-- cantidad de tipos de parto
select distinct tipo_parto from nacimientos;

select letra,sum(monto) total from facturas group by letra;
select estado_civil_madre, count(*)  from nacimientos group by estado_civil_madre;
select establecimiento, count(*) cantidad from nacimientos group by establecimiento;
select establecimiento, count(*) cantidad from nacimientos group by establecimiento order by cantidad desc;

select * from nacimientos;
-- Cantidad de bbs nacidos por fecha
select fecha, count(*) cantidad from nacimientos group by fecha;

-- Transformar el campo fecha de text a date
-- alter table nacimientos modify fecha date;
alter table nacimientos add FECHA2 date after fecha;

select concat(substring(fecha,7,4),'/',substring(fecha,4,2),'/',substring(fecha,1,2)) fecha from nacimientos;
update nacimientos set fecha2=concat(substring(fecha,7,4),'/',substring(fecha,4,2),'/',substring(fecha,1,2));

set sql_safe_updates=0;		-- =0 desactiva safe updates		=1 activa safe updates

alter table nacimientos drop fecha;
alter table nacimientos change fecha2 fecha date;

-- Cantidad de bbs nacidos por mes
select month(fecha) mes, count(*) cantidad from nacimientos group by month(fecha);
-- select substring(fecha,4,2) mes, count(*) cantidad from nacimientos group by mes;
-- select substring(fecha,4,2) mes, count(*) cantidad from nacimientos group by substring(fecha,4,2);
select fecha from nacimientos;

describe nacimientos;

-- total de bbs nacidos por mes y por hospital
select month(fecha) mes, establecimiento, count(*) cantidad from nacimientos group by month(fecha), establecimiento;

-- total facturado por mes
select * from facturas;
select year(fecha) año, month(fecha) mes, sum(monto) total from facturas group by year(fecha),month(fecha);


-- HAVING 
select letra, sum(monto) total from facturas group by letra having total>=1000;
select letra, sum(monto) total from facturas group by letra having sum(monto)>=1000;

-- total de bbs nacidos por hospital solo ver hospitales donde nacieron mas de 1000
select establecimiento, count(*) cantidad from nacimientos group by establecimiento having cantidad>=1000;
select establecimiento, count(*) cantidad from nacimientos group by establecimiento having count(*)>=1000;

-- total de bbs nacidos por hospital solo ver hospitales donde nacieron mas de 1000 y que las madres sean de nacionalidad chilena
select establecimiento, count(*) cantidad from nacimientos where nacionalidad='CHILENA' group by establecimiento having count(*)>=1000;


insert into facturas values ('c',5001,curdate(),2500);
-- SubsQueries subconsultas
select max(monto) from facturas;				-- 2500
select * from facturas where monto=2500;

select * from facturas where monto=(select max(monto) from facturas);

select 
	(select sum(monto) from facturas where letra='a')+
    (select sum(monto) from facturas where letra='b')+
    (select sum(monto) from facturas where letra='c')+
    (select sum(monto) from facturas where letra='f')
    total;	

-- 1- Crear la tabla 'autos' en una nueva base de datos (Vehiculos) con el siguiente detalle:

-- 	codigo	INTEGER y PK
-- 	marca	VARCHAR(25)
-- 	modelo	VARCHAR(25)
-- 	color	VARCHAR(25)
-- 	anio	INTEGER
-- 	precio	DOUBLE

--  nota: (anio - año) seguramente tu computadora tiene soporte para la letra ñ,
--        pero muchas instalaciones (ej: web host alquilados) pueden que no tenga soporte para esa letra.
-- 		  en programación se acostumbra a usar los caracteres menores a 128 en la tabla ASCII.

create table autos(
	codigo int auto_increment primary key,
    marca varchar(25),
    modelo varchar(25),
    color varchar(25),
    anio int,
    precio double
);

-- 2- Agregar el campo patente despues del campo modelo.
alter table autos add patente varchar(10) after modelo;

-- 3- Cargar la tabla con 15 autos (hacerlo con MySQL WorkBench o el INSERT INTO).
insert into autos (marca,modelo,color,anio,precio) values ('Ford','Ka','Negro',2011,1000000);
insert into autos (marca,modelo,color,anio,precio) values ('VW','Suran','Negro',2015,2000000);
insert into autos (marca,modelo,color,anio,precio) values ('VW','Gol','Rojo',2016,2000000);
insert into autos (marca,modelo,color,anio,precio) values ('Peugeot','208','Negro',2016,2200000);
insert into autos (marca,modelo,color,anio,precio) values ('Renault','Clio','Azul',2010,1000000);

-- 4- Realizar las siguientes consultas:

-- 	a. obtener el precio máximo.
-- select precio from autos order by precio desc limit 1;
select max(precio) precio_máximo from autos;

-- 	b. obtener el precio mínimo.
select min(precio) precio_máximo from autos;

-- 	c. obtener el precio mínimo entre los años 2010 y 2018.
select min(precio) precio_mínimo from autos where anio>=2010 and anio<=2018;
select min(precio) precio_mínimo from autos where anio between 2010 and 2018;

-- 	d. obtener el precio promedio.
select avg(precio) precio_promedio from autos;

-- 	e. obtener el precio promedio del año 2016.
select avg(precio) precio_promedio from autos where anio=2016;

-- 	f. obtener la cantidad de autos.
select count(*) cantidad from autos;

-- 	g. obtener la cantidad de autos que tienen un precio entre $2.000.000 y $2.400.000.
select count(*) cantidad from autos where precio between 2000000 and 24000000;

-- 	h. obtener la cantidad de autos que hay en cada año.
select anio año, count(*) cantidad from autos group by anio;

-- 	i. obtener la cantidad de autos y el precio promedio en cada año.
select anio año, count(*) cantidad, avg(precio) promedio from autos group by anio;

-- 	j. obtener la suma de precios y el promedio de precios según marca.
select marca, sum(precio) suma_de_precios, avg(precio) promedio from autos group by marca;

--  k. informar los autos con el menor precio.
-- select * from autos order by precio limit 2;
select * from autos where precio=(select min(precio) from autos);

--  l. informar los autos con el menor precio entre los años 2016 y 2018.
select * from autos where anio between 2010 and 2018 and precio=(select min(precio) from autos where anio between 2010 and 2018);

--  m. listar los autos ordenados ascendentemente por marca,modelo,año.
select * from autos order by marca, modelo, anio;

--  n. contar cuantos autos hay de cada marca.
select marca, count(*) cantidad from autos group by marca;

--  o. borrar los autos del siglo pasado.
delete from autos where anio <2000;

select * from  nacimientos where fecha=curdate();
insert into nacimientos (fecha) values (curdate());
select * from autos;












