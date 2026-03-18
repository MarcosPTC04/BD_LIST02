use bd_02;

create table banco(
codigo int not null auto_increment primary key,
nome varchar(45)
);

create table agencia(
numero_agencia int not null auto_increment,
endereco varchar(100),
cod_banco int,
primary key(numero_agencia, cod_banco),
foreign key (cod_banco) references banco(codigo)
);

create table conta(
num_conta varchar(7) not null primary key,
saldo float not null,
tipo_conta int,
num_agencia int,
foreign key (num_agencia) references agencia(numero_agencia)
);

create table cliente(
cpf varchar(14) not null primary key,
nome varchar(45) not null,
endereco varchar(45),
sexo char(1) 
);

create table telefone_cliente(
cpf_cli varchar(14),
telefone varchar(20),
primary key (cpf_cli, telefone),
foreign key (cpf_cli) references cliente(cpf)
);

create table historico(
cpf varchar(14),
num_conta varchar(7),
data_inicio date,
primary key (cpf, num_conta),
foreign key (cpf) references cliente(cpf),
foreign key (num_conta) references conta(num_conta)
);

-- -------------------------------

INSERT INTO banco VALUES (1, 'Banco do Brasil');
INSERT INTO banco VALUES (4, 'CEF');

INSERT INTO agencia VALUES ('0562', 'Rua Joaquim Teixeira Alves, 1555', 4);
INSERT INTO agencia VALUES ('3153', 'Av. Marcelino Pires, 1960', 1);

INSERT INTO cliente VALUES ('111.222.333-44', 'Jennifer B Souza', 'Rua Cuiabá, 1050', 'F');
INSERT INTO cliente VALUES ('666.777.888-99', 'Caetano K Lima', 'Rua Ivinhema, 879', 'M');
INSERT INTO cliente VALUES ('555.444.777-33', 'Silvia Macedo', 'Rua Estados Unidos, 735', 'F');

INSERT INTO conta VALUES ('86340-2', 763.05, 2, '3153');
INSERT INTO conta VALUES ('23584-7', 3879.12, 1, '0562');

INSERT INTO historico VALUES ('111.222.333-44', '23584-7', '1997-12-17');
INSERT INTO historico VALUES ('666.777.888-99', '23584-7', '1997-12-17');
INSERT INTO historico VALUES ('555.444.777-33', '86340-2', '2010-11-29');

INSERT INTO telefone_cliente VALUES ('111.222.333-44', '(67)3422-7788');
INSERT INTO telefone_cliente VALUES ('666.777.888-99', '(67)3423-9900');
INSERT INTO telefone_cliente VALUES ('666.777.888-99', '(67)8121-8833');

-- --------------------------------

alter table conta drop constraint conta_ibfk_1;
alter table conta add constraint conta_ibfk_1
foreign key (num_agencia) references agencia (numero_agencia)
on delete cascade on update cascade;

alter table historico drop constraint historico_ibfk_2;
alter table historico add constraint historico_ibfk_2
foreign key (num_conta) references conta (num_conta)
on delete cascade on update cascade;

alter table cliente
add email VARCHAR(45);

select cpf, endereco from cliente 
where nome like 'C%';

update agencia set numero_agencia = 6342 where numero_agencia = 0562;

update cliente set email = 'caetanolima@gmail.com' where nome = 'Caetano K Lima';

update conta set saldo = saldo *1.1 where num_conta = "23584-7";

insert into agencia(numero_agencia, endereco, cod_banco)
values(1333, "Rua João José da Silva, 486", 1);

select numero_agencia, endereco from agencia 
where cod_banco = 1;

select * from cliente 
where sexo = "M";

delete from conta where num_conta = "86340-2";


