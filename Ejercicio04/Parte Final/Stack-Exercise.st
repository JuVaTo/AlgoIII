!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'testOOStackLimited' stamp: 'JR 10/14/2022 15:22:05'!
test01PushAddElementsToTheStackLimited

	| stack pushedObject |
	stack := OOStackLimited initializateWithLimit: 1.
	pushedObject := 'something'.
	
	stack push: pushedObject.
		
	self assert: stack value = pushedObject.
	! !

!OOStackTest methodsFor: 'testOOStackLimited' stamp: 'JR 10/14/2022 15:28:25'!
test02CanNotPushWhenTheStackIsFull

	| stack |
	stack := OOStackLimited initializateWithLimit: 1.
	
	stack push: 'something'.
	
	self should: [ stack push: 'Siuuu' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | self assert: 'The stack is full' equals: anError messageText ].
		
	
		
	! !

!OOStackTest methodsFor: 'testOOStackLimited' stamp: 'JR 10/14/2022 15:33:31'!
test03PopCorrectlyAfterCanNotPush

	| stack |
	stack := OOStackLimited initializateWithLimit: 2.
	
	stack push: 'Termo'.
	stack push: 'Mate'.
	
	self should: [ stack push: 'Yerba' ] raise: Error - MessageNotUnderstood withExceptionDo: [ :anError |
			
			self assert: stack pop = 'Mate'.

			 ].
		
	
		
	! !

!OOStackTest methodsFor: 'testOOStackLimited' stamp: 'JR 10/14/2022 15:40:00'!
test04TopCorrectlyAfterCanNotPush

	| stack |
	stack := OOStackLimited initializateWithLimit: 2.
	
	stack push: 'Xbox'.
	stack push: 'Play'.
	
	self should: [ stack push: 'PC' ] raise: Error - MessageNotUnderstood withExceptionDo: [ :anError |
			
			self assert: stack top = 'Play'.

			 ].
		
	
		
	! !


!OOStackTest methodsFor: 'testOOStack' stamp: 'JMB 10/8/2022 18:00:02'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'testOOStack' stamp: 'JMB 10/8/2022 17:59:57'!
test02PushAddElementsToTheStack

	| stack |
	stack := OOStack new.
	
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'testOOStack' stamp: 'JMB 10/8/2022 17:59:50'!
test03PopRemovesElementsFromTheStack

	| stack |
	stack := OOStack new.
	stack push: 'something'.
	
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'testOOStack' stamp: 'JMB 10/8/2022 17:59:43'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack pop! !

!OOStackTest methodsFor: 'testOOStack' stamp: 'JMB 10/8/2022 17:56:59'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: secondPushedObject equals: stack pop.
	self assert: firstPushedObject equals: stack pop.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'testOOStack' stamp: 'JR 10/12/2022 19:23:01'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack value.
	! !

!OOStackTest methodsFor: 'testOOStack' stamp: 'JR 10/12/2022 19:23:00'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: 1 equals: stack size.
	stack value.
	self assert: 1 equals: stack size.
	! !

!OOStackTest methodsFor: 'testOOStack' stamp: 'JR 10/14/2022 14:43:27'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack baseValueErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'testOOStack' stamp: 'JR 10/14/2022 14:43:27'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack baseValueErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'testOOStack' stamp: 'JR 10/14/2022 14:43:27'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack value ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack baseValueErrorDescription equals: anError messageText ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'JR 10/14/2022 15:44:06'!
test01NilWordCanNotBeSearched

	| finder stack |
	
	stack := OOStack new.
	
	finder := SentenceFinderByPrefix initializateWith: stack.
	
	self should: [ finder find: '' ] raise: Error
		withExceptionDo: [ :anError | self assert: Prefix invalidPrefixError equals: anError messageText ].
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'JR 10/14/2022 15:44:12'!
test02PrefixWithSpaceCanNotBeSearched

	| finder stack |
	
	stack := OOStack new.
	
	stack push: 'Ho la'.
	
	finder := SentenceFinderByPrefix initializateWith: stack.
	
	self should: [ finder find: 'Ho la' ] raise: Error
		withExceptionDo: [ :anError | self assert: Prefix invalidPrefixError equals: anError messageText ].
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'JR 10/14/2022 15:44:17'!
test03EmptyStackHasNotMatches

	| finder stack |
	
	stack := OOStack new.
	
	finder := SentenceFinderByPrefix initializateWith: stack.
	
	self assert: ((finder find: 'Dibu') isEmpty).
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'JR 10/14/2022 15:44:22'!
test04FinderCanFindAPrefix

	| finder stack collection |
	
	stack := OOStack new.
	
	finder := SentenceFinderByPrefix initializateWith: stack.
	stack push: 'Messi <3'.
	stack push: 'Seresiete'.
	
	collection := SortedCollection with: 'Messi <3'.

	self assert: ( (finder find: 'Messi') hasEqualElements: collection ).
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'JR 10/14/2022 15:44:28'!
test05OnlyFinderByPrefix

	| finder stack collection |
	
	stack := OOStack new.
	
	stack push: 'Boca Juniors'.
	stack push: 'Aguante Boca'.
	stack push: 'Hola Boca'.
	stack push: 'boca pasion'.
	stack push: 'Bocaaaaa'.
	
	collection := SortedCollection with: 'Bocaaaaa' with: 'Boca Juniors'.

	finder := SentenceFinderByPrefix initializateWith: stack.

	self assert: ( (finder find: 'Boca') hasEqualElements: collection ).
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'JR 10/14/2022 15:44:37'!
test06PrefixNotFound

	| finder stack |
	
	stack := OOStack new.
	
	stack push: 'Chaco for ever'.
	stack push: 'Boca Unidos'.
	stack push: 'Ferro'.
	stack push: 'Temperley'.
	stack push: 'Juventud Unida'.
	
	finder := SentenceFinderByPrefix initializateWith: stack.	
	
	self assert: ( (finder find: 'Ra') isEmpty ).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'JR 10/14/2022 15:44:43'!
test07FinderIsCaseSensitive

	| finder stack |
	
	stack := OOStack new.
	
	stack push: 'Munieco'.
	
	finder := SentenceFinderByPrefix initializateWith: stack.
	
	self assert: ((finder find: 'MunieCo') isEmpty).
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'JR 10/14/2022 15:44:50'!
test08SentenceFinderNoChangeStackOrder

	| finder stack equalElements stackAuxiliar |
	
	equalElements := true.
		
	stack := OOStack new.
	
	stack push: 'el gato de cuatro patas'.
	stack push: 'el perro grande'.
	stack push: 'el mas grande'.
	stack push: 'El juego de la oca'.
	stack push: 'LanGODni'.
	
	stackAuxiliar := stack copy.
		
	finder := SentenceFinderByPrefix initializateWith: stack.
	finder find: 'el'.
	
	[ stack isEmpty ] whileTrue: [
		
		( stack pop value ) = ( stackAuxiliar pop value ) 	ifFalse: [ equalElements := false ] ].
	
	self assert: equalElements.
	
	
	
	
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'JR 10/14/2022 15:44:56'!
test09AllStackElementsMatchPrefix

	| finder stack collection |
	
	stack := OOStack new.
	
	stack push: 'La cucaracha'.
	stack push: 'La Pampa'.
	stack push: 'Lali'.
	stack push: 'La libertadores'.
	stack push: 'Lala'.
	
	finder := SentenceFinderByPrefix initializateWith: stack.	
	
	collection := SortedCollection with: 'La cucaracha' with: 'La Pampa' with: 'Lali' with: 'La libertadores' with: 'Lala'.
	
	self assert: ( (finder find: 'La') hasEqualElements: collection ).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'JR 10/14/2022 15:45:00'!
test10FinderCanFindMoreThanOneTimeCorrectly

	| finder stack collection01 collection02 |
	
	stack := OOStack new.
	
	stack push: 'La cucaracha'.
	stack push: 'La Pampa'.
	stack push: 'Lali'.
	stack push: 'Carpeta roja'.
	stack push: 'La libertadores'.
	stack push: 'Lala'.
	
	finder := SentenceFinderByPrefix initializateWith: stack.	
	
	collection01 := SortedCollection with: 'La cucaracha' with: 'La Pampa' with: 'Lali' with: 'La libertadores' with: 'Lala'.
	
	collection02 := SortedCollection with: 'Lali' with: 'Lala'.
		
	self assert: ((finder find: 'La') hasEqualElements: collection01).
	self assert: ((finder find: 'Lal') hasEqualElements: collection02).! !


!classDefinition: #ComponentsOfStack category: 'Stack-Exercise'!
Object subclass: #ComponentsOfStack
	instanceVariableNames: 'next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ComponentsOfStack methodsFor: 'operations' stamp: 'JR 10/12/2022 18:56:05'!
setNext: anElement
	next := anElement ! !

!ComponentsOfStack methodsFor: 'operations' stamp: 'JR 10/12/2022 19:23:00'!
value
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ComponentsOfStack class' category: 'Stack-Exercise'!
ComponentsOfStack class
	instanceVariableNames: ''!

!ComponentsOfStack class methodsFor: 'error' stamp: 'JR 10/14/2022 14:43:27'!
baseValueErrorDescription
	
	^ 'Stack is empty'! !



!classDefinition: #BaseOfStack category: 'Stack-Exercise'!
ComponentsOfStack subclass: #BaseOfStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BaseOfStack methodsFor: 'operations' stamp: 'JR 10/14/2022 14:43:27'!
next
	^ self class baseValueErrorDescription.! !

!BaseOfStack methodsFor: 'operations' stamp: 'JR 10/14/2022 14:43:27'!
value
	^ self error: self class baseValueErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BaseOfStack class' category: 'Stack-Exercise'!
BaseOfStack class
	instanceVariableNames: ''!

!BaseOfStack class methodsFor: 'instance creation' stamp: 'JR 10/14/2022 15:01:31'!
canInstantiateWithSize: aSize andLimit: aLimit.

	^ false.! !


!classDefinition: #ElementOfStack category: 'Stack-Exercise'!
ComponentsOfStack subclass: #ElementOfStack
	instanceVariableNames: 'element'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementOfStack methodsFor: 'operations' stamp: 'JR 10/12/2022 19:14:13'!
next

	^ next.! !

!ElementOfStack methodsFor: 'operations' stamp: 'JR 10/12/2022 19:21:28'!
value

	^ element.! !


!ElementOfStack methodsFor: 'instance creation' stamp: 'JR 10/14/2022 15:22:03'!
initializateWithLimit: anElement

	element := anElement.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElementOfStack class' category: 'Stack-Exercise'!
ElementOfStack class
	instanceVariableNames: ''!

!ElementOfStack class methodsFor: 'instance creation' stamp: 'JR 10/14/2022 15:12:22'!
canInstantiateWithSize: aSize andLimit: aLimit.

	^ aSize < aLimit.! !

!ElementOfStack class methodsFor: 'instance creation' stamp: 'JR 10/14/2022 15:22:05'!
initializateWithLimit: anElement
	^ self new initializateWithLimit: anElement.
	! !


!classDefinition: #LimitExceededOfStack category: 'Stack-Exercise'!
ComponentsOfStack subclass: #LimitExceededOfStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LimitExceededOfStack class' category: 'Stack-Exercise'!
LimitExceededOfStack class
	instanceVariableNames: ''!

!LimitExceededOfStack class methodsFor: 'instance creation' stamp: 'JR 10/14/2022 15:01:16'!
canInstantiateWithSize: aSize andLimit: aLimit.

	^ aLimit = aSize.! !

!LimitExceededOfStack class methodsFor: 'instance creation' stamp: 'JR 10/14/2022 15:22:04'!
initializateWithLimit: anElement
	^ self error: 'The stack is full'.
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topOfStack size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'instance creation' stamp: 'JR 10/12/2022 19:28:25'!
initialize
	topOfStack := BaseOfStack new.
	size := 0.! !


!OOStack methodsFor: 'operations' stamp: 'JR 10/12/2022 19:35:15'!
pop

	| topEliminated |
	
	topEliminated := self top.
	
	topOfStack := topOfStack next.
	
	self addSize: -1.
	
	^ topEliminated.! !

!OOStack methodsFor: 'operations' stamp: 'JR 10/14/2022 15:22:05'!
push: anElement
	
	| newElement |
	
	newElement := ElementOfStack initializateWithLimit: anElement.
	
	newElement setNext: topOfStack.
	
	topOfStack := newElement.
	
	self addSize: 1.	
	! !

!OOStack methodsFor: 'operations' stamp: 'JR 10/12/2022 19:23:55'!
top

	^ topOfStack value.! !


!OOStack methodsFor: 'testing' stamp: 'JR 10/12/2022 19:37:19'!
isEmpty
	^ size = 0.! !

!OOStack methodsFor: 'testing' stamp: 'JR 10/14/2022 14:36:08'!
value

	^ topOfStack value.! !


!OOStack methodsFor: 'private' stamp: 'JR 10/12/2022 19:34:52'!
addSize: anAdder

	size := size + anAdder.! !

!OOStack methodsFor: 'private' stamp: 'JR 10/12/2022 19:00:07'!
size
	^ size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'JR 10/14/2022 14:43:27'!
baseValueErrorDescription
	
	^ 'Stack is empty'! !


!OOStack class methodsFor: 'instance creation' stamp: 'i 10/11/2022 19:57:05'!
initialize
	^self new initialize.! !


!classDefinition: #OOStackLimited category: 'Stack-Exercise'!
OOStack subclass: #OOStackLimited
	instanceVariableNames: 'limit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackLimited methodsFor: 'operations' stamp: 'JR 10/14/2022 15:22:05'!
push: anElement
	
	| newElement subclassSelected |
	
	subclassSelected := ComponentsOfStack subclasses detect: [ :componentsSubclass | componentsSubclass canInstantiateWithSize: size andLimit: limit ]. 
	
	newElement := subclassSelected initializateWithLimit: anElement.
		
	newElement setNext: topOfStack.
	
	topOfStack := newElement.
	
	self addSize: 1.	
	! !


!OOStackLimited methodsFor: 'instance creation' stamp: 'JR 10/14/2022 15:22:04'!
initializateWithLimit: aLimit

	topOfStack := BaseOfStack new.
	size := 0.
	limit := aLimit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackLimited class' category: 'Stack-Exercise'!
OOStackLimited class
	instanceVariableNames: ''!

!OOStackLimited class methodsFor: 'instance creation' stamp: 'JR 10/14/2022 15:22:05'!
initializateWithLimit: aLimit
	^ self new initializateWithLimit: aLimit.! !


!classDefinition: #Prefix category: 'Stack-Exercise'!
Object subclass: #Prefix
	instanceVariableNames: 'prefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Prefix methodsFor: 'operations' stamp: 'JR 10/13/2022 20:04:46'!
prefix

	self subclassResponsibility.! !

!Prefix methodsFor: 'operations' stamp: 'JR 10/13/2022 20:05:23'!
withAPrefix: aPrefix.

	prefix := aPrefix.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Prefix class' category: 'Stack-Exercise'!
Prefix class
	instanceVariableNames: ''!

!Prefix class methodsFor: 'instance creation' stamp: 'JR 10/13/2022 20:06:35'!
aPrefixIncludesSpaceOrEqualToNil: aPrefix

	| includesSpacebar |
	includesSpacebar := aPrefix includesSubString: ' '.
	
	^ includesSpacebar or: aPrefix = ''.
! !

!Prefix class methodsFor: 'instance creation' stamp: 'JR 10/13/2022 20:05:58'!
canInstantiateWith: aPrefix	

	self subclassResponsibility.! !


!Prefix class methodsFor: 'error' stamp: 'JR 10/13/2022 20:07:32'!
invalidPrefixError

	^ 'The prefix is invalid'.! !


!classDefinition: #InvalidPrefix category: 'Stack-Exercise'!
Prefix subclass: #InvalidPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!InvalidPrefix methodsFor: 'operations' stamp: 'JR 10/13/2022 20:11:32'!
prefix
	self error: Prefix invalidPrefixError.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvalidPrefix class' category: 'Stack-Exercise'!
InvalidPrefix class
	instanceVariableNames: ''!

!InvalidPrefix class methodsFor: 'instance creation' stamp: 'JR 10/13/2022 20:07:50'!
canInstantiateWith: aPrefix
	
	^ Prefix aPrefixIncludesSpaceOrEqualToNil: aPrefix.
! !


!classDefinition: #ValidPrefix category: 'Stack-Exercise'!
Prefix subclass: #ValidPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ValidPrefix methodsFor: 'operations' stamp: 'JR 10/13/2022 19:36:07'!
prefix
	^ prefix! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ValidPrefix class' category: 'Stack-Exercise'!
ValidPrefix class
	instanceVariableNames: ''!

!ValidPrefix class methodsFor: 'instance creation' stamp: 'JR 10/13/2022 20:08:02'!
canInstantiateWith: aPrefix	

	^ (Prefix aPrefixIncludesSpaceOrEqualToNil: aPrefix) not.
! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack auxiliarStack prefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'JR 10/13/2022 20:03:56'!
aValidPrefix: aPrefix
	
	| aNewPrefix prefixSubclassSelected |
	prefixSubclassSelected := Prefix subclasses detect: [ :prefixSubclass | prefixSubclass canInstantiateWith: aPrefix ]. 
	
	aNewPrefix := prefixSubclassSelected new withAPrefix: aPrefix.
		
	prefix := aNewPrefix prefix.! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'JR 10/14/2022 13:44:01'!
reorderStack

	[ auxiliarStack isEmpty ] whileFalse: [
		
		stack push: auxiliarStack pop ].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'JR 10/14/2022 14:30:05'!
searchElementsBeginWith

	| topOfStackElement aPrefixWasFound matchesCollection |
	
	matchesCollection := SortedCollection new.
			
	[ stack isEmpty ] whileFalse: [ 
		
		topOfStackElement := stack pop value.
		
		aPrefixWasFound := topOfStackElement beginsWith: prefix.
		
		aPrefixWasFound ifTrue: [ matchesCollection add: topOfStackElement ].
		
		auxiliarStack push: topOfStackElement ].
	
	^ matchesCollection.
	! !


!SentenceFinderByPrefix methodsFor: 'operation' stamp: 'JR 10/14/2022 14:31:03'!
find: aPrefix

	| matchesCollection |
	
	self aValidPrefix: aPrefix.

	matchesCollection := self searchElementsBeginWith.

	self reorderStack.
		
	^ matchesCollection.! !


!SentenceFinderByPrefix methodsFor: 'instance creation' stamp: 'JR 10/14/2022 15:59:17'!
initializateWith: aStack

	stack := aStack.
	
	auxiliarStack := OOStack new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'JR 10/14/2022 15:59:31'!
initializateWith: aStack

	^ self new initializateWith: aStack.! !

OOStack initialize!