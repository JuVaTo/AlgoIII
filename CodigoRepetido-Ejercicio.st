!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'JR 9/25/2022 14:08:30'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
			
	self should: [	 customerBook addCustomerNamed: 'John Lennon' ] notTakeMoreThan: 50 milliSeconds.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JR 9/25/2022 14:09:40'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: 'Paul McCartney'.
	
	self should: [ customerBook removeCustomerNamed: 'Paul McCartney' ] notTakeMoreThan: 100 milliSeconds.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JR 9/25/2022 18:08:15'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self should: [ customerBook addCustomerNamed: ''. self fail ] raise: Error withExceptionDo: [ :anError | 
		self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
		self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JR 9/25/2022 18:02:38'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.

	self should: [ customerBook removeCustomerNamed: 'Paul McCartney'. self fail ] raise: NotFound withExceptionDo: [ :anError | 
		self assert: (self numberOfCostumersEqualTo1AndJohnLennonInACustomerBook: customerBook) ].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JR 9/25/2022 14:25:32'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: (self expectedNumberOfActive: 0 Suspend: 1 Total: 1 CostumersInACustumerBook: customerBook).	
	self assert: (self paulMcCartneyInACustomerBook: customerBook).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JR 9/25/2022 14:25:32'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: (self expectedNumberOfActive: 0 Suspend: 0 Total: 0 CostumersInACustumerBook: customerBook).
	self deny: (self paulMcCartneyInACustomerBook: customerBook).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JR 9/25/2022 18:05:37'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
		
	self should: [ customerBook suspendCustomerNamed: 'RingoStarr'. self fail ] raise: CantSuspend withExceptionDo: [ :anError | 
		self assert: (self numberOfCostumersEqualTo1AndJohnLennonInACustomerBook: customerBook) ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'JR 9/25/2022 18:12:37'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self should: [ customerBook suspendCustomerNamed: johnLennon. self fail ] raise: CantSuspend withExceptionDo: [ :anError | 
		self assert: (self numberOfCostumersEqualTo1AndJohnLennonInACustomerBook: customerBook) ].! !


!CustomerBookTest methodsFor: 'messagesForTests' stamp: 'JR 9/25/2022 18:10:13'!
expectedNumberOfActive: aNumberOfActiveCustomers Suspend: aNumberOfSuspendCustomers Total: aNumberOfCustomers CostumersInACustumerBook: customerBook
	
	^ (aNumberOfActiveCustomers = customerBook numberOfActiveCustomers) and: [ aNumberOfSuspendCustomers = customerBook numberOfSuspendedCustomers ] and: 
	[ aNumberOfCustomers = customerBook numberOfCustomers ].! !

!CustomerBookTest methodsFor: 'messagesForTests' stamp: 'JR 9/25/2022 17:06:37'!
numberOfCostumersEqualTo1AndJohnLennonInACustomerBook: aCustomerBook
	
	^ (aCustomerBook numberOfCustomers = 1) and: [ aCustomerBook includesCustomerNamed: 'John Lennon' ].! !

!CustomerBookTest methodsFor: 'messagesForTests' stamp: 'JR 9/25/2022 13:30:46'!
paulMcCartneyInACustomerBook: aCustomerBook

	^ aCustomerBook includesCustomerNamed: 'Paul McCartney'.! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'JR 9/24/2022 16:51:33'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed:aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'JR 9/25/2022 17:10:56'!
numberOfCustomers
	
	^ self numberOfActiveCustomers + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'JR 9/24/2022 17:11:29'!
removeCustomerNamed: aName 
 
	active remove: aName ifAbsent: [suspended remove: aName ifAbsent: [^ NotFound signal]].! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
