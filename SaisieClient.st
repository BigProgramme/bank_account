'From Pharo11.0.0 of 31 October 2023 [Build information: Pharo-11.0.0+build.714.sha.0ead11d0b8573ff685db8a39fceeca2a8d528d3e (64 Bit)] on 11 December 2023 at 4:33:12.104 pm'!
SpPresenter subclass: #SaisieClient
	instanceVariableNames: 'champNom champPrenom champAdresse champAdresseMail champTel boutonOuvrir boutonAnnuler'
	classVariableNames: ''
	package: 'projet_application_gestion'!

!SaisieClient methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 12/3/2023 21:01'!
boutonOuvrirAction

"/!!\ Methode importante. tout ce qui vient après cette ligne va s'effectuer après avoir cliqué sur le boutonOuvrir."
	|fenetreSaisieClient fenetreCompte nouveauClient nouveauClientCompte | "je définis 4 var."
	
"Obligation de tout remplir:"
	((((((champNom text asString trim isEmpty) "je vérifie que tous les champs sont remplis et pas vide."
	or: (champPrenom text asString trim isEmpty))
	or: (champAdresseMail text asString trim isEmpty))
	or: (champAdresse text asString trim isEmpty))
	or: (champTel text asString trim isEmpty))
		ifTrue: [ self inform: 'Tous les champs doivent être remplis!!'. ^self ]). "Si un des champs est vide, on informe et on renvoie l'objet tel qu'il est pour remplir tous les champs."

	
	
	nouveauClient := Client new. "Le nouveau client n'est rien d'autre qu'une instance de la classe Client."
	nouveauClient definirNom: champNom text. "On lui définit un Nom, en récupérant juste le text entré dans le champ Nom."
	nouveauClient definirPrenom: champPrenom text. "........................................."
	nouveauClient definirAdresse: champAdresse text. "............................."
	nouveauClient definirAdresseMail: champAdresseMail text. "......................."
	nouveauClient definirNumeroDeTelephone: champTel text. "........................."
	
	nouveauClientCompte := CompteBancaire new. "Un client doit avoir un CompteBancaire, voilà pourquoi on donne à ce client un compte."
	nouveauClientCompte titulaireCompte: nouveauClient. "Et ce compte aura pour titulaire un client. Titulaire est la methode existant dans la classe CompteBAncaire."
	
	
	fenetreSaisieClient := self window. "je stock la fenetre dans une variable pour pourvoir la manipuler... "
	
	self chargementBarre. "je fais apparaitre la barre de chargement pour la beauté et l'impression
	Une fois que c'est chargé à 100%..."
	
	fenetreSaisieClient close. "... On ferme la fenetre de SaisieClient pour..."
	
	
	"...Initailisation de la fenetre dans laquelle on affichera les infos du compte et tout"
	fenetreCompte := AffichageCompte new
		initializeWithAclient: nouveauClient; "Et là on initialize avec le cient qu'on a créé juste en haut."
		
		initializeWithACompte: nouveauClientCompte;  "et avec le compte bancaire du client ."
		
			
	 open. "et Donc on ouvre la fenetre du compte."
	! !

!SaisieClient methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/14/2023 17:14'!
chargementBarre
	
	| job |

	job := SpJob newBlock: [ :aJob |
		aJob title: 'Ouverture en cours'.
		aJob min: 1; max: 100.
		1 to: 100 do: [ :i | 
			aJob title: ('chargement {1}/100 %' format: {i}).
			aJob value: i. 
			10 milliSeconds wait ] ].

	SpJobPresenter new
		model: job;
		run! !

!SaisieClient methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/22/2023 08:07'!
layout
|w  |

	w := self window.
	w extent: 700@400.
	w title: 'Enregistrement Client'.
	
	
	^ SpGridLayout new
	
		add: 'Nom* : ' at: 1 @ 1;
		add: champNom  at: 2 @ 1 span: 1 @ 1;
		
		add: 'Prénom* : ' at: 1 @ 2;
		add: champPrenom at: 2 @ 2 span: 1 @ 1;
		
		add: 'Adresse* : ' at: 1 @ 3;
		add: champAdresse at: 2 @ 3 span: 2 @ 1;
		
		add: 'Adresse Mail* : ' at: 1 @ 4;
		add: champAdresseMail at: 2 @ 4 span: 2 @ 1;
		
		add: 'Tel* : ' at: 1 @ 5;
		add: champTel at: 2 @ 5 span: 2 @ 1;
		
		add:  boutonOuvrir at:2 @ 30 span: 1@1;
		add:  boutonAnnuler  at:3 @ 30 span: 1@1;
		beColumnHomogeneous;
		
		
		yourself.! !


!SaisieClient methodsFor: 'initialization' stamp: 'SaintHeraud 12/3/2023 23:20'!
definitionDesObjets
	"Dans cette méthode, je définis les objets, mes boutons et mes champs."
	boutonOuvrir := SpButtonPresenter new
		label: 'Valider';
		color: Color green;
		action: [ self boutonOuvrirAction ].
	boutonAnnuler  := SpButtonPresenter new
		label: 'Annuler';
		color: Color red;
		action: [ self boutonAnnulerAction ].
		
		
	champNom := self newTextInput
		placeholder: 'Votre nom';
		yourself.
	champPrenom := self newTextInput
		placeholder: 'Votre prénom';
		yourself.
	champAdresseMail := self newTextInput
		placeholder: 'Votre adresse Mail';
		yourself.
	champTel := self newTextInput
		placeholder: 'Votre Numéro de téléphone';
		yourself.
	champAdresse := self newTextInput
		placeholder: 'Votre Adresse';
		yourself.
	! !


!SaisieClient methodsFor: 'accessing' stamp: 'SaintHeraud 11/13/2023 10:52'!
champPrenom
	^champPrenom.
	! !

!SaisieClient methodsFor: 'accessing' stamp: 'SaintHeraud 11/18/2023 10:18'!
champAdresseMail
	^champAdresseMail.
	"accesseur"! !

!SaisieClient methodsFor: 'accessing' stamp: 'SaintHeraud 11/13/2023 10:53'!
champTel
	^champTel.
	! !

!SaisieClient methodsFor: 'accessing' stamp: 'SaintHeraud 11/18/2023 10:11'!
boutonAnnuler
	^boutonAnnuler
	
"accesseur"! !

!SaisieClient methodsFor: 'accessing' stamp: 'SaintHeraud 12/3/2023 20:59'!
boutonAnnulerAction
	self window close.
	
"On ferme juste la fenetre."
"Ce bouton permet juste de fermer l'application lorsqu'il est appuyé."! !

!SaisieClient methodsFor: 'accessing' stamp: 'SaintHeraud 11/18/2023 10:11'!
champAdresse
	^champAdresse.
	"accesseur"! !

!SaisieClient methodsFor: 'accessing' stamp: 'SaintHeraud 11/13/2023 10:52'!
champNom
	^champNom.
	! !

!SaisieClient methodsFor: 'accessing' stamp: 'SaintHeraud 11/13/2023 11:38'!
boutonOuvrir
	^boutonOuvrir.! !
