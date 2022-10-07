!classDefinition: #StackTest category: 'StackPrimeraParte'!
TestCase subclass: #StackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!StackTest methodsFor: 'as yet unclassified' stamp: 'IL 10/1/2022 19:24:17'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := Stack new.
	
	self assert: stack isEmpty! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'i 10/7/2022 18:42:23'!
test02StackCanPushAnElement

	| stack anElement |
	
	stack := Stack new.
	anElement := 2.
	stack push: anElement.
	
	self deny: stack isEmpty.! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'i 10/7/2022 19:02:56'!
test03StackCanPopAnElement

	| stack anElement |
	
	stack := Stack new.
	anElement := 2.
	stack push: anElement.
	stack pop.
	
	self assert: stack isEmpty.! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'i 10/7/2022 19:06:12'!
test04StackPopAnElementAndReturnsIt

	| stack anElement lastElement |
	
	stack := Stack new.
	anElement := 2.
	stack push: anElement.
	lastElement := stack pop.
	
	self assert: lastElement = anElement.! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'i 10/7/2022 19:14:38'!
test05StackIsLIFO

	| stack firstElement secondElement firstPop secondPop |
	
	stack := Stack new.
	firstElement := 'boca'.
	secondElement := 'river'.
	stack push: firstElement.
	stack push: secondElement.
	firstPop := stack pop.
	secondPop := stack pop.
	
	self assert: firstPop = secondElement.
	self assert: secondPop = firstElement.
	! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'i 10/7/2022 19:14:33'!
test06StackCanTopAnElement

	| stack firstElement secondElement topElement |
	
	stack := Stack new.
	firstElement := 'boca'.
	secondElement := 'river'.
	stack push: firstElement.
	stack push: secondElement.
	topElement := stack top.
	
	self assert: topElement = secondElement.
	! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'i 10/7/2022 19:29:10'!
test07EmptyStackCantTopAnElement

	| stack |
	stack := Stack new.
	self
	should: [ stack top]
	raise: Error
	withExceptionDo: [ :anError | self assert: 'Cant do a top or pop because the stack is empty' equals: anError messageText ].
	! !

!StackTest methodsFor: 'as yet unclassified' stamp: 'i 10/7/2022 19:29:16'!
test08EmptyStackCantPopAnElement

	| stack |
	stack := Stack new.
	self
	should: [ stack pop]
	raise: Error
	withExceptionDo: [ :anError | self assert: 'Cant do a top or pop because the stack is empty' equals: anError messageText ].
	! !


!classDefinition: #Stack category: 'StackPrimeraParte'!
Object subclass: #Stack
	instanceVariableNames: 'array'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!Stack methodsFor: 'as yet unclassified' stamp: 'i 10/7/2022 18:50:23'!
initialize
	array := OrderedCollection new.! !

!Stack methodsFor: 'as yet unclassified' stamp: 'i 10/7/2022 18:34:01'!
isEmpty
	^array isEmpty.! !

!Stack methodsFor: 'as yet unclassified' stamp: 'i 10/7/2022 18:58:41'!
pop
	| lastElement |
	
	lastElement := self top.
	array removeLast.
	^lastElement.! !

!Stack methodsFor: 'as yet unclassified' stamp: 'i 10/7/2022 18:50:55'!
push: anElement
	array add: anElement.! !

!Stack methodsFor: 'as yet unclassified' stamp: 'i 10/7/2022 19:28:56'!
top
	self isEmpty ifTrue: [self error: 'Cant do a top or pop because the stack is empty'].
	^array at: array size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Stack class' category: 'StackPrimeraParte'!
Stack class
	instanceVariableNames: ''!

!Stack class methodsFor: 'as yet unclassified' stamp: 'i 10/7/2022 18:31:29'!
initialize
	^Stack new initialize.! !

Stack initialize!