use negocio;
show tables;

-- Ejemplo de producto cartesiano
create table techo(
    color varchar(25)
);
insert into techo values 
    ('Rojo'),('Negro'),('Blanco'),('Azul'),('Verde');

create table carrocerias(
    color varchar(25)
);
insert into carrocerias values 
    ('Rojo'),('Negro'),('Blanco'),('Azul'),('Verde');

create table tapizados(
    color varchar(25)
);
insert into tapizados values 
    ('Rojo'),('Negro'),('Blanco'),('Azul'),('Verde');

select * from techo, carrocerias, tapizados;
select count(*) cantidad from techo, carrocerias, tapizados;


-- Creamos la clave foranea
alter table facturas add codigoCliente int not null
describe facturas;

select * from clientes;
select * from facturas;
update facturas set codigoCliente=1 where letra='a' and numero=1;
update facturas set codigoCliente=301 where letra='a' and numero=2;

insert into facturas values ('a',3006,curdate(),6000,5);

update facturas set codigoCliente=1 where letra='a';
update facturas set codigoCliente=2 where letra='b';
update facturas set codigoCliente=3 where letra='c';
update facturas set codigoCliente=4 where letra='f';

-- creamos la restricción (constraint) de clave foranea. FOREIGN KEY (FK)
alter table facturas 
    add constraint FK_facturas_codigoCliente
    foreign key(codigoCliente)
    references clientes(codigo);

insert into facturas values ('a',3007,curdate(),6000,5);
insert into facturas values ('a',3008,curdate(),6000,500);

-- consulta del producto cartesiano
select * from clientes, facturas;

select count(*) cantidad from clientes;                 --  26
select count(*) cantidad from facturas;                 --  18
select 18*26;                                           -- 468
select count(*) cantidad from clientes,facturas;        -- 468
select count(*) cantidad from articulos;                --   7
select count(*) cantidad from clientes,facturas,articulos;  -- 3276


-- consulta del producto relacionado
select * from clientes, facturas where codigo=codigoCliente;
select * from clientes, facturas where clientes.codigo=facturas.codigoCliente;
select * from clientes c, facturas f where c.codigo=f.codigoCliente;



-- 7000000000000000000000


