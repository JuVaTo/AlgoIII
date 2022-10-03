Preguntas teóricas
Aporte de los mensajes de DD
En un double dispatch (DD), ¿qué información aporta cada uno de los dos llamados?


Lógica de instanciado
Con lo que vieron y saben hasta ahora, ¿donde les parece mejor tener la lógica de cómo instanciar un objeto? ¿por qué? ¿Y si se crea ese objeto desde diferentes lugares y de diferentes formas? ¿cómo lo resuelven?


Nombres de las categorías de métodos
Con lo que vieron y trabajaron hasta ahora, ¿qué criterio están usando para categorizar métodos?
El criterio es en función de que hace el método; si son privados, de creación de instancias, de mensajes de error, de DD, etc...

Subclass Responsibility
Si todas las subclases saben responder un mismo mensaje, ¿por qué ponemos ese mensaje sólo con un “self subclassResponsibility” en la superclase? ¿para qué sirve?
A la hora de crear una nueva subclase, observando que en la superclase existe el mensaje con el "self subclassresponsability" sabemos que se debe definir el mensaje.


No rompas
¿Por qué está mal/qué problemas trae romper encapsulamiento?
Si rompemos encapsulamiento vamos a tener problemas a la hora de realizar un cambio en el archivo, ya que al quebrar encapsulamiento un pequeño cambio realizado en algún lugar puede afectar en muchos lugares y dañar el funcionamiento del programa. Además, romper con el encapsulamiento significa que nuestro modelo de la realidad tiene problemas de diseño.