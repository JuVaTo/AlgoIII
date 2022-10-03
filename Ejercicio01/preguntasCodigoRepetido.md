Preguntas Ejercicio Código Repetido


En los test 01 y 02 hay código repetido. Cuando lo extrajeron crearon algo nuevo. Eso es algo que estaba en la realidad y no estaba representado en nuestro código, por eso teníamos código repetido. ¿Cuál es esa entidad de la realidad que crearon?

Lo que se estaba repiendo es que se inicializaba un temporizador, ocurría un bloque de código y luego finalizaba el mismo. Finalmente se realizaba la resta de el tiempo final con el tiempo inicial y se comparaba con un tiempo máximo esperado. Lo que en la realidad pude representarse como un cronómetro, que lo hicimos utilizando el mensaje ya implementado de should:notTakeMoreThan:


¿Cuáles son las formas en que podemos representar entes de la realidad en Smalltalk que conocés? Es decir, ¿qué cosas del lenguaje Smalltalk puedo usar para representar entidades de la realidad?

Siguiendo el paradigma clásico de organización del conocimiento, los entes de la realidad pueden representarse como objetos que se relacionan entre sí a través de mensajes. Entre ellos tenemos las clases, que son objetos que representan conceptos de la realidad. Luego, tenemos las instancias que son objetos que representan cosas concretas de la realidad, y que no son necesariamente tangibles.


¿Qué relación hay entre sacar código repetido (creando abstracciones) y la teoría del modelo/sistema (del paper de Naur)?

Según la teoría del modelo/sistema de Naur, esta visión lleva a una noción de la vida de un programa que depende de su continuo mantenimiento por los programadores que poseen su teoría. Para llevar a cabo ese mantenimiento es importante la creación de abstracciones para eliminar el código repetido, ya que facilita la adaptación a los cambios que se realicen en el programa. Es decir, si tengo en varios lugares código repetido y ocurre un cambio en el programa que afecta esta parte, entonces todos los lugares donde tenga este código debe ser cambiados, en cambio si tenemos una abstracción realizada, únicamente tenemos que cambiar ese código.
También es importante destacar que el mantenimiento debe ser realizado por los programadores que poseen su teoría, relacionando con el código repetido, ellos son los que saben perfectamente cuáles son las abstracciones que fueron utilizadas, por lo que los cambios que realicen serán mucho mejores de los que puedan hacer programadores que no conozcan la teoría.
