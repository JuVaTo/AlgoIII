!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio account deposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'test' stamp: 'JR 11/9/2022 20:15:19'!
assertErrorAddAccountOrPortfolioInvalidForShould: aBlock
	
	self should: aBlock value raise: Error
        withExceptionDo: [ :anError | self assert: Portfolio errorAddAccountOrPortfolioInvalid equals: anError messageText ].! !

!PortfolioTest methodsFor: 'test' stamp: 'JR 11/9/2022 19:01:54'!
setUpAPortfolioWithAnAccountWithADepositOf: anAmountOfPesos

	portfolio := Portfolio initializeWithEmptyAccounts.
	account := ReceptiveAccount new.
	deposit := Deposit register: anAmountOfPesos on: account.	
	portfolio add: account.! !

!PortfolioTest methodsFor: 'test' stamp: 'JR 11/9/2022 20:21:30'!
test11portfolioCanCalculateHisBalance

	self setUpAPortfolioWithAnAccountWithADepositOf: 100 * peso.
	
	self assert: 100 * peso equals: portfolio balance.
	
! !

!PortfolioTest methodsFor: 'test' stamp: 'JR 11/9/2022 20:21:37'!
test12portfolioKnowRegisteredTransaction

	self setUpAPortfolioWithAnAccountWithADepositOf: 100 * peso.

	self assert: (portfolio hasRegistered: deposit).
	
! !

!PortfolioTest methodsFor: 'test' stamp: 'JR 11/11/2022 09:07:11'!
test13portfolioCanGiveHisTransactions

	self setUpAPortfolioWithAnAccountWithADepositOf: 1200 * peso.
		
	self assert: (account transactions = portfolio transactions).
		! !

!PortfolioTest methodsFor: 'test' stamp: 'JR 11/9/2022 20:21:52'!
test14cantAddTwoTimesAnAccountToAPortfolio

	self setUpAPortfolioWithAnAccountWithADepositOf: 90 * peso.
	
	self assertErrorAddAccountOrPortfolioInvalidForShould: [[	portfolio add: account]].! !

!PortfolioTest methodsFor: 'test' stamp: 'JR 11/9/2022 20:34:10'!
test15portfolioCantAddAnAccountAlreadyIncludedInAnOtherPortfolio

	| aPortfolio |
	self setUpAPortfolioWithAnAccountWithADepositOf: 30 * peso.
	
	aPortfolio := Portfolio initializeWithEmptyAccounts.
	aPortfolio add: portfolio.
	
	self assertErrorAddAccountOrPortfolioInvalidForShould: [[	aPortfolio add: account]].! !

!PortfolioTest methodsFor: 'test' stamp: 'JR 11/9/2022 20:34:17'!
test16portfolioCantIncludeItself

	self setUpAPortfolioWithAnAccountWithADepositOf: 10 * peso.
	
	self assertErrorAddAccountOrPortfolioInvalidForShould: [[	portfolio add: portfolio]].! !

!PortfolioTest methodsFor: 'test' stamp: 'JR 11/9/2022 20:34:24'!
test17cantAddAPortfolioToOtherPortfolioIfTheFirstIncludesAnAccountThatTheSecondAlreadyHas

	| aPortfolio |
	self setUpAPortfolioWithAnAccountWithADepositOf: 990 * peso.
	
	aPortfolio := Portfolio initializeWithEmptyAccounts.
	aPortfolio add: account.
	
	self assertErrorAddAccountOrPortfolioInvalidForShould: [[	portfolio add: aPortfolio ]].! !

!PortfolioTest methodsFor: 'test' stamp: 'JR 11/9/2022 20:34:31'!
test18cantAddAnAccountToAChildPortfolioWhenTheAccountIsIncludedInTheFatherPortfolio

	| aPortfolio |
	self setUpAPortfolioWithAnAccountWithADepositOf: 1 * peso.
	
	aPortfolio := Portfolio initializeWithEmptyAccounts.
	portfolio add: aPortfolio.
	
	self assertErrorAddAccountOrPortfolioInvalidForShould: [[	aPortfolio add: account]].! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'i 11/4/2022 19:34:20'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferTransactionBetweenAccountsTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTransactionBetweenAccountsTest
	instanceVariableNames: 'originAccount destinyAccount transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTransactionBetweenAccountsTest methodsFor: 'test' stamp: 'JR 11/8/2022 21:30:20'!
setUpFromAnOriginAccountToADestinyAccountTransfer: anAmountOfPesos

	originAccount := ReceptiveAccount new.
	destinyAccount := ReceptiveAccount new.
	
	transfer := TransferTransaction from: originAccount transferTo: destinyAccount anAmountOfPesos: anAmountOfPesos 

	
	! !

!TransferTransactionBetweenAccountsTest methodsFor: 'test' stamp: 'JR 11/9/2022 20:20:45'!
test08CanTransferFromAnAccountToOtherAccount

	self setUpFromAnOriginAccountToADestinyAccountTransfer: 100 * peso.
	
	self assert: originAccount balance equals: (-100 * peso).
	self assert: destinyAccount balance equals: (100 * peso).

	
	! !

!TransferTransactionBetweenAccountsTest methodsFor: 'test' stamp: 'JR 11/9/2022 20:20:54'!
test09TransferCanGiveItsValue

	self setUpFromAnOriginAccountToADestinyAccountTransfer: 130 * peso.
	
	self assert: transfer value equals: (130 * peso).

	
	! !

!TransferTransactionBetweenAccountsTest methodsFor: 'test' stamp: 'JR 11/9/2022 20:21:04'!
test10EachPartOfTransferGiveTheValueOfItsOtherPart

	| aTransferDepositPart aTransferExtractionPart |

	self setUpFromAnOriginAccountToADestinyAccountTransfer: 10 * peso.

	aTransferExtractionPart := transfer extractionPart.
	aTransferDepositPart := transfer depositPart.
	
	self assert: aTransferExtractionPart otherPart value equals: (10 * peso). 
	self assert: aTransferDepositPart otherPart value equals: (-10 * peso).
	

	
	! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'JR 11/7/2022 11:51:48'!
value 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'JR 11/7/2022 11:51:26'!
valueForBalance
 
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

!Deposit methodsFor: 'value' stamp: 'JR 11/7/2022 11:51:26'!
valueForBalance

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

!Withdraw methodsFor: 'value' stamp: 'JR 11/7/2022 11:51:26'!
valueForBalance

	^ value negated! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accountsAndPortfolios portfolioFather'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'instance creation' stamp: 'JR 11/9/2022 19:29:01'!
initialize

	accountsAndPortfolios := OrderedCollection new.
	portfolioFather := OrderedCollection new.
! !


!Portfolio methodsFor: 'validation private' stamp: 'JR 11/9/2022 19:53:01'!
aPortfolioFatherIncludes: anAccountOrAPortfolioToValidate

	^ portfolioFather anySatisfy: [ :aPortfolioFather | aPortfolioFather includes: anAccountOrAPortfolioToValidate].
! !

!Portfolio methodsFor: 'validation private' stamp: 'JR 11/9/2022 20:06:32'!
aPortfolioToAddIncludes: anAccountOrAPortfolioToValidate

	^ accountsAndPortfolios anySatisfy: [ :aPortfolioOrAccount | anAccountOrAPortfolioToValidate includes: aPortfolioOrAccount ].! !

!Portfolio methodsFor: 'validation private' stamp: 'JR 11/9/2022 20:06:37'!
equals: anAccountOrAPortfolioToValidate

	^ self = anAccountOrAPortfolioToValidate.! !

!Portfolio methodsFor: 'validation private' stamp: 'JR 11/9/2022 20:06:51'!
includes: anAccountOrAPortfolio
	
	^ accountsAndPortfolios includes: anAccountOrAPortfolio! !

!Portfolio methodsFor: 'validation private' stamp: 'JR 11/9/2022 20:01:38'!
invalidAccountOrPortfolio: anAccountOrAPortfolioToValidate
  	
	^ (self includes: anAccountOrAPortfolioToValidate) or: [
		(self equals: anAccountOrAPortfolioToValidate) or: [
			(self portfolioSonIncludes: anAccountOrAPortfolioToValidate) or: [
				(self aPortfolioToAddIncludes: anAccountOrAPortfolioToValidate) or: [
					(self aPortfolioFatherIncludes: anAccountOrAPortfolioToValidate) ]]]]! !

!Portfolio methodsFor: 'validation private' stamp: 'JR 11/9/2022 19:45:13'!
portfolioSonIncludes: anAccountOrAPortfolioToValidate
	
	| portfolios |
	portfolios := accountsAndPortfolios select: [ :anAccountOrPortfolio | anAccountOrPortfolio isKindOf: Portfolio ].
	
	^ portfolios anySatisfy: [ :aPortfolio | (aPortfolio includes: anAccountOrAPortfolioToValidate)].! !


!Portfolio methodsFor: 'private' stamp: 'JR 11/9/2022 19:30:49'!
portfolioAddFather: aPortfolioFather	
	
	portfolioFather add: aPortfolioFather.! !


!Portfolio methodsFor: 'operations' stamp: 'JR 11/10/2022 19:38:46'!
add: anAccountOrAPortfolio

	(self invalidAccountOrPortfolio: anAccountOrAPortfolio) 	ifTrue: [ self error: self class errorAddAccountOrPortfolioInvalid ].
	accountsAndPortfolios add: anAccountOrAPortfolio.
	anAccountOrAPortfolio portfolioAddFather: self.
! !

!Portfolio methodsFor: 'operations' stamp: 'JR 11/8/2022 23:43:36'!
balance

	^ accountsAndPortfolios sum: [ :aTransaction | aTransaction balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'operations' stamp: 'JR 11/8/2022 23:40:16'!
hasRegistered: aTransaction

	^ accountsAndPortfolios anySatisfy: [ :anAccountOrAPortfolio | anAccountOrAPortfolio hasRegistered: aTransaction ]. ! !

!Portfolio methodsFor: 'operations' stamp: 'JR 11/10/2022 19:52:04'!
transactions 

	| allTransactions |
	allTransactions := OrderedCollection new.
	
	accountsAndPortfolios do: [ :anAccountOrPortfolio | allTransactions addAllLast: anAccountOrPortfolio transactions ].
	
	^ allTransactions.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'JR 11/9/2022 00:08:22'!
initializeWithEmptyAccounts

	^ self new initialize.! !


!Portfolio class methodsFor: 'error' stamp: 'JR 11/9/2022 00:02:20'!
errorAddAccountOrPortfolioInvalid

	^ 'Error. Cant add this account or portfolio to the portfolio'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'JR 11/9/2022 18:25:15'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'JR 11/7/2022 11:51:26'!
balance

	^transactions sum: [ :aTransaction | aTransaction valueForBalance ] ifEmpty: [ 0 ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'portfolio private' stamp: 'JR 11/10/2022 19:40:05'!
includes: aPortfolioOrAccount
	
	"OJO: HARDCODEDADO"

	^false! !

!ReceptiveAccount methodsFor: 'portfolio private' stamp: 'JR 11/10/2022 19:40:11'!
portfolioAddFather: aPortfolio

	"OJO: HARDCODEDADO"

	^self! !


!classDefinition: #TransferTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransferTransaction
	instanceVariableNames: 'value depositPart extractionPart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTransaction methodsFor: 'operations' stamp: 'i 11/6/2022 16:08:47'!
depositPart
	^depositPart.! !

!TransferTransaction methodsFor: 'operations' stamp: 'i 11/6/2022 16:08:13'!
extractionPart
	^extractionPart.! !

!TransferTransaction methodsFor: 'operations' stamp: 'i 11/6/2022 15:39:40'!
value
	^value.! !


!TransferTransaction methodsFor: 'instance creation' stamp: 'JR 11/10/2022 19:33:38'!
initializeFrom: anOriginAccount to: aDestinyAccount anAmountOfPesos: anAmountOfPesos

	value := anAmountOfPesos.
	depositPart := TransferTransactionPart initializeWithAnAmountOfPesos: value andTransferAsociated: self.
	extractionPart := TransferTransactionPart initializeWithAnAmountOfPesos: value negated andTransferAsociated: self.
	
	self from: anOriginAccount to: aDestinyAccount transfer: anAmountOfPesos.! !


!TransferTransaction methodsFor: 'private' stamp: 'JR 11/7/2022 12:22:51'!
from: anOriginAccount to: aDestinyAccount transfer:  anAmountOfPesos.
	
	Deposit register: anAmountOfPesos on: aDestinyAccount .
	Withdraw register: anAmountOfPesos on: anOriginAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'operations' stamp: 'JR 11/7/2022 12:11:56'!
from: anOriginAccount transferTo: aDestinyAccount anAmountOfPesos: anAmountOfPesos
	
	^ self new initializeFrom: anOriginAccount to: aDestinyAccount anAmountOfPesos: anAmountOfPesos! !


!classDefinition: #TransferTransactionPart category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransferTransactionPart
	instanceVariableNames: 'value transferAsociated'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTransactionPart methodsFor: 'instance creation' stamp: 'JR 11/8/2022 21:35:38'!
withAnAmountOfPesos: anAmountOfPesos andTransferAsociated: aTransferTransaction 
	
	value := anAmountOfPesos.
	transferAsociated := aTransferTransaction.! !


!TransferTransactionPart methodsFor: 'operations' stamp: 'JR 11/10/2022 19:33:46'!
otherPart
	
	(self value positive) ifTrue: [ ^transferAsociated extractionPart ].
	^transferAsociated depositPart.! !

!TransferTransactionPart methodsFor: 'operations' stamp: 'JR 11/8/2022 21:38:14'!
value

	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransactionPart class' category: 'ServiciosFinancieros-Ejercicio'!
TransferTransactionPart class
	instanceVariableNames: ''!

!TransferTransactionPart class methodsFor: 'instance creation' stamp: 'JR 11/8/2022 21:33:01'!
initializeWithAnAmountOfPesos: anAmountOfPesos andTransferAsociated: aTransfer

	^self new withAnAmountOfPesos: anAmountOfPesos andTransferAsociated: aTransfer.! !
