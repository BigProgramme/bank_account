'From Pharo11.0.0 of 31 October 2023 [Build information: Pharo-11.0.0+build.714.sha.0ead11d0b8573ff685db8a39fceeca2a8d528d3e (64 Bit)] on 11 December 2023 at 4:33:26.8 pm'!
Object subclass: #JeuEssaie
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'projet_application_gestion'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

JeuEssaie class
	instanceVariableNames: ''!

!JeuEssaie class methodsFor: 'as yet unclassified' stamp: 'SaintHeraud 12/3/2023 20:52'!
lanceApplication
	|monApplication|
	"méthode de classe permettant de lancer l'application."
	monApplication := SaisieClient new
		.
	monApplication open. "En Ouvre l'application "! !
