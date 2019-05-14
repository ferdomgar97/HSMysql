/* Fernando Domínguez García */
/* Proyecto de base de datos de Hearthstone en MySQL */
use hearthstone;
delimiter $$
/* Procedimientos */
/* Procedimiento para insertar cartas */
drop procedure if exists p_insertaCard $$
create procedure p_insertaCard(
	in par_nameCard varchar(50), 
	in par_rarity varchar(20), 
	in par_type varchar(30), 
	in par_cost smallint(50), 
	in par_damage smallint(50), 
	in par_health smallint(50), 
	in par_descriptionCard varchar(150), 
	in par_card_codExpansion int(11),
    in par_play_codHeroe varchar(20))
begin
	insert into card values (NULL, par_nameCard, par_rarity, par_type, par_cost, par_damage, par_health, par_descriptionCard, par_card_codExpansion);
    insert into play values (par_play_codHeroe, (select codCard from card where nameCard = par_nameCard));
end; $$


/* Filtro legendarias del mazo */
drop procedure if exists p_legendaryFilter $$
create procedure p_legendaryFilter()
begin
	create view v_legendariasrepetidas as select count(*) from deck where Rarity like 'Legendary' group by nameCard having count(*) > 1;
if (select count(*) from v_legendariasrepetidas)>= 1 then truncate table deck;
end if;
drop view v_legendariasrepetidas;
end; $$


/* Filtro contador de cartas repetidas del mazo */
drop procedure if exists p_counter $$
create procedure p_counter()
begin
	create view v_conter as select count(*) from deck group by nameCard having count(*) > 2;
if (select count(*) from v_conter)>= 1 then truncate table deck;
end if;
drop view v_conter;
end; $$


set max_sp_recursion_depth=255 $$ /* Cambio del limite de recursividad */

/* Procedimiento que genera un mazo aleatorio */
drop procedure if exists p_createdeck $$
create procedure p_createdeck(in par_codHeroe varchar(20))
begin

	declare par_contador smallint unsigned default 0;
    declare par_nameCard varchar(50);
    declare par_codCard int;
    
    truncate table deck;
		while par_contador < 30 do /* Crea el mazo */
			set par_codCard = floor((select count(*) from Card) * rand()); /* Selecciona la carta*/
			/* Limitador de Clase */
			if ((select play_codHeroe from play where play_codCard = par_codCard) = par_codHeroe) or 
			((select play_codHeroe from play where play_codCard = par_codCard) = "Everyone") then
			/* Fin limitador de clase */
				set par_nameCard = (select nameCard from Card where codCard = par_codCard);/* Establece el nombre */
				insert into deck values (
					par_codCard,
					par_nameCard,
					(select play_codHeroe from play where play_codCard = par_codCard),
					(select rarity from card where par_codCard = codCard) );
				set par_contador = par_contador +1;
			end if;
		end while;
	/* Filtros*/
	call p_counter();
    call p_legendaryFilter(); 
    if (select count(*) from deck) = 0 then call p_createdeck(par_codHeroe);
	end if;
	/* Fin de filtros*/
end; $$


/* Procedimiento que cambia el nombre de un heroe */
drop procedure if exists p_beaheroe $$
create procedure p_beaheroe(in par_nameHeroe varchar(20), in par_classHeroe varchar (20))
begin

	declare par_randomClass smallint unsigned default 0;
	
    if 
		par_classHeroe like '' or
        par_classHeroe like 'Aleatorio'
	then
		while par_randomClass= 0 do
			set par_randomClass = floor(9 * rand());
		end while;
		case par_randomClass
			when 1 then set par_classHeroe = "Druid";
			when 2 then set par_classHeroe = "Hunter";
			when 3 then set par_classHeroe = "Mage";
			when 4 then set par_classHeroe = "Paladin";
			when 5 then set par_classHeroe = "Priest";
			when 6 then set par_classHeroe = "Rogue";
			when 7 then set par_classHeroe = "Shaman";
			when 8 then set par_classHeroe = "Warlock";
			when 9 then set par_classHeroe = "Warrior";
		end case;
	end if;
	update heroe set nameHeroe = par_nameHeroe
		where codHeroe = par_classHeroe;

end; $$


/* Procedimiento que actualiza la vista del mazo*/
drop procedure if exists p_updateVDeck $$
create procedure p_updateVDeck()
begin
	drop view if exists v_deck;
	create view v_deck as select nameCard, Heroe, Rarity, count(*) as 'Number' from deck group by nameCard;
end; $$
