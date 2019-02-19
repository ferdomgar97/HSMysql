/* Fernando Domínguez García */
/* Proyecto de base de datos de Hearthstone */
/* Crea la base de datos */
drop database if exists hearthstone;
create database hearthstone;
use hearthstone;

/* Borrado de tablas si existieran */

drop table if exists expansion;
drop table if exists heroe;
drop table if exists heroepower;
drop table if exists card;
drop table if exists mechanic;
drop table if exists play;
drop table if exists have;

/* Creación de tablas */

create table expansion(
	codExpansion smallint (10),
	nameExpansion varchar (70) not null,
	primary key (codExpansion)
) ENGINE =INNODB;


create table heroe(
	codHeroe varchar (20),
	nameHeroe varchar (60) not null,
	primary key (codHeroe)
) ENGINE =INNODB;


create table heroepower(
	codHeroePw varchar (20),
	heroepower_codHeroe varchar (20),
	descriptionHeroePower varchar (60) not null,
	primary key (codHeroePw, heroepower_codHeroe),

	constraint fk_power_heroe
		foreign key (heroepower_codHeroe)
		references heroe (codHeroe)
	on delete cascade on update cascade
) ENGINE =INNODB;

create table card(
	codCard smallint unsigned,
	nameCard varchar (50) not null,
	rarity varchar (20) not null,
	type varchar (30) not null,
	cost smallint(50) not null,
	damage smallint (50) not null,
	health smallint (50) not null,
	descriptionCard varchar (150),
	card_codExpansion smallint (10) not null,
	primary key (codCard),

	constraint fk_card_expansion
		foreign key (card_codExpansion)
		references expansion (codExpansion)
	on delete cascade on update cascade
) ENGINE =INNODB;


create table mechanic(
	codMechanic varchar (30),
	descriptionMechanic varchar (70),
	primary key (codMechanic)
) ENGINE =INNODB;


create table play(
	play_codHeroe varchar (20),
	play_codCard smallint unsigned,
	primary key (play_codHeroe, play_codCard),

	constraint fk_play_heroe
		foreign key (play_codHeroe)
		references heroe (codHeroe)
	on delete cascade on update cascade,

	constraint fk_play_card
		foreign key (play_codCard)
		references card (codCard)
	on delete cascade on update cascade
)ENGINE =INNODB;


create table have(
	have_codCard smallint unsigned,
	have_codMechanic varchar (30),
	primary key (have_codCard, have_codMechanic),

	constraint fk_have_card
		foreign key (have_codCard)
		references card (codCard)
	on delete cascade on update cascade,

	constraint fk_have_mechanic
		foreign key (have_codMechanic)
		references mechanic (codMechanic)
	on delete cascade on update cascade
)ENGINE =INNODB;


/* Introducción de los datos a la base de datos */


load data local infile "Expansion.csv" replace
	into table expansion
	character set UTF8
	fields terminated by ";"
	lines terminated by "\r\n";

load data local infile "Heroe.csv" replace
	into table heroe
	character set UTF8
	fields terminated by ";"
	lines terminated by "\r\n";

load data local infile "HeroePower.csv" replace
	into table heroepower
	character set UTF8
	fields terminated by ";"
	lines terminated by "\r\n";

load data local infile "Card.csv" replace
	into table card
	character set UTF8
	fields terminated by ";"
	lines terminated by "\r\n";

load data local infile "Mechanic.csv" replace
	into table mechanic
	character set UTF8
	fields terminated by ";"
	lines terminated by "\r\n";

load data local infile "Play.csv" replace
	into table play
	character set UTF8
	fields terminated by ";"
	lines terminated by "\r\n";

load data local infile "Have.csv" replace
	into table have
	character set UTF8
	fields terminated by ";"
	lines terminated by "\r\n";


/* Actualización para los valores NULL */


update card
	set descriptionCard = NULL
where codCard in (573, 753, 775, 776, 777, 778, 780, 781, 852, 855, 857, 870, 875, 884, 892, 899, 904);

update mechanic
	set descriptionMechanic = NULL
where codMechanic = "Choose One";
