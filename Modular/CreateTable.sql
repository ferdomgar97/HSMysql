/* Fernando Domínguez García */
/* Proyecto de base de datos de Hearthstone en MySQL */
drop database if exists hearthstone;
create database hearthstone;
use hearthstone;

/* Borrado de tablas si existieran */
drop table if exists have;
drop table if exists play;
drop table if exists mechanic;
drop table if exists deck;
drop table if exists card;
drop table if exists heroepower;
drop table if exists heroe;
drop table if exists expansion;


/* Creación de tablas */

create table expansion(
	codExpansion int auto_increment,
	nameExpansion varchar (70) not null,
	primary key (codExpansion)
)ENGINE=InnoDB;


create table heroe(
	codHeroe varchar (20),
	nameHeroe varchar (60) not null,
	primary key (codHeroe, nameHeroe)
)ENGINE=InnoDB;


create table heroepower(
	codHeroePw varchar (20),
	heroepower_codHeroe varchar (20),
	descriptionHeroePower varchar (60) not null,
	primary key (codHeroePw, heroepower_codHeroe),

	constraint fk_power_heroe
		foreign key (heroepower_codHeroe)
		references heroe (codHeroe)
	on delete cascade on update cascade
)ENGINE=InnoDB;

create table card(
	codCard int auto_increment not null,
	nameCard varchar (50) not null,
	rarity varchar (20) not null,
	type varchar (30) not null,
	cost smallint(50) not null,
	damage smallint(50) not null,
	health smallint(50) not null,
	descriptionCard varchar (150) default NULL,
	card_codExpansion int not null,
	primary key (codCard),

	constraint fk_card_expansion
		foreign key (card_codExpansion)
		references expansion (codExpansion)
	on delete cascade on update cascade
)ENGINE=InnoDB;


create table mechanic(
	codMechanic varchar (30),
	descriptionMechanic varchar (70),
	primary key (codMechanic)
)ENGINE=InnoDB;


create table play(
	play_codHeroe varchar (20),
	play_codCard int,
	primary key (play_codHeroe, play_codCard),

	constraint fk_play_heroe
		foreign key (play_codHeroe)
		references heroe (codHeroe)
	on delete cascade on update cascade,

	constraint fk_play_card
		foreign key (play_codCard)
		references card (codCard)
	on delete cascade on update cascade
)ENGINE=InnoDB;


create table have(
	have_codCard int,
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
)ENGINE=InnoDB;


/* Creado de la tabla "deck" para el procedimiento */
create table deck(
	deck_codCard int,
	nameCard varchar(50),
    Heroe varchar(20),
    Rarity varchar(20),
    
	constraint fk_deck_card
		foreign key (deck_codCard)
		references card (codCard)
	on delete cascade on update cascade
    )ENGINE=InnoDB;

/* Evento que vacia el mazo cada semana */
create event ev_DelBackupCard
on schedule every 1 week
do truncate deck $$