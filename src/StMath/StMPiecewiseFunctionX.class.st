"
PiecewiseFunction.
The piecewise functions must reference the same x so that everything is consistent. Otherwise the value returned will not be correct when the x's are changed independently.

Instance Variables:

x	<StMArgumentHolder>	The holder is used in functions so that change is argument is reflected in functions.
functions	<OrderedCollection>	func1, func2, .., funcn.
transitions	<OrderedCollection>	-inf < x1 < x2 < x3 ...< inf.

When 
	(x1 <= keyFunction < x2) 
then 
	function := functions at: 2.

To get 
	(x1 <= keyFunction <= x2), 
use 
	(x1 <= keyFunction < x2+) 
where
	x2+ :=  x2 * (1.0d + machinePrecision).

"
Class {
	#name : 'StMPiecewiseFunctionX',
	#superclass : 'StMFunctionX',
	#instVars : [
		'functions',
		'transitions'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'VisualWorks metadata' }
StMPiecewiseFunctionX class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMPiecewiseFunctionX class >> with: var functions: funcs transitions: trans [ 
	^super new
		x: var
		functions: funcs
		transitions: trans
]

{ #category : 'comparing' }
StMPiecewiseFunctionX >> = anObject [ 
	^super = anObject and: [functions = anObject functions and: [transitions = anObject transitions]]
]

{ #category : 'message handling' }
StMPiecewiseFunctionX >> argsPerform: selector withArguments: anArray [ 
	super argsPerform: selector withArguments: anArray.
	functions do: [:function | function perform: selector withArguments: anArray].
	transitions do: [:transition | transition perform: selector withArguments: anArray]
]

{ #category : 'evaluating' }
StMPiecewiseFunctionX >> differentiateWRT: var [

	^ var isSequenceable
		  ifTrue: [ var collect: [ :vari | self differentiateWRT: vari ] ]
		  ifFalse: [
				  | derivs |
				  derivs := functions collect: [ :function |
					            function differentiateWRT: var ].
				  StMPiecewiseFunctionX
					  with: x copy
					  functions: derivs
					  transitions: transitions ]
]

{ #category : 'evaluating' }
StMPiecewiseFunctionX >> expandUntil: set [ 
	| xx newfunctions newtransitions copy |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[xx := x expandUntil: set.
			newfunctions := functions collect: [:function | function expandUntil: set].
			newtransitions := transitions collect: [:transition | transition expandUntil: set].
			copy := self class
						with: xx
						functions: newfunctions
						transitions: newtransitions.
			xx isConstant
				ifTrue: [StMConstant with: copy value]
				ifFalse: [copy]]
]

{ #category : 'accessing' }
StMPiecewiseFunctionX >> functions [
	^functions
]

{ #category : 'comparing' }
StMPiecewiseFunctionX >> hash [

	| hash |
	hash := super hash.
	hash := hash bitXor: functions hash.
	hash := hash bitXor: transitions hash.
	^ hash
]

{ #category : 'evaluating' }
StMPiecewiseFunctionX >> partialDifferentiateWRT: variable [ 
	| derivs answer |
	derivs := functions collect: [:function | function partialDifferentiateWRT: variable].
	answer := StMPiecewiseFunctionX
				with: x copy
				functions: derivs
				transitions: transitions.
	^answer
]

{ #category : 'copying' }
StMPiecewiseFunctionX >> postCopy [
	super postCopy.
	functions := functions collect: [:function | function copy].
	transitions := transitions collect: [:transition | transition copy]
]

{ #category : 'evaluating' }
StMPiecewiseFunctionX >> simplifyUntil: set [ 
	| xx newfunctions newtransitions copy |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[xx := x simplifyUntil: set.
			newfunctions := functions collect: [:function | function simplifyUntil: set].
			newtransitions := transitions collect: [:transition | transition simplifyUntil: set].
			copy := self class
						with: xx
						functions: newfunctions
						transitions: newtransitions.
			xx isConstant
				ifTrue: [StMConstant with: copy value]
				ifFalse: [copy]]
]

{ #category : 'changing' }
StMPiecewiseFunctionX >> substitute: var1 with: var2 [ 
	| xx newFunctions newTransitions |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[xx := x substitute: var1 with: var2.
			newFunctions := functions collect: [:function | function substitute: var1 with: var2].
			newTransitions := transitions collect: [:transition | transition substitute: var1 with: var2].
			self class
				with: xx
				functions: newFunctions
				transitions: newTransitions]
]

{ #category : 'accessing' }
StMPiecewiseFunctionX >> transitions [
	^transitions
]

{ #category : 'evaluating' }
StMPiecewiseFunctionX >> value [
	| nTransitions xvalue |
	nTransitions := transitions size.
	xvalue := x value.
	1 to: nTransitions do: [:i | xvalue < (transitions at: i) value ifTrue: [^(functions at: i) value]].
	^(functions at: nTransitions + 1) value
]

{ #category : 'accessing' }
StMPiecewiseFunctionX >> x: arg [ 
	| xold |
	xold := x.
	super x: arg.
	functions := functions collect: [:function | function substitute: xold with: x].
	transitions := transitions collect: [:transition | transition substitute: xold with: x]
]

{ #category : 'initialize-release' }
StMPiecewiseFunctionX >> x: var functions: funcs transitions: trans [ 
	x := self conditionArgument: var.
	functions := funcs collect: [:func | self conditionArgument: func].
	transitions := trans collect: [:tran | self conditionArgument: tran]
]
