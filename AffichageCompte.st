'From Pharo11.0.0 of 31 October 2023 [Build information: Pharo-11.0.0+build.714.sha.0ead11d0b8573ff685db8a39fceeca2a8d528d3e (64 Bit)] on 11 December 2023 at 4:30:15.765 pm'!
SpPresenter subclass: #AffichageCompte
	instanceVariableNames: 'compte client compteLabel champAjouter champRetirer soldeLabel tableauHistorique boutonAjouter boutonRetirer boutonDeconnecter boutonViderHistorique'
	classVariableNames: ''
	package: 'projet_application_gestion'!

!AffichageCompte methodsFor: 'accessing' stamp: 'SaintHeraud 12/3/2023 20:36'!
layout
| w|

	
"le layout ici est pour le placement des objets dans notre UI."
	 "Je definis une variable pour récuperer la fenetre de l'UI"
	w  := self window.
	w title: 'Compte bancaire'. "Je lui donne un titre"
	w extent: 900@600. "Une taille"
	w borderColor:  Color blue . "qui ne fonctionne pas :) "
	
	^ SpGridLayout new "Et je créé une grille pour faciliter le placement des éléments.pour faire court--> explication en une ligne-->   add: elementAPlacer at: num_colonne @ num_ligne."
	"et donc j'ajoute tous les éléments essentiels à mon interface."
		add: soldeLabel  at: 2@7; 
		
		add: compteLabel at: 2@5;
		
		add: champAjouter at: 1@20;
		add: boutonAjouter at: 2@20;
		
		add: champRetirer at: 1@25;
		add: boutonRetirer at: 2@25;
		
		add: 'Historique des transactions' at: 3@19;
		add: tableauHistorique at: 3@20 span: 1@2000; "le span permet de definir la taille de l'objet."
		
		add: boutonViderHistorique at: 3@32;
		
		add: boutonDeconnecter at: 2@50
		! !


!AffichageCompte methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/14/2023 17:00'!
tableauHistorique
	^tableauHistorique.! !

!AffichageCompte methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/18/2023 09:21'!
boutonRetirer
	^boutonRetirer.
	
"accesseur du bouton".! !

!AffichageCompte methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 12/3/2023 20:32'!
initializeWithAclient: unClient
"Methode importante, le parametre passé doit avoir la ref de l'objet client"
	client := unClient. "initialisation de l'attribut client"
	
	compteLabel := self newLabel "le compteLabel est l'endroit où sera affiché les nom et prénom du client."
		label: 'Bonjour ',  client retournerPrenom, ' ', client retournerNom. "retounerPrenom et retournerNom sont des méthodes de la classe Client"
		
	boutonViderHistorique := self newButton "petit bouton pour vider l'historique"
		label: 'Vider historique';
		color: Color orange ;
		
		action: [ self boutonViderHistoriqueAction ].
		
		
	boutonAjouter := self newButton "Bouton ajouter"
		label: 'Déposer +';
		
		action: [ self boutonAjouterAction  ]. "Qui fera l'action de la methode boutonAjouterAction"
		
	champAjouter := self newTextInput "Un champ pour rentrer le texte"
		placeholder: 'Taper le montant à ajouter'; "avec cette valeur comme placeholder pour aider l'utilisateur à mieux omprendre l'interface."
		yourself.
	
	boutonRetirer := self newButton 
		label: 'Retirer -';
		action: [ self boutonRetirerAction  ]. "Pareil que le bouton ajouter mais ici c'est pour retirer et on utilise la methode boutonRetirerAction"
		
	champRetirer := self newTextInput
		placeholder: 'Taper le montant à retirer' "...."
		yourself.
		
	boutonDeconnecter := self newButton
		label: 'Déconnexion';
		color: Color red;
		action: [ self boutonDeconnecterAction  ]. "same thing.... mais avec la méthode d'action du bouton déconnecter."
		! !

!AffichageCompte methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 12/3/2023 20:30'!
initializeWithACompte: unCompte
"Tres importante methode, le parametre passé doit avoir la ref de l'objet CompteBancaire"
"Elle permet d'accéder au Compte, donc d'avoir la possibilité de récupérer ces infos."
	compte := unCompte. "J'initailise l'attribut compte"
	
	soldeLabel := self newLabel "Le solde label c'est le label où sera affihé le solde du compte."
		label: 'Votre solde: ', compte initializeSolde retournerSolde printString, ' €'. "en label, on reprend le compte qu'on lui soumet à la méthode initializeSolde que j'avais créé dans la classe CompteBance, cette méthode permet de mettre le solde à 0, cf cette méthode pour mieux comprendre, puis je retourne le solde. retournerSolde est un getter de la classe CompteBAncaire aussi."
		
	tableauHistorique := self newList "j'iniralise aussi l'attribut tableauHistorique en une liste."
			items: compte historiqueTransaction asArray; "et comme contenus de la liste, j'applique au compte la méthode historiqueTransaction de la Classe CompteBancaire qui ne fait autre que que retourner la collection qui contient toutes les transactions. en faisant asArray , on récupère que les éléments de la collection , pas la collection elle même."
			yourself.
    		
! !

!AffichageCompte methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/17/2023 21:12'!
solde
	^soldeLabel.! !

!AffichageCompte methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/22/2023 21:19'!
validateNumber: unString
	^unString isAllDigits  "isAllDigits pour des chiffres compris entre 0 et 9."
  

"cette méthode permet de vérifier si les valeur rentrées sont corrects.
ça renvoie un boolean"
! !

!AffichageCompte methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/22/2023 21:35'!
boutonRetirerAction
    | montant |
    montant := champRetirer text.

    (self validateNumber: montant) ifTrue: [
        "Conversion en nombre uniquement si c'est un nombre valide(doonc tous les chiffres sont compris entre 0 et 9"
        montant := montant asNumber. "On converti le montant en nbre"
        compte retrait: montant. "on applique le modificateur retrait: pour de la classe CompteBancaire"

        "Mise à jour de l'interface utilisateur"
        soldeLabel label:
            'Votre solde: ', compte retournerSolde printString, ' €'.

        champRetirer text: ''. "Je vide le champ"

        tableauHistorique 
            items: compte historiqueTransaction reverse asArray.
            "La méthode reverse permet d'afficher les transactions de la plus récente à la plus ancienne."
    ] ifFalse: [ 
        self inform: 'Entrez un montant correct pour faire un retrait!!' "Si le montant n'est pas valide , je l'informe."
    ].
! !

!AffichageCompte methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/14/2023 16:59'!
champRetirer
	^champRetirer! !

!AffichageCompte methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/14/2023 16:59'!
compteLabel 
	^compteLabel.! !

!AffichageCompte methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/22/2023 21:25'!
boutonAjouterAction
"Un bouton doit avoir une action."
"Une fois que l'on clique sur ce bouton, voici ce qui se passera:"
	| montant | "Je créé une variable montant"
        montant := champAjouter text .  "Cette variable va juste récupérer la valeur saisie dans le champs ajouter puis le convertir en nombre"

			(self validateNumber: montant ) ifTrue: [  	
					montant := montant asNumber.		
        compte depot: montant . "et on applique la méthode depot: de la classe CompteBancaire pour effectuer le depot du montant sur le compte"
        
		  "Mise à jour de l'interface"
        soldeLabel label: 'Votre solde: ', compte retournerSolde printString, ' €' . "Une fois le depot effectué, on actualise le label où sera affiché le montant du compte"
			
			champAjouter text: ''. "Ensuite je vide le champ de saisie"
			
			tableauHistorique 
				items: compte historiqueTransaction reverse asArray .]"et je mets à jour la liste de transaction. NB: la méthode depot: permet d'ajouter la transaction dans une historique. cf CompteBancaire>>depot: la méthode reverse me permet d'afficher les transactions de la plus récentes à la plus ancienne"
			ifFalse:  [ self inform: 'Entrez un montant correct avant de faire un dépôt!!' ].
				
		! !

!AffichageCompte methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 12/3/2023 20:29'!
boutonViderHistoriqueAction
"Cette méthode permet de vider l'historique de transaction du Compte Bancaire"

|confirmation| "je créé une variable confirmation"

(compte historiqueTransaction isEmpty)"je vérifie si l'historique est déjà vide" ifTrue:[self inform: ' Historique déjà vide!!  ' "si c'est le cas, j'informe"]
ifFalse:
	[confirmation := SpConfirmDialog new "qui va avec l'instance d'une fenetre de dialoge de confirmation"
	
		title: 'Vider Historique'; "je lui donne un titre "
		label: 'Vous voulez supprimer toute historique?'; "un label"
		acceptLabel: 'Oui!!'; "Deux options, oui et non"
		cancelLabel: 'Non !!';
		label: 'Vous êtes sûr?'; 
		
		onAccept: [compte historiqueTransaction removeAll "On supprime tout de la collection". 		tableauHistorique 
				items: compte historiqueTransaction reverse asArray "Et je met à jour l'historique". 
				self inform: 'Historique supprimée!!' ]; 
		onCancel: [ self inform: 'OK' ]; "Si la personne clique sur Non, on informe juste sans rien supprimer"
		openDialog ]."et bien évidemment faut ouvrir la boite de dialoge."
	
! !

!AffichageCompte methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/14/2023 16:59'!
champAjouter
	^champAjouter.! !

!AffichageCompte methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/18/2023 09:29'!
chargementBarre
"Une barre de chargement qui va apparaître sur les étapes..."
"elle est fournit par le frameWork Spec2, j'ai juste apporté quelques modifications selon mes besoins."
	
	| job | "On déf une variable."

	job := SpJob newBlock: [ :aJob |
		aJob title: 'Déconnection en coours'. "Un titre"
		aJob min: 1; max: 100. "Valeur de charment comprise entre 1 et 100"
		1 to: 100 do: [ :i |  "Je fais un parcours de 1 à 100"
			aJob title: ('Déconnection en cours {1}/100 %' format: {i}). "puis à chaque itteration, je lui ai donné le même titre mais en faisant évoluer les valeurs de chargement, jusqu'à 100/100%"
			aJob value: i. 
			10 milliSeconds wait ] ]. "Tout celà doit se réaliser en 10milisecondes. "

	SpJobPresenter new "on créé un SpJobPresent en lui donnant comme model notre JOB qu'on a créé et on le fais courir(:"
		model: job;
		run! !

!AffichageCompte methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/18/2023 09:08'!
boutonAjouter
	^boutonAjouter.
	
"Getter ou accesseur du bouton"! !

!AffichageCompte methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/18/2023 09:09'!
boutonDeconnecter
	^boutonDeconnecter
	"Getter ou accesseur du bouton"! !

!AffichageCompte methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 11/18/2023 09:18'!
boutonDeconnecterAction

"Action à faire une fois que l'on clique sur le bouton déconnecter."
	|confirmation| "je créé une variable confirmation"
	confirmation := SpConfirmDialog new "qui va avec l'instance d'une fenetre de dialoge de confirmation"
	
		title: 'Déconnection'; "je lui donne un titre "
		label: 'Vous voulez vous déconnecter?'; "un label"
		acceptLabel: 'Oui!!'; "Deux options, oui et non"
		cancelLabel: 'Non !!';
		label: 'Vous êtes sûr?'; 
		onAccept: [self chargementBarre. self window close. self inform: 'Vous êtes Déconnectés!!' ]; "Quand la personne accepte en cliquant sur 
																						oui: je fais apparaitre la barre de chargement, je ferme la fenetre une fois que c'est à 100% chargé puis j'informe "
		onCancel: [ self inform: 'OK' ]; "Si la personne clique sur Non, on informe juste sans se déconnecter."
		openDialog "et bien évidemment faut ouvrir la boite de dialoge."
	! !
