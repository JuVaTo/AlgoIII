Preguntas Ataques Fantasticos paso 2


1, ¿Qué crítica le harías al protocolo de #estaHerido y #noEstaHerido? (en vez de tener solo el mensaje #estaHerido y hacer “#estaHerido not” para saber la negación)

Tener los dos mensajes (con sus respectivos métodos)  #estaHerido y #noEstaHerido rompe con la idea de tener un conjunto de mensajes minimal, en especial cuando podemos obtener el mismo resultado con un solo mensaje y aplicando el not. Además, a la hora de leer el código no se pierde la claridad del mensaje.


2. ¿Qué opinan de que para algunas funcionalidades tenemos 3 tests para el mismo comportamiento pero aplicando a cada uno de los combatientes (Arthas, Mankrik y Olgra)

En el caso de que los resultados y las pruebas sean iguales es redundante, ya que los tres combatientes tienen el mismo comportamiento. Por ejemplo, las pruebas número 23, 24 y 25 en CombatientesTest hacen exactamente lo mismo, por lo que tener una única prueba alcanzaría. 

Vale destacar que es importante tener una buena cantidad de pruebas, y que estas prueben distintas funcionalidades, es decir que sean pruebas variadas. Para así lograr una mayor detención de errores y obter un resultado más confiable.


3. ¿Cómo modelaron el resultado de haber desarrollado un combate? ¿qué opciones consideraron y por qué se quedaron con la que entregaron y por qué descartaron a las otras?

Ambos bandos son colaboradores internos del OrquestadorDeCombatesTest, por lo que, una vez desarrollado el combate se observa el resultado analizando como quedaron los combatientes de cada bando. 
No se nos ocurrió otra forma de modelar el resultado, ya que la opción que utilizamos nos pareció correcta y no nos trajo mayores problemas. 
