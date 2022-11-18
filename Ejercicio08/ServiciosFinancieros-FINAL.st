!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'JR 11/16/2022 15:49:02'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio name: 'nombre' with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'JR 11/17/2022 21:08:40'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio name: 'nombre' with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio name: 'nombre' with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'JR 11/16/2022 15:49:39'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio name: 'nombre' with: account .
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'JR 11/16/2022 15:58:43'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio name: 'nombre' with: simplePortfolioAccount .
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio name: 'nombre' with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'JR 11/16/2022 15:50:04'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio name: 'nombre' with: account .
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'JR 11/16/2022 15:58:43'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio name: 'nombre' with: simplePortfolioAccount .
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio name: 'nombre' with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'JR 11/16/2022 15:50:27'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio name: 'nombre' with: account .
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'JR 11/16/2022 15:50:53'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio name: 'nombre' with: account .
	composedPortfolio := Portfolio name: 'nombre' with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'JR 11/16/2022 15:51:03'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio name: 'nombre' with: account .
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'JR 11/16/2022 15:51:19'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio name: 'nombre' with: simplePortfolio .
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'JR 11/16/2022 15:52:03'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio name: 'nombre' with: portfolio .
	leftRootParentPortfolio := Portfolio name: 'nombre' with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio name: 'nombre' with: portfolio .
	rightRootParentPortfolio := Portfolio name: 'nombre' with: rightParentPortfolio .
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'JR 11/16/2022 15:58:43'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio name: 'nombre' with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio name: 'nombre' with: sharedAccount .
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
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


!classDefinition: #ReportAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReportAccountTest
	instanceVariableNames: 'portfolio account anAccount deposit childrenPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReportAccountTest methodsFor: 'transfer net tests' stamp: 'JR 11/14/2022 07:55:35'!
test01TransferNetOfAnEmptyAccountIsZero
	
	| anEmptyAccount |
	
	anEmptyAccount := ReceptiveAccount new.
	
	self assert: 0 * peso equals: 	(TransferNetReport generateFor: anEmptyAccount).	! !

!ReportAccountTest methodsFor: 'transfer net tests' stamp: 'JR 11/14/2022 07:56:10'!
test02ATransferBetweenAccountsChangeTransferNet

	self setUpTransferNet.
	
	self assert: 10 * peso equals: 	(TransferNetReport generateFor: anAccount).	

	self assert: -10 * peso equals: 	(TransferNetReport generateFor: account).	
! !

!ReportAccountTest methodsFor: 'transfer net tests' stamp: 'JR 11/14/2022 07:56:27'!
test03TransferNetOfAnEmptyPorfolioIsZero
	
	| anEmptyPortfolio |
	
	anEmptyPortfolio := Portfolio new.
	
	self assert: 0 * peso equals: 	(TransferNetReport generateFor: anEmptyPortfolio).	
! !

!ReportAccountTest methodsFor: 'transfer net tests' stamp: 'JR 11/14/2022 07:56:41'!
test04ATransferBetweenAccountsInPortfolioChangeTransferNet
	
	self setUpTransferNet.
	
	self assert: -10 * peso equals: 	(TransferNetReport generateFor: portfolio).	
! !

!ReportAccountTest methodsFor: 'transfer net tests' stamp: 'JR 11/14/2022 10:05:54'!
test05RecursiveTransferNet
	
	| aPortfolio |
	
	self setUpTransferNet.

	aPortfolio := Portfolio new.
	
	aPortfolio add: anAccount.
	portfolio add: aPortfolio.
	
	self assert: 0 * peso equals: 	(TransferNetReport generateFor: portfolio).	
! !


!ReportAccountTest methodsFor: 'summary tests' stamp: 'JR 11/16/2022 15:53:04'!
test06SummaryOfAnEmptyAccountIsZero

	| accountSummary anEmptyAccount |
	
	anEmptyAccount := ReceptiveAccount new.
	
	accountSummary := OrderedCollection with: 'Balance = 0 * pesos'.
	
	(SummaryReport generateFor: anEmptyAccount).	
	
	self assert: accountSummary equals: (SummaryReport generateFor: anEmptyAccount).	! !

!ReportAccountTest methodsFor: 'summary tests' stamp: 'JR 11/16/2022 15:59:08'!
test07SummaryOfAnAccountWithATransaction

	| accountSummary |
	
	self setUpSummary.
	
	accountSummary := OrderedCollection with: 'Deposit of ', deposit value asString with: 'Balance = ', account balance asString.

	self assert: accountSummary equals: (SummaryReport generateFor: account)	.! !

!ReportAccountTest methodsFor: 'summary tests' stamp: 'JR 11/16/2022 15:53:15'!
test08SummaryOfAnEmptyPortfolioIsZero

	| portfolioSummary anEmptyPortfolio |
	
	anEmptyPortfolio := Portfolio new.
	portfolioSummary := OrderedCollection with: 'Balance = 0 * pesos'.
	
	self assert: portfolioSummary equals: (SummaryReport generateFor: anEmptyPortfolio)	.! !

!ReportAccountTest methodsFor: 'summary tests' stamp: 'JR 11/16/2022 15:59:15'!
test09SummaryOfAPortfolioWithAnAccount

	| portfolioSummary |
	
	self setUpSummary.
	
	portfolioSummary := OrderedCollection with: 'Deposit of ',deposit value asString with: 'Balance = ', account balance asString.
	
	self assert: portfolioSummary equals: (SummaryReport generateFor: portfolio).! !

!ReportAccountTest methodsFor: 'summary tests' stamp: 'JR 11/15/2022 21:23:52'!
test10SummaryOfAPortfolioWithMultiplesAccounts

	| portfolioSummary aWithdraw |
	
	self setUpSummary.
	
	anAccount := ReceptiveAccount new.
	aWithdraw := Withdraw register: 50 * peso on: anAccount.
	
	portfolio add: anAccount.
	
	portfolioSummary := OrderedCollection with: 'Deposit of ',deposit value asString with: 'Withdraw of ',aWithdraw value asString with: 'Balance = 50 * pesos'.
	
	self assert: portfolioSummary equals: (SummaryReport generateFor: portfolio).! !

!ReportAccountTest methodsFor: 'summary tests' stamp: 'JR 11/15/2022 21:24:18'!
test11ARecursiveSummaryOfAPortfolio

	| portfolioSummary aWithdraw aPortfolio |
	
	self setUpSummary.
	
	anAccount := ReceptiveAccount new.
	aPortfolio := Portfolio new.
	aWithdraw := Withdraw register: 50 * peso on: anAccount.

	aPortfolio add: anAccount.
	portfolio add: aPortfolio.
	
	portfolioSummary := OrderedCollection with: 'Deposit of ',deposit value asString with: 'Withdraw of ',aWithdraw value asString with: 'Balance = 50 * pesos'.
	
	self assert: portfolioSummary equals: (SummaryReport generateFor: portfolio).! !


!ReportAccountTest methodsFor: 'tree printer' stamp: 'IY 11/18/2022 15:19:38'!
test12TreePrinterOfAnEmptyPortfolio

	| portfolioTreeReport |

	portfolio := Portfolio name: 'Portfolio familia'.
	
	portfolioTreeReport := OrderedCollection with: 'Portfolio familia'.
	
	self assert: portfolioTreeReport equals: (PortfolioTreePrinterReport generateFor: portfolio).! !

!ReportAccountTest methodsFor: 'tree printer' stamp: 'IY 11/18/2022 15:20:08'!
test13TreePrinterOfAPortfolioWithAnAccount

	| portfolioTreeReport |

	portfolio := Portfolio name: 'Portfolio familia'.
	account := ReceptiveAccount name: 'Cuenta mia'.
	portfolio add: account.
	
	portfolioTreeReport := OrderedCollection with: 'Portfolio familia' with: '    Cuenta mia'.
	
	self assert: portfolioTreeReport equals: (PortfolioTreePrinterReport generateFor: portfolio).! !

!ReportAccountTest methodsFor: 'tree printer' stamp: 'IY 11/18/2022 15:28:37'!
test14TreePrinterOfAPortfolioWithAccountsAndPortfolios

	| portfolioTreeReport familyPortfolio |
	
	familyPortfolio := self familyPortfolioSetUp.
	
	portfolioTreeReport := OrderedCollection with: 'Portfolio de la familia' with: '    Cuenta mia' with: '    Portfolio de hijos' with: '        Cuenta de Juan' with: '        Cuenta de Angeles'.	
	
	self assert: portfolioTreeReport equals: (PortfolioTreePrinterReport generateFor: familyPortfolio).! !

!ReportAccountTest methodsFor: 'tree printer' stamp: 'IY 11/18/2022 15:35:53'!
test15TreePrinterOfAPortfolioWithMultiplesAccountsAndPortfolios

	| portfolioTreeReport familyPortfolio nietoPortfolio pepeAccount |
	
	familyPortfolio := self familyPortfolioSetUp.
	
	pepeAccount := ReceptiveAccount name: 'Cuenta de Pepe'.
	nietoPortfolio := Portfolio name: 'Portfolio de nietos' with: pepeAccount.
	childrenPortfolio add: nietoPortfolio.

	portfolioTreeReport := OrderedCollection with: 'Portfolio de la familia' with: '    Cuenta mia' with: '    Portfolio de hijos' with: '        Cuenta de Juan' with: '        Cuenta de Angeles'.	
	
	portfolioTreeReport add: '        Portfolio de nietos'.
	portfolioTreeReport add: '            Cuenta de Pepe'.
	
	self assert: portfolioTreeReport equals: (PortfolioTreePrinterReport generateFor: familyPortfolio).! !


!ReportAccountTest methodsFor: 'detailed tree printer' stamp: 'IY 11/18/2022 15:22:07'!
test16DetailedTreePrinterOfAnEmptyPortfolio

	| portfolioTreeReport |

	portfolio := Portfolio name: 'Portfolio familia'.
	
	portfolioTreeReport := OrderedCollection with: 'Portfolio familia' with: '    Balance = 0 * pesos'.
	
	self assert: portfolioTreeReport equals: (PortfolioDetailedTreePrinterReport generateFor: portfolio).! !

!ReportAccountTest methodsFor: 'detailed tree printer' stamp: 'IY 11/18/2022 15:23:13'!
test17DetailedTreePrinterOfAPortfolioWithAnAccount

	| portfolioTreeReport |
	self setUpTransferNet.
	
	portfolioTreeReport := OrderedCollection with: 'portfolio' with: '    account' with: '        Transfer withdraw of 10 * pesos' with: '        Balance = -10 * pesos' with: '    Balance = -10 * pesos'.
	
	self assert: portfolioTreeReport equals: (PortfolioDetailedTreePrinterReport generateFor: portfolio).! !

!ReportAccountTest methodsFor: 'detailed tree printer' stamp: 'IY 11/18/2022 15:36:25'!
test18DetailedTreePrinterOfAPortfolioWithAccountsAndPortfolio

	| portfolioTreeReport familyPortfolio |
	
	familyPortfolio := self familyPortfolioSetUp.

	portfolioTreeReport := OrderedCollection new.
	portfolioTreeReport add: 'Portfolio de la familia'.
	portfolioTreeReport add: '    Cuenta mia'. 
	portfolioTreeReport add: '        Balance = 0 * pesos'.	
	portfolioTreeReport add: '    Portfolio de hijos'.
	portfolioTreeReport add: '        Cuenta de Juan'.
	portfolioTreeReport add: '            Balance = 0 * pesos'.	
	portfolioTreeReport add: '        Cuenta de Angeles'.	
	portfolioTreeReport add: '            Balance = 0 * pesos'.	
	portfolioTreeReport add: '        Balance = 0 * pesos'.	
	portfolioTreeReport add: '    Balance = 0 * pesos'.
	
	self assert: portfolioTreeReport equals: (PortfolioDetailedTreePrinterReport generateFor: familyPortfolio).! !

!ReportAccountTest methodsFor: 'detailed tree printer' stamp: 'IY 11/18/2022 15:40:24'!
test19DetailedTreePrinterOfAPortfolioWithMultiplesAccountsAndPortfolios

	| portfolioTreeReport familyPortfolio nietoPortfolio pepeAccount |
	
	familyPortfolio := self familyPortfolioSetUp.
	
	pepeAccount := ReceptiveAccount name: 'Cuenta de Pepe'.
	nietoPortfolio := Portfolio name: 'Portfolio de nietos' with: pepeAccount.
	childrenPortfolio add: nietoPortfolio.
	Deposit register: 100 * peso on: pepeAccount.

	portfolioTreeReport := OrderedCollection new.
	portfolioTreeReport add: 'Portfolio de la familia'.
	portfolioTreeReport add: '    Cuenta mia'. 
	portfolioTreeReport add: '        Balance = 0 * pesos'.	
	portfolioTreeReport add: '    Portfolio de hijos'.
	portfolioTreeReport add: '        Cuenta de Juan'.
	portfolioTreeReport add: '            Balance = 0 * pesos'.	
	portfolioTreeReport add: '        Cuenta de Angeles'.	
	portfolioTreeReport add: '            Balance = 0 * pesos'.	
	portfolioTreeReport add: '        Portfolio de nietos'.
	portfolioTreeReport add: '            Cuenta de Pepe'.	
	portfolioTreeReport add: '                Deposit of 100 * pesos'.	
	portfolioTreeReport add: '                Balance = 100 * pesos'.	
	portfolioTreeReport add: '            Balance = 100 * pesos'.	
	portfolioTreeReport add: '        Balance = 100 * pesos'.	
	portfolioTreeReport add: '    Balance = 100 * pesos'.
	
	self assert: portfolioTreeReport equals: (PortfolioDetailedTreePrinterReport generateFor: familyPortfolio).! !


!ReportAccountTest methodsFor: 'set up' stamp: 'IY 11/18/2022 15:34:29'!
familyPortfolioSetUp

	| angiesAccount familyPortfolio johnsAccount myAccount |
	
	johnsAccount := ReceptiveAccount name: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount name: 'Cuenta de Angeles'. 
	childrenPortfolio := Portfolio name: 'Portfolio de hijos' with: johnsAccount with: angiesAccount. 
	myAccount := ReceptiveAccount name: 'Cuenta mia'. 
	familyPortfolio := Portfolio name: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	^familyPortfolio ! !

!ReportAccountTest methodsFor: 'set up' stamp: 'JR 11/16/2022 16:22:43'!
setUpSummary

	portfolio := Portfolio name: 'portfolio'.
	account := ReceptiveAccount name: 'account'.
	deposit := Deposit register: 100 * peso on: account.
	portfolio add: account.! !

!ReportAccountTest methodsFor: 'set up' stamp: 'JR 11/16/2022 16:22:43'!
setUpTransferNet
	
	portfolio := Portfolio name: 'portfolio'.
	account := ReceptiveAccount name: 'account'.
	anAccount := ReceptiveAccount name: 'anAccount'.
	Transfer amount: 10 * peso from: account to: anAccount.
	portfolio add: account.! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'test' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'test' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'test' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'test' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'test' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'test' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'reports' stamp: 'JR 11/16/2022 20:04:21'!
name

	^ name! !

!Account methodsFor: 'reports' stamp: 'JR 11/16/2022 11:27:41'!
reportSummary: aReport 

	self subclassResponsibility ! !

!Account methodsFor: 'reports' stamp: 'JR 11/17/2022 20:59:42'!
transferNet: aReport 

	self subclassResponsibility ! !

!Account methodsFor: 'reports' stamp: 'JR 11/18/2022 15:06:13'!
treeDetailedPrinter: aReport anIndentation: anIndentation

	self subclassResponsibility ! !

!Account methodsFor: 'reports' stamp: 'JR 11/18/2022 15:06:06'!
treePrinter: aReport anIndentation: anIndentation

	self subclassResponsibility ! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!Account methodsFor: 'instance creation' stamp: 'JR 11/16/2022 16:22:43'!
name: aName

	name := aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'ServiciosFinancieros-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'JR 11/16/2022 16:22:43'!
name: aName

	^ self new name: aName! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'i 11/11/2022 20:17:29'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'reports' stamp: 'JR 11/18/2022 14:35:22'!
reportSummary: aReport
	
	accounts do: [ :anAccount | aReport reportSummary: anAccount ].! !

!Portfolio methodsFor: 'reports' stamp: 'JR 11/18/2022 14:37:10'!
transferNet: aReport
	
	accounts do: [ :anAccount | aReport transferNet: anAccount ].! !

!Portfolio methodsFor: 'reports' stamp: 'JR 11/18/2022 14:52:36'!
treeDetailedPrinter: aReport anIndentation: anIndentation

	aReport addNameOf: self anIndentation: anIndentation.
		
	accounts do: [ :anAccount | aReport treeDetailedPrinter: anAccount anIndentation: anIndentation ].
	
	aReport addBalanceOf: self anIndentation: anIndentation.! !

!Portfolio methodsFor: 'reports' stamp: 'JR 11/18/2022 14:43:19'!
treePrinter: aReport anIndentation: anIndentation
	
	aReport addNameOf: self anIndentation: anIndentation.
	
	accounts do: [ :anAccount | aReport treePrinter: anAccount anIndentation: anIndentation ].! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'JR 11/16/2022 16:22:43'!
name: aName with: anAccount 

	^(self new 
		add: anAccount;
		yourself) 		name: aName.
! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'JR 11/16/2022 16:22:43'!
name: aName with: anAccount with: anotherAccount

	^(self new 
		add: anAccount;
		add: anotherAccount;
		yourself) 		name: aName.! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'i 11/11/2022 20:15:26'!
balance

	^transactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
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


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'JR 11/18/2022 16:06:01'!
reportSummary: aReport
	
	transactions do: [ :aTransaction | aReport descriptionLine: aTransaction ].! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'JR 11/18/2022 14:37:59'!
transferNet: aReport
	
	transactions do: [ :aTransaction | aReport valueForTransferNet: aTransaction ].
		! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'JR 11/18/2022 15:04:04'!
treeDetailedPrinter: aReport anIndentation: anIndentation

	aReport addNameOf: self anIndentation: anIndentation.
		
	transactions do: [ :aTransaction | aReport descriptionLine: aTransaction anIndentation: anIndentation ].
	
	aReport addBalanceOf: self anIndentation: anIndentation.

! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'JR 11/18/2022 14:46:31'!
treePrinter: aReport anIndentation: anIndentation
	
	aReport addNameOf: self anIndentation: anIndentation.! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'JR 11/15/2022 21:13:17'!
descriptionLine: aReport

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'reports' stamp: 'JR 11/18/2022 14:58:25'!
descriptionLine: aReport anIndentation: anIndentation

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'reports' stamp: 'JR 11/16/2022 10:56:53'!
valueForTransferNet: aReport

	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'JR 11/17/2022 21:07:37'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'JR 11/16/2022 10:59:48'!
descriptionLine: aReport

	^ aReport descriptionLineForDeposit: self.! !

!Deposit methodsFor: 'reports' stamp: 'JR 11/18/2022 14:58:57'!
descriptionLine: aReport anIndentation: anIndentation

	^ aReport descriptionLineForDeposit: self anIndentation: anIndentation.! !

!Deposit methodsFor: 'reports' stamp: 'JR 11/16/2022 10:58:32'!
valueForTransferNet: aReport

	^ aReport depositValue: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'reports' stamp: 'JR 11/16/2022 10:56:53'!
valueForTransferNet: aReport

	self subclassResponsibility.! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'JR 11/17/2022 21:08:52'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'reports' stamp: 'JR 11/15/2022 21:18:35'!
descriptionLine: aReport

	^ aReport descriptionLineForDepositLeg: self.! !

!TransferDepositLeg methodsFor: 'reports' stamp: 'JR 11/18/2022 14:59:11'!
descriptionLine: aReport anIndentation: anIndentation

	^ aReport descriptionLineForDepositLeg: self anIndentation: anIndentation.! !

!TransferDepositLeg methodsFor: 'reports' stamp: 'JR 11/16/2022 10:58:47'!
valueForTransferNet: aReport

	^ aReport depositLegValue: self.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'reports' stamp: 'JR 11/15/2022 21:16:55'!
descriptionLine: aReport

	^ aReport descriptionLineForWithdrawLeg: self.! !

!TransferWithdrawLeg methodsFor: 'reports' stamp: 'JR 11/18/2022 14:59:24'!
descriptionLine: aReport anIndentation: anIndentation

	^ aReport descriptionLineForWithdrawLeg: self anIndentation: anIndentation.! !

!TransferWithdrawLeg methodsFor: 'reports' stamp: 'JR 11/16/2022 10:59:07'!
valueForTransferNet: aReport

	^ aReport withdrawLegValue: self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'JR 11/16/2022 10:59:22'!
descriptionLine: aReport

	^ aReport descriptionLineForWithdraw: self.! !

!Withdraw methodsFor: 'reports' stamp: 'JR 11/18/2022 14:59:39'!
descriptionLine: aReport anIndentation: anIndentation

	^ aReport descriptionLineForWithdraw: self anIndentation: anIndentation.! !

!Withdraw methodsFor: 'reports' stamp: 'JR 11/16/2022 10:59:16'!
valueForTransferNet: aReport

	^ aReport withdrawValue: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #PortfolioDetailedTreePrinterReport category: 'ServiciosFinancieros-Solucion'!
Object subclass: #PortfolioDetailedTreePrinterReport
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTreePrinterReport methodsFor: 'instance creation' stamp: 'JR 11/18/2022 16:31:24'!
reportFor: aPortfolio
	
	report := OrderedCollection new.
	
	aPortfolio treeDetailedPrinter: self anIndentation: self nullIndentation.

	^ report.! !


!PortfolioDetailedTreePrinterReport methodsFor: 'operations' stamp: 'JR 11/18/2022 17:27:47'!
aNewIndentationLevel

	^ '    '.! !

!PortfolioDetailedTreePrinterReport methodsFor: 'operations' stamp: 'JR 11/18/2022 17:30:28'!
add: anElement

	report add: anElement.! !

!PortfolioDetailedTreePrinterReport methodsFor: 'operations' stamp: 'JR 11/18/2022 14:53:48'!
addBalanceOf: anAccount anIndentation: anIndentation

	self add: anIndentation, self aNewIndentationLevel, 'Balance = ', anAccount balance asString.
! !

!PortfolioDetailedTreePrinterReport methodsFor: 'operations' stamp: 'JR 11/18/2022 17:32:42'!
addNameOf: anAccount anIndentation: anIndentation

	self add: anIndentation, anAccount name asString.
! !

!PortfolioDetailedTreePrinterReport methodsFor: 'operations' stamp: 'JR 11/18/2022 17:28:51'!
nullIndentation

	^ ''.! !

!PortfolioDetailedTreePrinterReport methodsFor: 'operations' stamp: 'JR 11/18/2022 14:51:27'!
treeDetailedPrinter: anAccount anIndentation: anIndentation

	anAccount treeDetailedPrinter: self anIndentation: self aNewIndentationLevel, anIndentation.! !


!PortfolioDetailedTreePrinterReport methodsFor: 'description line' stamp: 'JR 11/18/2022 14:57:44'!
descriptionLine: aTransaction anIndentation: anIndentation

	aTransaction descriptionLine: self anIndentation: anIndentation, self aNewIndentationLevel.! !

!PortfolioDetailedTreePrinterReport methodsFor: 'description line' stamp: 'JR 11/18/2022 15:03:23'!
descriptionLineForDeposit: aDeposit anIndentation: anIndentation

	self add: anIndentation, 'Deposit of ', aDeposit value asString.! !

!PortfolioDetailedTreePrinterReport methodsFor: 'description line' stamp: 'JR 11/18/2022 15:02:47'!
descriptionLineForDepositLeg: aDepositLeg anIndentation: anIndentation

	self add: anIndentation, 'Transfer deposit of ', aDepositLeg value asString.! !

!PortfolioDetailedTreePrinterReport methodsFor: 'description line' stamp: 'JR 11/18/2022 15:03:06'!
descriptionLineForWithdraw: aWithdraw anIndentation: anIndentation

	self add: anIndentation, 'Withdraw of ', aWithdraw value asString.! !

!PortfolioDetailedTreePrinterReport methodsFor: 'description line' stamp: 'JR 11/18/2022 15:01:56'!
descriptionLineForWithdrawLeg: aWithdrawLeg anIndentation: anIndentation

	self add: anIndentation, 'Transfer withdraw of ', aWithdrawLeg value asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioDetailedTreePrinterReport class' category: 'ServiciosFinancieros-Solucion'!
PortfolioDetailedTreePrinterReport class
	instanceVariableNames: ''!

!PortfolioDetailedTreePrinterReport class methodsFor: 'as yet unclassified' stamp: 'JR 11/18/2022 17:29:53'!
generateFor: anAccount

	^ self new reportFor: anAccount.! !


!classDefinition: #PortfolioTreePrinterReport category: 'ServiciosFinancieros-Solucion'!
Object subclass: #PortfolioTreePrinterReport
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinterReport methodsFor: 'instance creation' stamp: 'JR 11/18/2022 17:28:21'!
reportFor: aPortfolio
	
	report := OrderedCollection new.
	
	aPortfolio treePrinter: self anIndentation: self nullIndentation.

	^ report.! !


!PortfolioTreePrinterReport methodsFor: 'operations' stamp: 'JR 11/18/2022 14:39:40'!
aNewIndentationLevel

	^ '    '.! !

!PortfolioTreePrinterReport methodsFor: 'operations' stamp: 'JR 11/18/2022 17:30:23'!
add: anElement

	report add: anElement.! !

!PortfolioTreePrinterReport methodsFor: 'operations' stamp: 'JR 11/18/2022 14:42:45'!
addNameOf: anAccount anIndentation: anIndentation

	self add: anIndentation, anAccount name asString.
! !

!PortfolioTreePrinterReport methodsFor: 'operations' stamp: 'JR 11/18/2022 17:28:46'!
nullIndentation

	^ ''.! !

!PortfolioTreePrinterReport methodsFor: 'operations' stamp: 'JR 11/18/2022 14:44:03'!
treePrinter: anAccount anIndentation: anIndentation

	anAccount treePrinter: self anIndentation: anIndentation, self aNewIndentationLevel.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinterReport class' category: 'ServiciosFinancieros-Solucion'!
PortfolioTreePrinterReport class
	instanceVariableNames: ''!

!PortfolioTreePrinterReport class methodsFor: 'instance creation' stamp: 'JR 11/18/2022 17:29:45'!
generateFor: anAccount

	^ self new reportFor: anAccount.! !


!classDefinition: #ReportAccount category: 'ServiciosFinancieros-Solucion'!
Object subclass: #ReportAccount
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReportAccount methodsFor: 'instance creation' stamp: 'JR 11/14/2022 07:41:55'!
reportFor: anAccount

	self subclassResponsibility.! !


!ReportAccount methodsFor: 'description line' stamp: 'JR 11/18/2022 16:16:43'!
descriptionLineForDeposit: aDeposit anIndentation: anIndentation

	self add: anIndentation, 'Deposit of ', aDeposit value asString.! !

!ReportAccount methodsFor: 'description line' stamp: 'JR 11/18/2022 16:17:03'!
descriptionLineForDepositLeg: aDepositLeg anIndentation: anIndentation

	self add: anIndentation, 'Transfer deposit of ', aDepositLeg value asString.! !

!ReportAccount methodsFor: 'description line' stamp: 'JR 11/18/2022 16:17:13'!
descriptionLineForWithdraw: aWithdraw anIndentation: anIndentation

	self add: anIndentation, 'Withdraw of ', aWithdraw value asString.! !

!ReportAccount methodsFor: 'description line' stamp: 'JR 11/18/2022 16:17:24'!
descriptionLineForWithdrawLeg: aWithdrawLeg anIndentation: anIndentation

	self add: anIndentation, 'Transfer withdraw of ', aWithdrawLeg value asString.! !


!ReportAccount methodsFor: 'operations' stamp: 'JR 11/17/2022 20:45:40'!
add: anElement

	report add: anElement.! !

!ReportAccount methodsFor: 'operations' stamp: 'JR 11/18/2022 16:30:31'!
nullIndentation

	^ ''.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReportAccount class' category: 'ServiciosFinancieros-Solucion'!
ReportAccount class
	instanceVariableNames: ''!

!ReportAccount class methodsFor: 'instance creation' stamp: 'JR 11/14/2022 07:41:27'!
generateFor: anAccount

	^ self new reportFor: anAccount.! !


!classDefinition: #SummaryReport category: 'ServiciosFinancieros-Solucion'!
Object subclass: #SummaryReport
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!SummaryReport methodsFor: 'operations' stamp: 'JR 11/18/2022 14:35:45'!
reportSummary: anAccount

	anAccount reportSummary: self.! !


!SummaryReport methodsFor: 'instance creation' stamp: 'JR 11/18/2022 16:29:50'!
reportFor: anAccount
	
	report := OrderedCollection new.	
	
	self reportSummary: anAccount.
		
	self add: 'Balance = ', anAccount balance asString.
	
	^ report.! !


!SummaryReport methodsFor: 'description line' stamp: 'JR 11/18/2022 17:26:12'!
add: anElement

	report add: anElement.! !

!SummaryReport methodsFor: 'description line' stamp: 'JR 11/18/2022 17:29:08'!
descriptionLine: aTransaction

	aTransaction descriptionLine: self.! !

!SummaryReport methodsFor: 'description line' stamp: 'JR 11/17/2022 20:47:21'!
descriptionLineForDeposit: aDeposit.

	self add: 'Deposit of ', aDeposit value asString.! !

!SummaryReport methodsFor: 'description line' stamp: 'JR 11/17/2022 20:47:10'!
descriptionLineForDepositLeg: aDepositLeg.

	self add: 'Transfer deposit of ', aDepositLeg value asString.! !

!SummaryReport methodsFor: 'description line' stamp: 'JR 11/17/2022 20:47:15'!
descriptionLineForWithdraw: aWithdraw.

	self add: 'Withdraw of ', aWithdraw value asString.! !

!SummaryReport methodsFor: 'description line' stamp: 'JR 11/17/2022 20:47:01'!
descriptionLineForWithdrawLeg: aWithdrawLeg.

	self add: 'Transfer withdraw of ', aWithdrawLeg value asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SummaryReport class' category: 'ServiciosFinancieros-Solucion'!
SummaryReport class
	instanceVariableNames: ''!

!SummaryReport class methodsFor: 'instance creation' stamp: 'JR 11/18/2022 17:29:26'!
generateFor: anAccount

	^ self new reportFor: anAccount.! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !


!classDefinition: #TransferNetReport category: 'ServiciosFinancieros-Solucion'!
Object subclass: #TransferNetReport
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNetReport methodsFor: 'operations' stamp: 'JR 11/17/2022 21:06:46'!
add: aValue

	report := report + aValue.! !

!TransferNetReport methodsFor: 'operations' stamp: 'JR 11/18/2022 14:37:29'!
transferNet: anAccount

	anAccount transferNet: self.! !


!TransferNetReport methodsFor: 'value transfer net' stamp: 'JR 11/17/2022 21:06:23'!
depositLegValue: aDepositLeg

	self add: aDepositLeg value.! !

!TransferNetReport methodsFor: 'value transfer net' stamp: 'JR 11/17/2022 21:06:24'!
depositValue: aDeposit

	self add: self noAffectValue.! !

!TransferNetReport methodsFor: 'value transfer net' stamp: 'JR 11/16/2022 11:02:36'!
noAffectValue

	^ 0 * peso.! !

!TransferNetReport methodsFor: 'value transfer net' stamp: 'JR 11/18/2022 14:38:14'!
valueForTransferNet: aTransaction

	aTransaction valueForTransferNet: self.! !

!TransferNetReport methodsFor: 'value transfer net' stamp: 'JR 11/17/2022 21:06:23'!
withdrawLegValue: aWithdrawLeg

	self add: aWithdrawLeg value negated.! !

!TransferNetReport methodsFor: 'value transfer net' stamp: 'JR 11/17/2022 21:06:23'!
withdrawValue: aWithdraw

	self add: self noAffectValue.! !


!TransferNetReport methodsFor: 'instance creation' stamp: 'JR 11/18/2022 16:29:21'!
reportFor: anAccount

	report := 0 * peso.
		
	self transferNet: anAccount.
	
	^ report.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetReport class' category: 'ServiciosFinancieros-Solucion'!
TransferNetReport class
	instanceVariableNames: 'report'!

!TransferNetReport class methodsFor: 'instance creation' stamp: 'JR 11/18/2022 17:32:00'!
generateFor: anAccount

	^ self new reportFor: anAccount.! !
