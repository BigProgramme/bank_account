'From Pharo11.0.0 of 31 October 2023 [Build information: Pharo-11.0.0+build.714.sha.0ead11d0b8573ff685db8a39fceeca2a8d528d3e (64 Bit)] on 11 December 2023 at 4:32:23.151 pm'!
Object subclass: #Client
	instanceVariableNames: 'nom prenom adresse numeroDeTelephone adresseMail'
	classVariableNames: ''
	package: 'projet_application_gestion'!

!Client methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/12/2023 21:30'!
retournerNom
	"ceci est un getter/accesseur de l'attribut client "
	^nom.! !

!Client methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/12/2023 21:30'!
retournerAdresse
	"ceci est un getter/accesseur de l'attribut adresse du  client "
	^adresse.! !

!Client methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/12/2023 21:30'!
retournerAdresseMail
	"ceci est un getter/accesseur de l'attribut adresseMail du  client "
	^adresseMail.! !

!Client methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/18/2023 09:52'!
definirNom: unNom
	nom := unNom.
	
"modificateur du nom"! !

!Client methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/12/2023 21:30'!
retournerNumeroDeTelephone
	"ceci est un getter/accesseur de l'attribut numeroDeTelephone du  client "
	^numeroDeTelephone.! !

!Client methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/18/2023 09:53'!
retournerPrenom
"acesseur du prenom."
	^prenom.! !

!Client methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/18/2023 09:52'!
definirNumeroDeTelephone: unNumeroDeTelephone
	numeroDeTelephone := unNumeroDeTelephone.
	
"modificateur du numero de tel"! !

!Client methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/18/2023 09:51'!
definirAdresseMail: uneAdresseMail
	adresseMail := uneAdresseMail.
	
"modificateur de l'adresse mail"! !

!Client methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/18/2023 09:51'!
definirAdresse: uneAdresse
	adresse := uneAdresse.
	
"modificateur de l'attribut adresse"! !

!Client methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/18/2023 09:52'!
definirPrenom: unPrenom
	prenom := unPrenom.
	"modificateur du prénom."! !
