!classDefinition: #NumeroTest category: 'Numeros-Parte2-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:50'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:58'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:39:57'!
test05EnteroAddsWithEnteroCorrectly

	self assert: two equals: one + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:10'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: four equals: two * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:22'!
test07EnteroDividesEnteroCorrectly

	self assert: one equals: two / two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:57'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: sevenTenths equals: oneFifth + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:20'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: twoTwentyfifth equals: oneFifth * twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:34'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: fiveHalfs equals: oneHalf / oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:58'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: (Entero with: 6) / (Entero with: 5) equals: one + oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:42:29'!
test12FraccionAddsEnteroCorrectly

	self assert: (Entero with: 6) / (Entero with: 5) equals: oneFifth + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:16'!
test13EnteroMultipliesFraccionCorrectly

	self assert: twoFifth equals: two * oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:27'!
test14FraccionMultipliesEnteroCorrectly

	self assert: twoFifth equals: oneFifth * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:40'!
test15EnteroDividesFraccionCorrectly

	self assert: fiveHalfs equals: one / twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:58'!
test16FraccionDividesEnteroCorrectly

	self assert: twoTwentyfifth equals: twoFifth / five! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:44:53'!
test19AddingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:13'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: one equals: (two/five) * (five/two)! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:27'!
test21DividingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf / oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:40'!
test22DividingEnterosCanReturnAFraccion

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:17'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:32'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:21'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two equals: three - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:36'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: oneFifth equals: twoFifth - oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:50'!
test29EnteroSubstractsFraccionCorrectly

	self assert: oneHalf equals: one - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:11'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: oneFifth equals: sixFifth - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:25'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: one equals: threeHalfs - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:44'!
test32SubstractingSameEnterosReturnsZero

	self assert: zero equals: one - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:59'!
test33SubstractingSameFraccionesReturnsZero

	self assert: zero equals: oneHalf - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:16'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: negativeThreeHalfs equals: one - fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:45'!
test35FibonacciZeroIsOne

	self assert: one equals: zero fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:58'!
test36FibonacciOneIsOne

	self assert: one equals: one fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:24'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: five equals: four fibonacci.
	self assert: three equals: three fibonacci. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:40'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: Entero negativeFibonacciErrorDescription equals: anError messageText ]! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:17'!
test39NegationOfEnteroIsCorrect

	self assert: negativeTwo equals: two negated
		! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:53:27'!
test40NegationOfFraccionIsCorrect

	self assert: negativeOne / two equals: oneHalf negated ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numeros-Parte2-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'private' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !


!Numero methodsFor: 'aritmetic operations - dd' stamp: 'JR 10/1/2022 19:20:36'!
addWithEntero: anAdder
	
	self subclassResponsibility.! !

!Numero methodsFor: 'aritmetic operations - dd' stamp: 'JR 10/1/2022 17:09:58'!
addWithFraccion: anAdder
	
	self subclassResponsibility.! !

!Numero methodsFor: 'aritmetic operations - dd' stamp: 'JR 10/1/2022 16:32:11'!
divideFromEntero: aDivisor
	
	self subclassResponsibility.! !

!Numero methodsFor: 'aritmetic operations - dd' stamp: 'JR 10/1/2022 16:32:17'!
divideFromFraccion: aDivisor
	
	self subclassResponsibility.! !

!Numero methodsFor: 'aritmetic operations - dd' stamp: 'JR 10/1/2022 16:32:57'!
multiplyWithEntero: aMultiplier

	self subclassResponsibility.! !

!Numero methodsFor: 'aritmetic operations - dd' stamp: 'JR 10/1/2022 16:33:05'!
multiplyWithFraccion: aMultiplier

	self subclassResponsibility.! !

!Numero methodsFor: 'aritmetic operations - dd' stamp: 'JR 10/1/2022 16:34:09'!
subtractFromEntero: aSubtrahend

	self subclassResponsibility.! !

!Numero methodsFor: 'aritmetic operations - dd' stamp: 'JR 10/1/2022 16:34:18'!
subtractFromFraccion: aSubtrahend

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte2-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:47:38'!
canNotDivideByZeroErrorDescription

	^'No se puede Dividir por Cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:46:56'!
invalidNumberTypeErrorDescription
	^ 'Tipo de Número Inválido'! !


!classDefinition: #Entero category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Entero methodsFor: 'arithmetic operations' stamp: 'JR 10/1/2022 15:45:26'!
* aMultiplier 
	
	^ aMultiplier multiplyWithEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JR 10/1/2022 19:20:36'!
+ anAdder

	^anAdder addWithEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JR 10/1/2022 15:59:38'!
- aSubtrahend 

	^ aSubtrahend subtractFromEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JR 10/1/2022 16:14:19'!
/ aDivisor 
	^aDivisor divideFromEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JR 10/1/2022 17:55:53'!
fibonacci

	self subclassResponsibility 
		! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'JS 5/5/2022 03:55:37'!
initializeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'arithmetic operations - dd' stamp: 'JR 10/1/2022 19:20:47'!
addWithEntero: anAdder

	^self class with: self integerValue + anAdder integerValue.! !

!Entero methodsFor: 'arithmetic operations - dd' stamp: 'JR 10/1/2022 19:20:52'!
addWithFraccion: anAdder

	^ anAdder addWithEntero: self.! !

!Entero methodsFor: 'arithmetic operations - dd' stamp: 'JR 10/1/2022 16:15:25'!
divideFromEntero: aDivisor

	^Fraccion with: aDivisor over: self.! !

!Entero methodsFor: 'arithmetic operations - dd' stamp: 'JR 10/1/2022 16:19:50'!
divideFromFraccion: aDivisor

	^ Fraccion with: aDivisor numerator over: aDivisor denominator * self.! !

!Entero methodsFor: 'arithmetic operations - dd' stamp: 'JR 10/1/2022 15:45:26'!
multiplyWithEntero: aMultiplier

	^self class with: value * aMultiplier integerValue.! !

!Entero methodsFor: 'arithmetic operations - dd' stamp: 'JR 10/1/2022 19:05:02'!
multiplyWithFraccion: aMultiplier

	^ aMultiplier multiplyWithEntero: self.! !

!Entero methodsFor: 'arithmetic operations - dd' stamp: 'JR 10/1/2022 15:52:58'!
subtractFromEntero: aSubtrahend

	^self class with: aSubtrahend integerValue - value.! !

!Entero methodsFor: 'arithmetic operations - dd' stamp: 'JR 10/1/2022 16:10:48'!
subtractFromFraccion: aSubtrahend

	^Fraccion with: aSubtrahend numerator - (self * aSubtrahend denominator) over: aSubtrahend denominator.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numeros-Parte2-Ejercicio'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'error descriptions' stamp: 'NR 4/8/2019 02:57:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !


!Entero class methodsFor: 'private' stamp: 'JR 10/2/2022 13:49:49'!
canInstantiateWith: aValue
	
	self subclassResponsibility.! !


!Entero class methodsFor: 'instance creation' stamp: 'JR 10/1/2022 19:13:49'!
with: aValue 
	| subclassSelected |
	
	subclassSelected := Entero subclasses detect: [ :enteroSubclass | enteroSubclass canInstantiateWith: aValue ] ifNone: [ self invalidNumberTypeErrorDescription ].
	
	^ subclassSelected new initializeWith: aValue.
		! !


!classDefinition: #Cero category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Cero methodsFor: 'arithmetic operations' stamp: 'JR 10/1/2022 17:38:05'!
fibonacci
	^Entero with: 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: 'Numeros-Parte2-Ejercicio'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'private' stamp: 'JR 10/1/2022 18:44:15'!
canInstantiateWith: aValue
	
		^ aValue = 0.! !


!classDefinition: #MayorAUno category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #MayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!MayorAUno methodsFor: 'arithmetic operations' stamp: 'JR 10/1/2022 17:53:36'!
fibonacci
	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
		
	^(self - one) fibonacci + (self - two) fibonacci.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MayorAUno class' category: 'Numeros-Parte2-Ejercicio'!
MayorAUno class
	instanceVariableNames: ''!

!MayorAUno class methodsFor: 'private' stamp: 'JR 10/1/2022 18:51:28'!
canInstantiateWith: aValue
	
		^ aValue > 1.! !


!classDefinition: #Negativo category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #Negativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Negativo methodsFor: 'arithmetic operations' stamp: 'JR 10/1/2022 17:38:59'!
fibonacci
	self error: Entero negativeFibonacciErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Negativo class' category: 'Numeros-Parte2-Ejercicio'!
Negativo class
	instanceVariableNames: ''!

!Negativo class methodsFor: 'private' stamp: 'JR 10/1/2022 18:51:42'!
canInstantiateWith: aValue
	
		^ aValue < 0.! !


!classDefinition: #Uno category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Uno methodsFor: 'arithmetic operations' stamp: 'JR 10/1/2022 17:38:31'!
fibonacci
	^Entero with: 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: 'Numeros-Parte2-Ejercicio'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'private' stamp: 'JR 10/1/2022 18:51:52'!
canInstantiateWith: aValue
	
		^ aValue = 1.! !


!classDefinition: #Fraccion category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JR 10/1/2022 15:39:38'!
* aMultiplier 

	^ aMultiplier multiplyWithFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JR 10/1/2022 15:25:27'!
+ anAdder 
	
	^ anAdder addWithFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JR 10/1/2022 16:00:56'!
- aSubtrahend

	^ aSubtrahend subtractFromFraccion: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JR 10/1/2022 16:21:17'!
/ aDivisor 
	
	^ aDivisor divideFromFraccion: self.! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'JR 10/2/2022 17:12:30'!
initializeWith: aNumerator over: aDenominator

	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


!Fraccion methodsFor: 'aritmetic operations - dd' stamp: 'JR 10/1/2022 19:20:36'!
addWithEntero: anAdder
	^ self class with: denominator * anAdder + numerator over: denominator.! !

!Fraccion methodsFor: 'aritmetic operations - dd' stamp: 'I 9/30/2022 19:23:59'!
addWithFraccion: anAdder
		| newDenominator newNumerator |
		newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
		newDenominator := denominator * anAdder denominator.
		^ self class with: newNumerator over: newDenominator.! !

!Fraccion methodsFor: 'aritmetic operations - dd' stamp: 'JR 10/1/2022 16:24:28'!
divideFromEntero: aDivisor

	^ self class with: aDivisor * denominator over: numerator.! !

!Fraccion methodsFor: 'aritmetic operations - dd' stamp: 'JR 10/1/2022 16:23:36'!
divideFromFraccion: aDivisor

	^ self class with: (aDivisor numerator * denominator) over: (aDivisor denominator * numerator).! !

!Fraccion methodsFor: 'aritmetic operations - dd' stamp: 'JR 10/1/2022 15:43:14'!
multiplyWithEntero: aMultiplier
		
	^ self class with: numerator * aMultiplier over: denominator.! !

!Fraccion methodsFor: 'aritmetic operations - dd' stamp: 'JR 10/1/2022 15:44:43'!
multiplyWithFraccion: aMultiplier

	^ self class with: numerator * aMultiplier numerator over: denominator * aMultiplier denominator.! !

!Fraccion methodsFor: 'aritmetic operations - dd' stamp: 'JR 10/1/2022 19:23:20'!
subtractFromEntero: aSubtrahend

	^ self class with: denominator * aSubtrahend - numerator over: denominator.! !

!Fraccion methodsFor: 'aritmetic operations - dd' stamp: 'JR 10/1/2022 16:07:07'!
subtractFromFraccion: aSubtrahend

	| newNumerator newDenominator |
	newNumerator :=  (denominator * aSubtrahend numerator) - (numerator * aSubtrahend denominator).
	newDenominator := denominator * aSubtrahend denominator.

	^ self class with: newNumerator over: newDenominator.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numeros-Parte2-Ejercicio'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'instance creation' stamp: 'JR 10/2/2022 16:47:06'!
with: aDividend over: aDivisor

	| greatestCommonDivisor subclassSelected numerator denominator|

	numerator := aDividend.
	denominator := aDivisor.

	subclassSelected := Excepcion subclasses detect: [ :exepcionSubclass | exepcionSubclass canInstantiateWith: numerator Over: denominator ] ifNone: [
		
		greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
		numerator := aDividend // greatestCommonDivisor.
		denominator := aDivisor // greatestCommonDivisor.
		
		subclassSelected := FraccionUsaMaximoComunDivisor subclasses detect: [ :comunSubclass | comunSubclass canInstantiateWith: numerator Over: denominator ] ifNone: [ self invalidNumberTypeErrorDescription ].
		].
	
	^ subclassSelected instantiateWith: numerator Over: denominator.! !


!Fraccion class methodsFor: 'private' stamp: 'JR 10/2/2022 16:54:37'!
canInstantiateWith: aNumerator Over: aDenominator
	
	self subclassResponsibility.! !

!Fraccion class methodsFor: 'private' stamp: 'JR 10/2/2022 16:57:37'!
instantiateWith: aNumerator Over: aDenominator
	
	self subclassResponsibility.! !


!classDefinition: #Excepcion category: 'Numeros-Parte2-Ejercicio'!
Fraccion subclass: #Excepcion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Excepcion class' category: 'Numeros-Parte2-Ejercicio'!
Excepcion class
	instanceVariableNames: ''!

!Excepcion class methodsFor: 'private' stamp: 'JR 10/2/2022 16:54:48'!
canInstantiateWith: aNumerator Over: aDenominator
	
	self subclassResponsibility.! !

!Excepcion class methodsFor: 'private' stamp: 'JR 10/2/2022 17:01:43'!
instantiateWith: aNumerator Over: aDenominator
	
	self subclassResponsibility.! !


!classDefinition: #DenominadorCero category: 'Numeros-Parte2-Ejercicio'!
Excepcion subclass: #DenominadorCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DenominadorCero class' category: 'Numeros-Parte2-Ejercicio'!
DenominadorCero class
	instanceVariableNames: ''!

!DenominadorCero class methodsFor: 'private' stamp: 'JR 10/2/2022 16:55:25'!
canInstantiateWith: aNumerator Over: aDenominator
	
	^ aDenominator isZero.! !

!DenominadorCero class methodsFor: 'private' stamp: 'JR 10/2/2022 16:58:03'!
instantiateWith: aNumerator Over: aDenominator

	^ self error: self canNotDivideByZeroErrorDescription! !


!classDefinition: #DenominadorNegativo category: 'Numeros-Parte2-Ejercicio'!
Excepcion subclass: #DenominadorNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DenominadorNegativo class' category: 'Numeros-Parte2-Ejercicio'!
DenominadorNegativo class
	instanceVariableNames: ''!

!DenominadorNegativo class methodsFor: 'private' stamp: 'JR 10/2/2022 17:06:03'!
canInstantiateWith: aNumerator Over: aDenominator

	^ aDenominator isNegative.! !

!DenominadorNegativo class methodsFor: 'private' stamp: 'JR 10/2/2022 17:05:26'!
instantiateWith: aNumerator Over: aDenominator

	^ aNumerator negated / aDenominator negated.! !


!classDefinition: #NumeradorCero category: 'Numeros-Parte2-Ejercicio'!
Excepcion subclass: #NumeradorCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NumeradorCero class' category: 'Numeros-Parte2-Ejercicio'!
NumeradorCero class
	instanceVariableNames: ''!

!NumeradorCero class methodsFor: 'private' stamp: 'JR 10/2/2022 17:02:57'!
canInstantiateWith: aNumerator Over: aDenominator

	^ aNumerator isZero.! !

!NumeradorCero class methodsFor: 'private' stamp: 'JR 10/2/2022 16:57:56'!
instantiateWith: aNumerator Over: aDenominator

	^ aNumerator.! !


!classDefinition: #FraccionUsaMaximoComunDivisor category: 'Numeros-Parte2-Ejercicio'!
Fraccion subclass: #FraccionUsaMaximoComunDivisor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionUsaMaximoComunDivisor class' category: 'Numeros-Parte2-Ejercicio'!
FraccionUsaMaximoComunDivisor class
	instanceVariableNames: ''!

!FraccionUsaMaximoComunDivisor class methodsFor: 'private' stamp: 'JR 10/2/2022 16:56:35'!
canInstantiateWith: aNumerator Over: aDenominator
	
	self subclassResponsibility.! !

!FraccionUsaMaximoComunDivisor class methodsFor: 'private' stamp: 'JR 10/2/2022 16:58:49'!
instantiateWith: aNumerator Over: aDenominator
	
	self subclassResponsibility.! !


!classDefinition: #DenominadorDistintoAUno category: 'Numeros-Parte2-Ejercicio'!
FraccionUsaMaximoComunDivisor subclass: #DenominadorDistintoAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DenominadorDistintoAUno class' category: 'Numeros-Parte2-Ejercicio'!
DenominadorDistintoAUno class
	instanceVariableNames: ''!

!DenominadorDistintoAUno class methodsFor: 'private' stamp: 'JR 10/2/2022 17:00:16'!
canInstantiateWith: aNumerator Over: aDenominator

	^ aDenominator isOne not.! !

!DenominadorDistintoAUno class methodsFor: 'private' stamp: 'JR 10/2/2022 16:48:15'!
instantiateWith: aNumerator Over: aDenominator

	^ DenominadorDistintoAUno new initializeWith: aNumerator over: aDenominator.! !


!classDefinition: #DenominadorUno category: 'Numeros-Parte2-Ejercicio'!
FraccionUsaMaximoComunDivisor subclass: #DenominadorUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DenominadorUno class' category: 'Numeros-Parte2-Ejercicio'!
DenominadorUno class
	instanceVariableNames: ''!

!DenominadorUno class methodsFor: 'private' stamp: 'JR 10/2/2022 16:33:45'!
canInstantiateWith: aDividend Over: aDivisor

	^ aDivisor isOne.! !

!DenominadorUno class methodsFor: 'private' stamp: 'JR 10/2/2022 16:04:56'!
instantiateWith: aNumerator Over: aDenominator

	^ aNumerator.! !
