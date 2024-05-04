Class {
	#name : #SymMarkerFrame,
	#superclass : #SymCartesianFrame,
	#instVars : [
		'thepm'
	],
	#category : #'StCAD-Basic'
}

{ #category : #accessing }
SymMarkerFrame >> aAOm [

	^ aAOf
]

{ #category : #accessing }
SymMarkerFrame >> aApm [

	^ aAFf
]

{ #category : #adding }
SymMarkerFrame >> addEndFC: aStEndFrameCurve [

	subs add: aStEndFrameCurve.
	aStEndFrameCurve sup: self
]

{ #category : #adding }
SymMarkerFrame >> addEndFS: aStEndFrameSurface [

	subs add: aStEndFrameSurface.
	aStEndFrameSurface sup: self
]

{ #category : #adding }
SymMarkerFrame >> addEndFc: aStEndFramec [

	subs add: aStEndFramec.
	aStEndFramec sup: self
]

{ #category : #adding }
SymMarkerFrame >> addEndFt: aStEndFramet [

	subs add: aStEndFramet.
	aStEndFramet sup: self
]

{ #category : #calc }
SymMarkerFrame >> calcAll [

	rOfO := self calcrOmO.
	aAOf := self calcaAOm.
	subs do: [ :sub | sub calcAll ]
]

{ #category : #calc }
SymMarkerFrame >> calcaAOm [

	^ sup aAOp timesFullMatrix: self aApm
]

{ #category : #calc }
SymMarkerFrame >> calcrOmO [

	^ sup rOpO + (sup aAOp timesFullColumn: self rpmp)
]

{ #category : #initialization }
SymMarkerFrame >> initialize [

	| rpmp1 rpmp2 rpmp3 rpmp thepm1x thepm2y thepm3z aApm |
	super initialize.
	rpmp1 := StMConstantParameter name: #rpmp1.
	rpmp2 := StMConstantParameter name: #rpmp2.
	rpmp3 := StMConstantParameter name: #rpmp3.
	rpmp := StMFullColumn with: rpmp1 with: rpmp2 with: rpmp3.
	rFfF := rpmp simplified.
	thepm1x := StMConstantParameter name: #thepm1x.
	thepm2y := StMConstantParameter name: #thepm2y.
	thepm3z := StMConstantParameter name: #thepm3z.
	thepm := SymEulerAngles with: thepm1x with: thepm2y with: thepm3z.
	aApm := thepm
		        calc;
		        aA.
	aAFf := aApm simplified
]

{ #category : #accessing }
SymMarkerFrame >> rOmO [

	^ rOfO
]

{ #category : #accessing }
SymMarkerFrame >> rpmp [

	^ rFfF
]

{ #category : #accessing }
SymMarkerFrame >> sup: aStPartFrame [

	sup := aStPartFrame
]
