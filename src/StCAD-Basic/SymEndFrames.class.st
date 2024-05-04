"
Instance Variables
	s:		<OrderedCollection> collection of one or two geometric parameters for curve or surface respectively

"
Class {
	#name : #SymEndFrames,
	#superclass : #SymEndFrame,
	#instVars : [
		's',
		'theme'
	],
	#category : #'StCAD-Basic'
}

{ #category : #initialization }
SymEndFrames >> initialize [

	| rmems1 rmems2 rmems3 rmems theme1x theme2y theme3z aAme |
	"Known function of s to define geometry""Prescribed function of s"
	super initialize.
	rmems1 := StMVariableParameter name: #rmems1.
	rmems2 := StMVariableParameter name: #rmems2.
	rmems3 := StMVariableParameter name: #rmems3.
	rmems := StMFullColumn with: rmems1 with: rmems2 with: rmems3.
	rmems do: [ :r | r x: s ].
	rFfF := rmems simplified.
	theme1x := StMConstantParameter name: #theme1x.
	theme2y := StMConstantParameter name: #theme2y.
	theme3z := StMConstantParameter name: #theme3z.
	theme := SymEulerAngles with: theme1x with: theme2y with: theme3z.
	aAme := theme
		        calc;
		        aA.
	aAFf := aAme simplified
]

{ #category : #accessing }
SymEndFrames >> sup: aStMarkerFrame [

	| t |
	sup := aStMarkerFrame.
	t := self time.
	s do: [ :si | si x: t ]
]
