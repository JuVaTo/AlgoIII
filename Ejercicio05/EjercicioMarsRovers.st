!classDefinition: #TestMarsRovers category: 'EjercicioMarsRovers'!
TestCase subclass: #TestMarsRovers
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRovers'!

!TestMarsRovers methodsFor: 'tests' stamp: 'JR 10/31/2022 18:42:08'!
test01MarsRoversCanStartInAPointWithADirection

	| marsRovers finalPoint |
	marsRovers := MarsRovers initializeWithWestDirectionInAPoint: 0@0.
		
	finalPoint := 0@0.
	
	self assert: marsRovers actualPoint = finalPoint.
	self assert: marsRovers actualDirection = #W.! !

!TestMarsRovers methodsFor: 'tests' stamp: 'JR 10/31/2022 18:39:27'!
test02MarsRoversCanRotateLeft

	| marsRovers |
	marsRovers := MarsRovers initializeWithNorthDirectionInAPoint: 0@0.
	
	marsRovers command: 'l'.
	
	self assert: marsRovers actualDirection = #W.! !

!TestMarsRovers methodsFor: 'tests' stamp: 'JR 10/31/2022 18:39:35'!
test03MarsRoversCanRotateRight

	| marsRovers |
	marsRovers := MarsRovers initializeWithNorthDirectionInAPoint: 0@0.
	
	marsRovers command: 'r'.
	
	self assert: marsRovers actualDirection = #E.! !

!TestMarsRovers methodsFor: 'tests' stamp: 'JR 10/31/2022 18:17:48'!
test04MarsRoversCanMoveBackward

	| marsRovers finalPoint |
	marsRovers := MarsRovers initializeWithNorthDirectionInAPoint: 0@0.
	
	marsRovers command: 'b'.
	
	finalPoint := 0@-1.
	
	self assert: (marsRovers actualPoint = finalPoint).! !

!TestMarsRovers methodsFor: 'tests' stamp: 'JR 10/31/2022 18:39:54'!
test05MarsRoversCanMoveFoward

	| marsRovers finalPoint |
	marsRovers := MarsRovers initializeWithNorthDirectionInAPoint: 0@0.
	
	marsRovers command: 'f'.
	
	finalPoint := 0@1.
	
	self assert: (marsRovers actualPoint = finalPoint).! !

!TestMarsRovers methodsFor: 'tests' stamp: 'JR 10/31/2022 18:45:32'!
test06MarsRoversCanDoACommandSequence

	| marsRovers finalPoint |
	marsRovers := MarsRovers initializeWithEastDirectionInAPoint: 2@2.
	
	marsRovers command: 'bblllff'.	
	
	finalPoint := 0@0.
	
	self assert: (marsRovers actualPoint = finalPoint).! !

!TestMarsRovers methodsFor: 'tests' stamp: 'JR 10/31/2022 19:06:38'!
test07MarsRoversDoNothingWithAErrorComand

	| marsRovers finalPoint |
	marsRovers := MarsRovers initializeWithSouthDirectionInAPoint: 12@-3.
	finalPoint := 12@-3.
	
	self should: [ 	marsRovers command: 'ñ' ] raise: Error
        withExceptionDo: [ :anError | 
		self assert: MarsRovers errorCommand equals: anError messageText.
		self assert: (marsRovers actualPoint = finalPoint). ].! !

!TestMarsRovers methodsFor: 'tests' stamp: 'JR 10/31/2022 19:07:41'!
test08MarsRoversDoNothingAfterErrorComandInASequence

	| marsRovers finalPoint |
	marsRovers := MarsRovers initializeWithSouthDirectionInAPoint: 0@0.
		
	finalPoint := 0@2.
	
	self should: [ 	marsRovers command: 'bbpbfbrllfb' ] raise: Error
        withExceptionDo: [ :anError | 
		self assert: MarsRovers errorCommand equals: anError messageText.
		self assert: (marsRovers actualPoint = finalPoint). ].! !


!classDefinition: #MarsRovers category: 'EjercicioMarsRovers'!
Object subclass: #MarsRovers
	instanceVariableNames: 'point movement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRovers'!

!MarsRovers methodsFor: 'instance creation' stamp: 'JR 10/31/2022 18:15:36'!
eastWithAPoint: aPoint	
	movement := MovementToEast new.
	self withAPoint: aPoint.	! !

!MarsRovers methodsFor: 'instance creation' stamp: 'JR 10/31/2022 18:15:23'!
northWithAPoint: aPoint	
	movement := MovementToNorth new.
	self withAPoint: aPoint.	! !

!MarsRovers methodsFor: 'instance creation' stamp: 'JR 10/31/2022 18:15:47'!
southWithAPoint: aPoint	
	movement := MovementToSouth new.
	self withAPoint: aPoint.	! !

!MarsRovers methodsFor: 'instance creation' stamp: 'JR 10/31/2022 18:15:58'!
westWithAPoint: aPoint	
	movement := MovementToWest new.
	self withAPoint: aPoint.	! !

!MarsRovers methodsFor: 'instance creation' stamp: 'JR 10/31/2022 18:13:50'!
withAPoint: aPoint	
	point := aPoint
	! !


!MarsRovers methodsFor: 'operations' stamp: 'JR 10/31/2022 18:11:19'!
actualDirection
	^movement direction! !

!MarsRovers methodsFor: 'operations' stamp: 'JR 10/31/2022 14:12:01'!
actualPoint
	^point! !

!MarsRovers methodsFor: 'operations' stamp: 'JR 10/31/2022 18:58:16'!
command: aComandBlock
	| indice aCommand | indice := 1.
		
	[indice <= aComandBlock size] whileTrue: [
		aCommand := aComandBlock at: indice.
		self validCommand: aCommand.
		self executeACommand: aCommand.
		indice := indice + 1.
		].
! !


!MarsRovers methodsFor: 'private' stamp: 'JR 10/31/2022 18:30:29'!
executeACommand: aCommand.
	
	aCommand = $l ifTrue: [self rotateLeft].
	aCommand = $r ifTrue: [self rotateRight].
	aCommand = $f ifTrue: [self moveFoward].
	aCommand = $b ifTrue: [self moveBackward].! !

!MarsRovers methodsFor: 'private' stamp: 'JR 10/31/2022 17:40:06'!
moveBackward

	point := point + movement moveBackward.! !

!MarsRovers methodsFor: 'private' stamp: 'JR 10/31/2022 18:05:05'!
moveFoward

	point := point + (movement moveFoward).! !

!MarsRovers methodsFor: 'private' stamp: 'JR 10/31/2022 17:41:04'!
rotateLeft

	movement := movement rotateLeft.
! !

!MarsRovers methodsFor: 'private' stamp: 'JR 10/31/2022 17:40:52'!
rotateRight

	movement := movement rotateRight.
! !

!MarsRovers methodsFor: 'private' stamp: 'JR 10/31/2022 19:02:05'!
validCommand: aComand	
	| validComands | validComands := 'lrfb'.
	(validComands includesSubString: aComand asString) ifFalse: [self error: self class errorCommand]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRovers class' category: 'EjercicioMarsRovers'!
MarsRovers class
	instanceVariableNames: ''!

!MarsRovers class methodsFor: 'instance creation' stamp: 'JR 10/31/2022 18:16:26'!
initializeWithEastDirectionInAPoint: aPoint

	^self new eastWithAPoint: aPoint.! !

!MarsRovers class methodsFor: 'instance creation' stamp: 'JR 10/31/2022 18:14:33'!
initializeWithNorthDirectionInAPoint: aPoint

	^self new northWithAPoint: aPoint.! !

!MarsRovers class methodsFor: 'instance creation' stamp: 'JR 10/31/2022 18:16:39'!
initializeWithSouthDirectionInAPoint: aPoint

	^self new southWithAPoint: aPoint.! !

!MarsRovers class methodsFor: 'instance creation' stamp: 'JR 10/31/2022 18:16:53'!
initializeWithWestDirectionInAPoint: aPoint

	^self new westWithAPoint: aPoint.! !


!MarsRovers class methodsFor: 'error' stamp: 'JR 10/31/2022 18:54:07'!
errorCommand

	^ 'WARNING. An invalid command was found'! !


!classDefinition: #MovementWithDirection category: 'EjercicioMarsRovers'!
Object subclass: #MovementWithDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRovers'!

!MovementWithDirection methodsFor: 'operations' stamp: 'JR 10/31/2022 18:11:46'!
direction

	self subclassResponsibility ! !

!MovementWithDirection methodsFor: 'operations' stamp: 'JR 10/31/2022 17:55:50'!
moveBackward

	self subclassResponsibility ! !

!MovementWithDirection methodsFor: 'operations' stamp: 'JR 10/31/2022 17:55:55'!
moveFoward

	self subclassResponsibility ! !

!MovementWithDirection methodsFor: 'operations' stamp: 'JR 10/31/2022 17:56:03'!
rotateLeft

	self subclassResponsibility ! !

!MovementWithDirection methodsFor: 'operations' stamp: 'JR 10/31/2022 17:55:59'!
rotateRight

	self subclassResponsibility ! !


!classDefinition: #MovementToEast category: 'EjercicioMarsRovers'!
MovementWithDirection subclass: #MovementToEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRovers'!

!MovementToEast methodsFor: 'operations' stamp: 'JR 10/31/2022 18:12:00'!
direction

	^ #E! !

!MovementToEast methodsFor: 'operations' stamp: 'JR 10/31/2022 18:00:23'!
moveBackward

	^ -1@0! !

!MovementToEast methodsFor: 'operations' stamp: 'JR 10/31/2022 18:00:28'!
moveFoward

	^ 1@0! !

!MovementToEast methodsFor: 'operations' stamp: 'JR 10/31/2022 18:01:07'!
rotateLeft

	^ MovementToNorth new.! !

!MovementToEast methodsFor: 'operations' stamp: 'JR 10/31/2022 18:04:01'!
rotateRight

	^ MovementToSouth new.! !


!classDefinition: #MovementToNorth category: 'EjercicioMarsRovers'!
MovementWithDirection subclass: #MovementToNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRovers'!

!MovementToNorth methodsFor: 'operations' stamp: 'JR 10/31/2022 18:12:11'!
direction

	^ #N! !

!MovementToNorth methodsFor: 'operations' stamp: 'JR 10/31/2022 17:57:19'!
moveBackward

	^ 0@-1! !

!MovementToNorth methodsFor: 'operations' stamp: 'JR 10/31/2022 17:57:26'!
moveFoward

	^ 0@1! !

!MovementToNorth methodsFor: 'operations' stamp: 'JR 10/31/2022 17:58:15'!
rotateLeft

	^ MovementToWest new.! !

!MovementToNorth methodsFor: 'operations' stamp: 'JR 10/31/2022 17:58:05'!
rotateRight

	^ MovementToEast new.! !


!classDefinition: #MovementToSouth category: 'EjercicioMarsRovers'!
MovementWithDirection subclass: #MovementToSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRovers'!

!MovementToSouth methodsFor: 'operations' stamp: 'JR 10/31/2022 18:12:20'!
direction

	^ #S! !

!MovementToSouth methodsFor: 'operations' stamp: 'JR 10/31/2022 17:58:39'!
moveBackward

	^ 0@1! !

!MovementToSouth methodsFor: 'operations' stamp: 'JR 10/31/2022 17:58:48'!
moveFoward

	^ 0@-1! !

!MovementToSouth methodsFor: 'operations' stamp: 'JR 10/31/2022 17:59:25'!
rotateLeft

	^ MovementToEast new.! !

!MovementToSouth methodsFor: 'operations' stamp: 'JR 10/31/2022 17:59:37'!
rotateRight

	^ MovementToWest new.! !


!classDefinition: #MovementToWest category: 'EjercicioMarsRovers'!
MovementWithDirection subclass: #MovementToWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioMarsRovers'!

!MovementToWest methodsFor: 'operations' stamp: 'JR 10/31/2022 18:12:27'!
direction

	^ #W! !

!MovementToWest methodsFor: 'operations' stamp: 'JR 10/31/2022 18:02:00'!
moveBackward

	^ 1@0! !

!MovementToWest methodsFor: 'operations' stamp: 'JR 10/31/2022 18:02:06'!
moveFoward

	^ -1@0! !

!MovementToWest methodsFor: 'operations' stamp: 'JR 10/31/2022 18:01:34'!
rotateLeft

	^ MovementToSouth new.! !

!MovementToWest methodsFor: 'operations' stamp: 'JR 10/31/2022 18:01:44'!
rotateRight

	^ MovementToNorth new.! !
