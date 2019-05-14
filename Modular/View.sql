/* Fernando Domínguez García */
/* Proyecto de base de datos de Hearthstone en MySQL */
use hearthstone;
/* Vistas */

/* Vista del mazo*/
drop view if exists v_deck; 
create view v_deck as select nameCard, Heroe, Rarity, count(*) as 'Number' from deck group by nameCard;


/* Vista de las expansiones de cada carta*/
drop view if exists v_cardexpansion;
create view v_cardexpansion as select distinct nameCard, nameExpansion from card inner join expansion where card_codExpansion = codExpansion;
