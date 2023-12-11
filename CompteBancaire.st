'From Pharo11.0.0 of 31 October 2023 [Build information: Pharo-11.0.0+build.714.sha.0ead11d0b8573ff685db8a39fceeca2a8d528d3e (64 Bit)] on 11 December 2023 at 4:32:49.568 pm'!
Object subclass: #CompteBancaire
	instanceVariableNames: 'titulaire solde contientDesTransactions numeroDeCompte'
	classVariableNames: ''
	package: 'projet_application_gestion'!

!CompteBancaire methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/12/2023 21:33'!
historiqueTransaction
"On retourne ici l'historique de nos transactions, qui n'est autre chose que notre ordercollection dans initialize"
	^contientDesTransactions.! !

!CompteBancaire methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/12/2023 21:57'!
retournerTitulaire
	"accéder aux informations du titulaire de compte"
	"Le titulaire n'est rien d'autre que notre client, une relation s'annonce donc"
	
	^titulaire.! !

!CompteBancaire methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 12/3/2023 20:37'!
depot: montant
	
	"Je créé 3 variables pour mieux afficher les transactions dans notre historique"
	| descriptionTransaction depotMontantNul depotMontantNegatif date |
	
	date := (DateAndTime now) asString. "Il faut une date et une heure de la transaction"
	
	descriptionTransaction := date, ' --> Dépôt de: ' , montant printString, '€' . "le message qui sera affiché si le dépôt est effectué"
	
	depotMontantNul := date, ' --> Echec de dépôt car montant nul' printString. "le message qui sera affiché si le dépôt n'est pas effectué/ si le client essaie de déposer un montant nul"
	
	depotMontantNegatif := date, '  --> Echec de dépôt car montant négatif' printString. "le message qui sera affiché si le dépôt n'est pas effectué car le client aurait essayé de déposer un montant négatif"

		                       
	montant = 0 ifTrue: [
		self historiqueTransaction add: depotMontantNul ]. "Je vérifie juste si le montant est nul, si c'est nul, on renvoie un échec dans l'historique car on ne peut pas add 0€ en banque."
	montant < 0 ifTrue: [
		self historiqueTransaction add: depotMontantNegatif ]. "Pareil, on ne peut pas ajouter un montant négatif"
	
	montant > 0 ifFalse: [^self ]. "et là si le montant n'est pas >0, on renvoit l'instance de l'objet lui-même pour arrêter le code à ce niveau. "
	solde := solde + montant. "et si le montant est >0 bah là on rajoute à la somme de départ"
	self historiqueTransaction add: descriptionTransaction.! !

!CompteBancaire methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/18/2023 09:58'!
definirNumeroDeCompte: unNumeroDeCompte
	numeroDeCompte := unNumeroDeCompte.
	
"Modificateur du numéro de compte"! !

!CompteBancaire methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/12/2023 21:50'!
retournerNomDuTitulaire
"On va juste retourner le nom du client depuis le compte Bancaire, pour éviter des long code.
sachant que retournerTitulaire nous renvoie aClient et que la méthode retournerNom est dans la classe Client, bah là on prend directement son nom."
	^ (self retournerTitulaire ) retournerNom.! !

!CompteBancaire methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 12/3/2023 20:46'!
retrait: montant
   "Cette méthode effectue un retrait"
   |soldeApresRetrait descriptionTransaction retraitNonEffectue retraitMontantNul retraitMontantNégatif date|
   date := (DateAndTime now) asString.  "Date pour la meilleure traçabilité."

   descriptionTransaction := date, '  -->  Retrait de: ', montant printString, '€'. "On décrit  la transaction dans notre historiqueTransaction si le retrait est effectué."

	retraitNonEffectue := date , '   --> Echec de retrait, solde compte insuffisant' printString. "..."
	
	retraitMontantNul := date, ' --> Echec de retrait car montant nul' printString.
	
	retraitMontantNégatif := date, '  --> Echec de retrait car montant négatif' printString.

	"On stocke la différence entre le solde initial et le montant du retrait dans la variable soldeApresRetrait pour vérification"
   soldeApresRetrait := solde - montant. 

   
	(montant = 0) ifTrue: [ self historiqueTransaction add: retraitMontantNul . ^self ]. "Si le montant est nul, le retrait ne va pas s'effectuer et il y aura un message d'erreur dans l'historique."
	
	(montant < 0) ifTrue: [ self historiqueTransaction add: retraitMontantNégatif. ^self ]. "Si le montant est négatif, message d'erreur..."
	
	"/!!\ /!!\ On n'autorise pas de découvert dans notre banque."
   "On doit donc vérifier que le compte ne soit pas à un solde négatif après le retrait."
   (soldeApresRetrait >= 0 ) ifTrue: [
      "Le retrait est autorisé."
      solde := soldeApresRetrait. "comme le retrait est autorié, le solde sera égal au solde après retrait"
      (self historiqueTransaction) add: descriptionTransaction. "Et bien évidemment il nous faut des traces de nos transactions."
   ].

	(soldeApresRetrait  < 0) ifTrue: [ (self historiqueTransaction) add: retraitNonEffectue. ]
					
      "Le retrait est refusé car le solde serait négatif."
      "On affiche donc dans l'historique qu'il y a eu echec de retrait...)."
   
! !

!CompteBancaire methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/12/2023 21:51'!
retournerPrenomDuTitulaire
"On va juste retourner le prenom du client depuis le compte Bancaire, pour éviter des longs codes.
sachant que retournerTitulaire nous renvoie aClient et que la méthode retournerPrenom  est dans la classe Client, bah là on prend directement son prenom."
	^ (self retournerTitulaire ) retournerPrenom.! !

!CompteBancaire methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/12/2023 21:34'!
titulaireCompte: unClient
	titulaire := unClient
	
"Le titulaire n'est rien d'autre qu'un client"! !

!CompteBancaire methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/18/2023 10:00'!
retournerNumeroDeCompte
	^numeroDeCompte.
"accesseur du num de Compte."! !

!CompteBancaire methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/12/2023 21:33'!
initialize 

	"On créé une collection qui va contenir toutes nos transactions"
	contientDesTransactions := OrderedCollection new.
	! !

!CompteBancaire methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/18/2023 10:01'!
retournerSolde
	^solde.

"Accesseur du solde."! !

!CompteBancaire methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/18/2023 10:00'!
initializeSolde
"Quand on ouvre un compte à la banque, son solde est nul, le client pourra décider de faire un 1er dépôt ou pas, voilà pourquoi j'initialise le solde à zéro."
	solde := 0.! !
