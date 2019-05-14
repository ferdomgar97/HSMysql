/* Fernando Domínguez García */
/* Proyecto de base de datos de Hearthstone en MySQL */
use hearthstone;
delimiter $$
/* Funciones */

SET GLOBAL log_bin_trust_function_creators = 1 $$ /* Permisos para crear funciones */

/* Funcion que calcula la media del coste de mana del mazo */
drop function if exists f_AvgManaCostDeck $$
create function f_AvgManaCostDeck()
	returns smallint(50)
begin

	declare avgcost smallint(50);
    
    set avgcost = (select floor(avg(cost)) from card inner join deck where codCard = deck_codCard);
	return avgcost;
end; $$	


/* Funcion que cuenta el numero de legendarias que existen */
drop function if exists f_countLegendary $$
create function f_countLegendary()
	returns smallint(100)
begin

	declare counter smallint(100);
    
    set counter = (select count(*) from card where rarity like 'Legendary');
	return counter;
end; $$	


/* Funcion que indica la clase del mazo */
drop function if exists f_heroeDeck $$
create function f_heroeDeck()
	returns varchar(50)
begin

	declare heroeDeck varchar(50);
    
    set heroeDeck = (select distinct Heroe from deck where Heroe not like 'Everyone');
    return heroeDeck;
end; $$


/* Funcion que cuenta el numero de expansiones existentes */
drop function if exists f_expansion $$
create function f_expansion()
	returns smallint(20)
begin

	declare counter smallint(100);
    
    set counter = (select count(*) from expansion where nameExpansion not like 'Classic');
	return counter;
end; $$


/* Funcion que cuenta el numero de heroes */
drop function if exists f_heroe $$
create function f_heroe()
	returns smallint(20)
begin

	declare counter smallint(100);
    
    set counter = (select count(*) from heroe where codHeroe not like 'Everyone');
	return counter;
end; $$