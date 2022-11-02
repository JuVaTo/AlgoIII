!classDefinition: #TestMarsRovers category: 'EjercicioMarsRovers'!
TestCase subclass: #TestMarsRovers
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRovers'!

!TestMarsRovers methodsFor: 'assertions' stamp: 'JR 11/2/2022 16:14:27'!
assertAMarsRovers: aMarsRovers EndsAtAPoint: aFinalPoint

	self assert: aMarsRovers actualPoint = aFinalPoint.! !

!TestMarsRovers methodsFor: 'assertions' stamp: 'JR 11/2/2022 16:26:32'!
assertAMarsRovers: aMarsRovers EndsInADirection: aDirection

	self assert: aMarsRovers actualDirection = aDirection.! !


!TestMarsRovers methodsFor: 'setUp' stamp: 'JR 11/2/2022 17:20:01'!
marsRoversWithNorthDirectionStartAt: aPoint andDo: aCommandSequence
	| marsRovers |
	marsRovers := MarsRovers initializeWithNorthDirectionInAPoint: aPoint.
	
	marsRovers command: aCommandSequence.
	
	^marsRovers! !

!TestMarsRovers methodsFor: 'setUp' stamp: 'JR 11/2/2022 17:20:23'!
marsRoversWithSouthDirectionStartAt: aPoint andDo: aCommandSequence
	| marsRovers |
	marsRovers := MarsRovers initializeWithSouthDirectionInAPoint: aPoint.
	
	marsRovers command: aCommandSequence.
	
	^marsRovers! !


!TestMarsRovers methodsFor: 'tests' stamp: 'JR 11/2/2022 17:20:23'!
test01MarsRoversCanStartInAPointWithADirection

	| marsRovers |
	marsRovers := self marsRoversWithSouthDirectionStartAt: 0@0 andDo: ''.
		
	self assertAMarsRovers: marsRovers EndsAtAPoint: 0@0.
	self assertAMarsRovers: marsRovers EndsInADirection: #S.! !

!TestMarsRovers methodsFor: 'tests' stamp: 'JR 11/2/2022 17:20:02'!
test02MarsRoversCanRotateLeft

	| marsRovers |
	marsRovers := self marsRoversWithNorthDirectionStartAt: 2@4 andDo: 'l'.
		
	self assertAMarsRovers: marsRovers EndsInADirection: #W.! !

!TestMarsRovers methodsFor: 'tests' stamp: 'JR 11/2/2022 17:20:01'!
test03MarsRoversCanRotateRight

	| marsRovers |
	marsRovers := self marsRoversWithNorthDirectionStartAt: 2@4 andDo: 'r'.
		
	self assertAMarsRovers: marsRovers EndsInADirection: #E.! !

!TestMarsRovers methodsFor: 'tests' stamp: 'JR 11/2/2022 17:20:01'!
test04MarsRoversCanMoveBackward

	| marsRovers |
	marsRovers := self marsRoversWithNorthDirectionStartAt: 0@0 andDo: 'b'.
			
	self assertAMarsRovers: marsRovers EndsAtAPoint: 0@-1.! !

!TestMarsRovers methodsFor: 'tests' stamp: 'JR 11/2/2022 17:20:01'!
test05MarsRoversCanMoveFoward

	| marsRovers |
	marsRovers := self marsRoversWithNorthDirectionStartAt: 1@1 andDo: 'f'.
			
	self assertAMarsRovers: marsRovers EndsAtAPoint: 1@2.! !

!TestMarsRovers methodsFor: 'tests' stamp: 'JR 11/2/2022 17:20:23'!
test06MarsRoversCanDoACommandSequence

	| marsRovers |
	marsRovers := self marsRoversWithSouthDirectionStartAt: 2@2 andDo: 'bblllff'. 
			
	self assertAMarsRovers: marsRovers EndsAtAPoint: 0@4.! !

!TestMarsRovers methodsFor: 'tests' stamp: 'JR 11/2/2022 17:18:24'!
test07MarsRoversDoNothingWithAErrorComand

	| marsRovers |
	marsRovers := MarsRovers initializeWithSouthDirectionInAPoint: 12@-3.

	self should: [ 	marsRovers command: 'ñ' ] raise: Error
        withExceptionDo: [ :anError | 
		self assert: MarsRovers errorCommand equals: anError messageText.
		self assertAMarsRovers: marsRovers EndsAtAPoint: 12@-3 ].! !

!TestMarsRovers methodsFor: 'tests' stamp: 'JR 11/2/2022 16:32:36'!
test08MarsRoversDoNothingAfterErrorComandInASequence

	| marsRovers |
	marsRovers := MarsRovers initializeWithSouthDirectionInAPoint: 0@0.
			
	self should: [ 	marsRovers command: 'bbpbfbrllfb' ] raise: Error
        withExceptionDo: [ :anError | 
		self assert: MarsRovers errorCommand equals: anError messageText.
		self assertAMarsRovers: marsRovers EndsAtAPoint: 0@2 ].! !


!classDefinition: #MarsRovers category: 'EjercicioMarsRovers'!
Object subclass: #MarsRovers
	instanceVariableNames: 'point movement validCommands'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRovers'!

!MarsRovers methodsFor: 'instance creation' stamp: 'JR 11/2/2022 16:59:01'!
east
	movement := MovementToEastRules new.! !

!MarsRovers methodsFor: 'instance creation' stamp: 'JR 11/2/2022 16:53:08'!
initializeCommands

	validCommands := Set new .
	validCommands add: $l.
	validCommands add: $r.
	validCommands add: $b.
	validCommands add: $f.! !

!MarsRovers methodsFor: 'instance creation' stamp: 'JR 11/2/2022 16:59:28'!
north
	movement := MovementToNorthRules new.! !

!MarsRovers methodsFor: 'instance creation' stamp: 'JR 11/2/2022 16:59:46'!
south
	movement := MovementToSouthRules new.! !

!MarsRovers methodsFor: 'instance creation' stamp: 'JR 11/2/2022 17:00:01'!
west
	movement := MovementToWestRules new.! !

!MarsRovers methodsFor: 'instance creation' stamp: 'JR 10/31/2022 18:13:50'!
withAPoint: aPoint	
	point := aPoint
	! !


!MarsRovers methodsFor: 'operation' stamp: 'JR 11/2/2022 11:47:30'!
command: aComandBlock
	| aCommand | 
		
	1 to: aComandBlock size do: [ :indice |
		aCommand := aComandBlock at: indice.
		self validateCommand: aCommand.
		self executeACommand: aCommand.	]	! !


!MarsRovers methodsFor: 'testing' stamp: 'JR 10/31/2022 18:11:19'!
actualDirection
	^movement direction! !

!MarsRovers methodsFor: 'testing' stamp: 'JR 10/31/2022 14:12:01'!
actualPoint
	^point! !


!MarsRovers methodsFor: 'private' stamp: 'JR 10/31/2022 18:30:29'!
executeACommand: aCommand.
	
	aCommand = $l ifTrue: [self rotateLeft].
	aCommand = $r ifTrue: [self rotateRight].
	aCommand = $f ifTrue: [self moveFoward].
	aCommand = $b ifTrue: [self moveBackward].! !

!MarsRovers methodsFor: 'private' stamp: 'JR 10/31/2022 17:40:06'!
moveBackward

	point := point + movement moveBackward.! !

!MarsRovers methodsFor: 'private' stamp: 'JR 11/2/2022 11:46:11'!
moveFoward

	point := point + movement moveFoward.! !

!MarsRovers methodsFor: 'private' stamp: 'JR 10/31/2022 17:41:04'!
rotateLeft

	movement := movement rotateLeft.
! !

!MarsRovers methodsFor: 'private' stamp: 'JR 10/31/2022 17:40:52'!
rotateRight

	movement := movement rotateRight.
! !

!MarsRovers methodsFor: 'private' stamp: 'JR 11/2/2022 16:54:25'!
validateCommand: aComand	

	(validCommands includes: aComand) ifFalse: [self error: self class errorCommand].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRovers class' category: 'EjercicioMarsRovers'!
MarsRovers class
	instanceVariableNames: ''!

!MarsRovers class methodsFor: 'instance creation' stamp: 'JR 11/2/2022 16:49:26'!
initializeWithEastDirectionInAPoint: aPoint

	^self new initializeCommands east withAPoint: aPoint.! !

!MarsRovers class methodsFor: 'instance creation' stamp: 'JR 11/2/2022 16:49:35'!
initializeWithNorthDirectionInAPoint: aPoint

	^self new initializeCommands north withAPoint: aPoint.! !

!MarsRovers class methodsFor: 'instance creation' stamp: 'JR 11/2/2022 16:49:39'!
initializeWithSouthDirectionInAPoint: aPoint

	^self new initializeCommands south withAPoint: aPoint.! !

!MarsRovers class methodsFor: 'instance creation' stamp: 'JR 11/2/2022 16:49:45'!
initializeWithWestDirectionInAPoint: aPoint

	^self new initializeCommands west withAPoint: aPoint.! !


!MarsRovers class methodsFor: 'error' stamp: 'JR 10/31/2022 18:54:07'!
errorCommand

	^ 'WARNING. An invalid command was found'! !


!classDefinition: #MovementRules category: 'EjercicioMarsRovers'!
Object subclass: #MovementRules
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRovers'!

!MovementRules methodsFor: 'operations' stamp: 'JR 10/31/2022 17:55:50'!
moveBackward

	self subclassResponsibility ! !

!MovementRules methodsFor: 'operations' stamp: 'JR 10/31/2022 17:55:55'!
moveFoward

	self subclassResponsibility ! !

!MovementRules methodsFor: 'operations' stamp: 'JR 10/31/2022 17:56:03'!
rotateLeft

	self subclassResponsibility ! !

!MovementRules methodsFor: 'operations' stamp: 'JR 10/31/2022 17:55:59'!
rotateRight

	self subclassResponsibility ! !


!MovementRules methodsFor: 'testing' stamp: 'JR 10/31/2022 18:11:46'!
direction

	self subclassResponsibility ! !


!classDefinition: #MovementToEastRules category: 'EjercicioMarsRovers'!
MovementRules subclass: #MovementToEastRules
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRovers'!

!MovementToEastRules methodsFor: 'testing' stamp: 'JR 10/31/2022 18:12:00'!
direction

	^ #E! !


!MovementToEastRules methodsFor: 'operations' stamp: 'JR 10/31/2022 18:00:23'!
moveBackward

	^ -1@0! !

!MovementToEastRules methodsFor: 'operations' stamp: 'JR 10/31/2022 18:00:28'!
moveFoward

	^ 1@0! !

!MovementToEastRules methodsFor: 'operations' stamp: 'JR 11/2/2022 16:59:28'!
rotateLeft

	^ MovementToNorthRules new.! !

!MovementToEastRules methodsFor: 'operations' stamp: 'JR 11/2/2022 16:59:46'!
rotateRight

	^ MovementToSouthRules new.! !


!classDefinition: #MovementToNorthRules category: 'EjercicioMarsRovers'!
MovementRules subclass: #MovementToNorthRules
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRovers'!

!MovementToNorthRules methodsFor: 'testing' stamp: 'JR 10/31/2022 18:12:11'!
direction

	^ #N! !


!MovementToNorthRules methodsFor: 'operations' stamp: 'JR 10/31/2022 17:57:19'!
moveBackward

	^ 0@-1! !

!MovementToNorthRules methodsFor: 'operations' stamp: 'JR 10/31/2022 17:57:26'!
moveFoward

	^ 0@1! !

!MovementToNorthRules methodsFor: 'operations' stamp: 'JR 11/2/2022 17:00:01'!
rotateLeft

	^ MovementToWestRules new.! !

!MovementToNorthRules methodsFor: 'operations' stamp: 'JR 11/2/2022 16:59:01'!
rotateRight

	^ MovementToEastRules new.! !


!classDefinition: #MovementToSouthRules category: 'EjercicioMarsRovers'!
MovementRules subclass: #MovementToSouthRules
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRovers'!

!MovementToSouthRules methodsFor: 'testing' stamp: 'JR 10/31/2022 18:12:20'!
direction

	^ #S! !


!MovementToSouthRules methodsFor: 'operations' stamp: 'JR 10/31/2022 17:58:39'!
moveBackward

	^ 0@1! !

!MovementToSouthRules methodsFor: 'operations' stamp: 'JR 10/31/2022 17:58:48'!
moveFoward

	^ 0@-1! !

!MovementToSouthRules methodsFor: 'operations' stamp: 'JR 11/2/2022 16:59:01'!
rotateLeft

	^ MovementToEastRules new.! !

!MovementToSouthRules methodsFor: 'operations' stamp: 'JR 11/2/2022 17:00:01'!
rotateRight

	^ MovementToWestRules new.! !


!classDefinition: #MovementToWestRules category: 'EjercicioMarsRovers'!
MovementRules subclass: #MovementToWestRules
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRovers'!

!MovementToWestRules methodsFor: 'testing' stamp: 'JR 10/31/2022 18:12:27'!
direction

	^ #W! !


!MovementToWestRules methodsFor: 'operations' stamp: 'JR 10/31/2022 18:02:00'!
moveBackward

	^ 1@0! !

!MovementToWestRules methodsFor: 'operations' stamp: 'JR 10/31/2022 18:02:06'!
moveFoward

	^ -1@0! !

!MovementToWestRules methodsFor: 'operations' stamp: 'JR 11/2/2022 16:59:46'!
rotateLeft

	^ MovementToSouthRules new.! !

!MovementToWestRules methodsFor: 'operations' stamp: 'JR 11/2/2022 16:59:28'!
rotateRight

	^ MovementToNorthRules new.! !
