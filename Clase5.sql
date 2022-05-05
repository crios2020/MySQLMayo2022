-- Carlos Rios			carlos.rios@educacionit.com
-- Github: 				https://github.com/crios2020/MySQLMayo2022

drop database if exists negocio;
create database negocio;
use negocio;

create table clientes (
codigo integer auto_increment,
nombre varchar(20) not null,
apellido varchar(20) not null,
cuit char(13),
direccion varchar(50),
comentarios varchar(140),
primary key (codigo)
);

create table facturas(
letra char(1),
numero integer,
fecha date,
monto double,
primary key (letra,numero)
);

create table articulos(
codigo integer auto_increment,
nombre varchar(50),
precio double,
stock integer,
primary key (codigo)
);

insert into clientes (nombre,apellido,cuit,direccion) values ('juan','perez','xxxxx','peru 323');
insert into clientes (nombre,apellido,cuit,direccion) values ('diego','torres','xxxxx','chile 320');
insert into clientes (nombre,apellido,cuit,direccion) values ('laura','gomez','xxxxx','san juan 420');
insert into clientes (nombre,apellido,cuit,direccion) values ('mario','lopez','xxxxx','lavalle 770');
insert into clientes (nombre,apellido,cuit,direccion) values ('dario','sanchez','xxxxx','mexico 150');

insert into articulos values (1,'destornillador',25,50);
insert into articulos values (2,'pinza',35,22);
insert into articulos values (3,'martillo',15,28);
insert into articulos values (4,'maza',35,18);
insert into articulos values (5,'valde',55,13);

insert into facturas values ('a',0001,'2011/10/18',500);
insert into facturas values ('a',0002,'2011/10/18',2500);
insert into facturas values ('b',0003,'2011/10/18',320);
insert into facturas values ('b',0004,'2011/10/18',120);
insert into facturas values ('b',0005,'2011/10/18',560);
-- inserto un registro con la fecha actual
insert into facturas values ('c',0006,curdate(),300);

insert into clientes (nombre,apellido,cuit,direccion) values ('maria','fernandez','xxxxx','');
insert into clientes (nombre,apellido,cuit,direccion) values ('gustavo','ramirez','xxxxx',null);


insert into facturas values ('f',0006,curdate(),300);
insert into facturas values ('f',0007,curdate(),400);

insert into clientes (nombre,apellido,cuit,direccion) values ('jose','benuto','3647493','loria 940');

insert into facturas (letra,numero,fecha,monto) values ('a',1001,'2012/10/25',350);
insert into facturas (letra,numero,fecha,monto) values ('a',1002,curdate(),540);

insert into articulos (codigo,nombre,precio,stock) values (110,'destornillador',30,100);
insert into articulos (codigo,nombre,precio,stock) values (111,'martillo',40*1.21,50);

insert into clientes (nombre,apellido,direccion) values ('Andrea','Abate','Laprida 648');
insert into clientes (apellido,nombre) values ('Stuart','Jhon');
insert into clientes values(null,'Laura','Georgeff','56565','Berutti 2589','');
insert into clientes (codigo,nombre,apellido,cuit,direccion) values (null,'jose','sanchez','xxxxx','chile 150');
insert into clientes values (null,'marta','martinez','xxxxx','florida 150','');
insert into clientes (nombre,apellido,cuit,direccion) values ('carlos','flores','xxxxx','bolivar 150');
insert into clientes values (20,'Romeo','Lopez','34343434','Anchorena 950','');
insert into clientes (nombre,apellido,cuit,direccion) values ('Florencia','Salinas','82828282','W.Morris 3420');
insert into clientes (apellido,nombre,direccion) values ('Ana','Salone',null);

-- ctrol enter para ejecutar

select version();			-- Muestra la version del server
select curtime();			-- Muestra la hora del server

show tables;				-- Muestra el catalogo de tablas
describe articulos;			-- Muestra el metadato de la tabla, (Metadato = estructura de tabla(lista de campos))
describe clientes;
describe facturas;
describe nacimientos;

select * from articulos;
select * from clientes;
select * from facturas;

select * from nacimientos;
select count(*) cantidad from nacimientos;
select * from nacimientos limit 200000;

-- select * from colegio.cursos where titulo like '%mysql%';

-- Funciones de agrupamiento

-- Función max(arg)  	arg: numerico, texto, fecha
select max(EDAD_MADRE) from nacimientos;
select max(EDAD_MADRE) Edad_Máxima from nacimientos;
select max(PESO) Peso_Máximo from nacimientos;
select max(ESTABLECIMIENTO) Ultimo_Establecimiento from nacimientos;
select max(nombre) ultimo_nombre from clientes;
select max(fecha) ultima_fecha from nacimientos;
select max(fecha) ultima_fecha from facturas;

-- Función min(arg) 	arg: numerico, texto, fecha
select min(EDAD_MADRE) Edad_Mínima from nacimientos;
select min(PESO) Peso_Mínimo from nacimientos;
select min(ESTABLECIMIENTO) Primer_Establecimiento from nacimientos;
select min(nombre) primer_nombre from clientes;
select min(fecha) primer_fecha from nacimientos;
select min(fecha) primer_fecha from facturas;

-- función sum(arg)   	arg: numerico
select sum(monto) total from facturas;
select sum(nombre) from clientes;		-- no de error!!
select sum(cuit) from clientes;			-- no da error!!

-- función avg(arg) 	arg: numerico		avg - average - promedio
select avg(monto) promedio from facturas;
select avg(EDAD_MADRE) Promedio_Edad from nacimientos;
select round(avg(EDAD_MADRE),0) Promedio_Edad from nacimientos;
select avg(PESO) Promedio_de_Peso from nacimientos;
select round(avg(PESO),2) Promedio_de_Peso from nacimientos;

-- función count(*)
select count(*) cantidad_nacimientos from nacimientos;									-- 193184
select count(*) cantidad_nenas from nacimientos where SEXO='Femenino';					--  94763
select count(*) cantidad_nenes from nacimientos where SEXO='Masculino';					--  98397
select count(*) cantidad_indeterminado from nacimientos where SEXO='Indeterminado';		-- 24

select
		(select count(*) cantidad_nenas from nacimientos where SEXO='Femenino')	-- nenas
        +
        (select count(*) cantidad_nenes from nacimientos where SEXO='Masculino')	-- nenes
        cantidad ;
select distinct SEXO from nacimientos;
 
select count(*) cantidad from clientes; 				-- 22
select count(direccion) cantidad from clientes;			-- 14

select count(*) cantidad from clientes where direccion is not null;		-- 14
select count(fecha) cantidad from facturas;
select count(*) cantidad from facturas; 


describe nacimientos;
insert into clientes (nombre,apellido) values ('victor','Perez'),('ana','Perez');
insert into clientes (nombre,apellido) values ('abel','Perez');
insert into clientes (nombre,apellido) values ('Laura','Perez'), ('Laura','Perez');

select * from nacimientos;
select * from clientes order by apellido, nombre;
select * from clientes;

-- uso del disctinct 
select nombre from clientes;
select distinct nombre from clientes;
select distinct nombre, apellido from clientes;

-- Tema pendiente GROUP BY  - HAVING










				
