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

-- HAVING 



-- SubsQueries