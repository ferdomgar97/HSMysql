﻿# HSMysql
## Hearthstone SQL Database

Base de datos del juego de cartas coleccionables **Hearthstone** de la empresa **Blizzard Entertainment**.
Este videojuego se basa en el universo imaginario de Warcraft, otro de los videojuegos de esta empresa.

El juego consiste en partidas contra otros jugadores en modalidad 1 contra 1 en el que cada uno está
representado por un **heroe** que posee un **poder** exclusivo. Cada jugador tendrá un mazo de 30 **cartas** con
diversas **mecánicas**. Estas cartas se pueden clasificar por **expansiones**.


La base de datos incluirá las siguientes entidades y correspondientes atributos:

* Entidad HEROE.
  * Atributos: codClass, name.
       * Cada héroe tendrá un nombre de clase que lo identificará.
       * Existirá un héroe que englobará a todos, llamado Everyone.
       * Todos los atributos son obligatorios.
       * Los héroes usan muchas cartas diferentes.

| Atributo              | Tipo de dato                | Rango        | Clave | Obligatorio | Extra |
| --                    | --                          | --           | --    | --          | --    |
| CODHEROE              | Carácter                    | 20 variable  | Sí    | Sí          |       |
| NAME                  | Carácter                    | 60 variable  |       | Sí          |       |

* Entidad HEROE POWER.
  * Atributos: codHeroePw, descriptionHeroePower.
      * Cada clase tendrá un poder de héroe y solo uno.
      * Al igual que en la tabla HEROE, existe un valor que le corresponde a Everyone.
      * Todos los atributos son obligatorios.

| Atributo              | Tipo de dato                | Rango        | Clave | Obligatorio | Extra |
| --                    | --                          | --           | --    | --          | --    |
| CODHEROEPW            | Carácter                    | 20 variable  | Sí    | Sí          |       |
| DESCRIPTIONHEROEPOWER | Carácter                    | 60 variable  |       | Sí          |       |

* Entidad CARTA.
  * Atributos: codCarta, nameCard, rarity, type, cost damage, health, descriptionCard.
      * Las cartas se identificarán con un número exclusivo, por lo que no se podrá repetir.
      * Una carta la podrán usar todos los héroes o solamente uno.
      * Todas las cartas pertenecen a una expansión.
      * No todas las cartas tienen una mecánica y, si la tienen, a veces tiene varias.

| Atributo              | Tipo de dato                | Rango        | Clave | Obligatorio | Extra             |
| --                    | --                          | --           | --    | --          | --                |
| CODCARD	            | Número entero sin signo     | Sin asignar  | Sí    | Sí          | Autoincrementable |
| NAMECARD              | Carácter                    | 50 variable  |       | Sí          |                   |
| RARITY                | Carácter                    | 20 variable  |       | Sí          |                   |
| TYPE                  | Carácter                    | 30 variable  |       | Sí          |                   |
| COST                  | Número entero sin signo     | De 0 a 50    |       | Sí          |                   |
| DAMAGE                | Número entero sin signo     | De 0 a 50    |       | Sí          |                   |
| HEALTH                | Número entero sin signo     | De 0 a 50    |       | Sí          |                   |
| DESCRIPTIONCARD       | Carácter                    | 150 variable |       | No          |                   |

* Entidad EXPANSION.
  * Atributos: codExpansion, nameExpansion.
      * La expansión se identificará con un código único que lo diferenciará de cada una.
      * Todas las expansiones tienen cartas.

| Atributo              | Tipo de dato                | Rango        | Clave | Obligatorio | Extra             |
| --                    | --                          | --           | --    | --          | --                |
| CODEXPANSION	        | Número entero sin signo     | Sin asignar  | Sí    | Sí          | Autoincrementable |
| NAMEEXPANSION         | Carácter                    | 70 variable  |       | Sí          |                   |

* Entidad MECANICA.
  * Atributos: codMecanica, descriptionMechanic.
      * Las mecánicas se diferencian por su código de nombre.
      * Las mecánicas son asociadas a 1 o varias cartas.

| Atributo              | Tipo de dato                | Rango        | Clave | Obligatorio | Extra |
| --                    | --                          | --           | --    | --          | --    |
| CODMECHANIC           | Número entero sin signo     | De 1 a 30    | Sí    | Sí          |       |
| DESCRIPTIONMECHANIC   | Carácter                    | 70 variable  |       | No          |       |

Además existen las tablas **play, have y deck** para relación entre ellas y uso de procedimientos.

![Diagrama Entidad-Relación MysqlWorkbench](Documentacion/Diagrama%20E-R%20Workbench.png)
