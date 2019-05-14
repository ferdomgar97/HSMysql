/* Fernando Domínguez García */
/* Proyecto de base de datos de Hearthstone en MySQL */
use hearthstone;
delimiter $$
/* Disparadores */

/* Disparador que cambia las descripciones vacias a NULL */
drop trigger if exists t_nullDescriptionCard $$
create trigger t_nullDescriptionCard 
	before insert on card for each row 
		if new.descriptionCard like '' then set new.descriptionCard = NULL; 
        end if; 
$$


/* Disparador que se asegura de que el mazo esta bien creado */
drop trigger if exists t_deck $$
create trigger t_deck 
	before update on deck for each row 
    call p_legendaryFilter();
    call p_counter();
$$

/**/
delimiter $$
drop trigger if exists t_deckmaker; $$
create trigger t_deckmaker 
	before delete on deck for each row 
		begin
		
        declare par_randomClass smallint unsigned default 0;
		declare par_classHeroe varchar (20);
        
        if (select count(*) from deck) = 0 then
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
			call p_createdeck(par_classHeroe);
		end if;
    end;
        $$


/* Disparador que solo permite insertar heroes de las clases existentes */
drop trigger if exists t_heroeLimiter $$ 
create trigger t_heroeLimiter /* Intentar añadir un heroe*/
	after insert on heroe for each row 
		if 
			new.codHeroe not like 'Druid' or
			new.codHeroe not like 'Hunter' or
			new.codHeroe not like 'Mage' or
			new.codHeroe not like 'Paladin' or
			new.codHeroe not like 'Priest' or
			new.codHeroe not like 'Rogue' or
			new.codHeroe not like 'Shaman' or
			new.codHeroe not like 'Warlock' or
			new.codHeroe not like 'Warrior' 
		then delete from heroe where codHeroe = new.codHeroe;
    end if;$$
 
 
/* Disparador que actualiza la vista del mazo */
drop trigger if exists t_updateVDeck $$
create trigger t_updateVDeck
	before update on deck for each row 
	call p_updateVDeck();
$$

delimiter ;