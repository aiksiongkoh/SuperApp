Class {
	#name : 'StMFunctionParser',
	#superclass : 'StMSymbolicParser',
	#instVars : [
		'container',
		'geoIJs',
		'units'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'accessing' }
StMFunctionParser >> container [

	^ container
]

{ #category : 'accessing' }
StMFunctionParser >> container: anObject [

	container := anObject
]

{ #category : 'parsing' }
StMFunctionParser >> displacement [

	((((self peekForType: #word value: 'rIJ') and: [
		   stack addLast: GEOrIJ new * units length.
		   true ]) or: [
		  ((self peekForType: #word value: 'angleIJz') and: [
			   stack addLast: GEOAngleIJz new * units angle.
			   true ]) or: [
			  ((self peekForType: #word value: 'dAngleIJx') and: [
				   stack addLast: GEOdAngleIJx new * units angle.
				   true ]) or: [
				  (self peekForType: #word value: 'dAngleIJy') and: [
					  stack addLast: GEOdAngleIJy new * units angle.
					  true ] ] ] ]) and: [
		 (self peekForTypeNoPush: #leftParenthesis)
			 ifTrue: [
				 self geoIJ
					 ifTrue: [
						 (self peekForTypeNoPush: #rightParenthesis)
							 ifTrue: [
								 stack addLast: self geoFunctionIJ.
								 true ]
							 ifFalse: [ self expected: #rightParenthesis ] ]
					 ifFalse: [ self expected: 'geoIJ' ] ]
			 ifFalse: [ self expected: #leftParenthesis ] ]) ifTrue: [ ^ true ].
	(self peekForType: #word value: 'rIJKi') ifTrue: [
		stack addLast: GEOrIJKi new * units length.
		(self peekForTypeNoPush: #leftParenthesis) ifTrue: [
			self geoIJ ifTrue: [
				(self peekForTypeNoPush: #ascii54) ifTrue: [
					(((self peekForType: #word value: 'I') and: [
						  stack addLast: #I.
						  true ]) or: [
						 ((self peekForType: #word value: 'J') and: [
							  stack addLast: #J.
							  true ]) or: [
							 (self peekForType: #word value: 'O') and: [
								 stack addLast: #O.
								 true ] ] ]) ifTrue: [
						(self peekForTypeNoPush: #ascii54) ifTrue: [
							(self peekForType: #number) ifTrue: [
								(self peekForTypeNoPush: #rightParenthesis) ifTrue: [
									stack addLast: self geoFunctionIJKi.
									^ true ].
								^ self expected: #rightParenthesis ].
							^ self expected: 'number' ].
						^ self expected: ',' ].
					^ self expected: '''I'' or ''J'' or ''O''' ].
				^ self expected: ',' ].
			^ self expected: 'geoIJ' ].
		^ self expected: #leftParenthesis ].
	^ false
]

{ #category : 'public - layout' }
StMFunctionParser >> force [

	((((self peekForType: #word value: 'forceIJ') and: [
		   stack addLast: GEOForceIJ new.
		   true ]) or: [
		  (self peekForType: #word value: 'torqueIJ') and: [
			  stack addLast: GEOTorqueIJ new.
			  true ] ]) and: [
		 (self peekForTypeNoPush: #leftParenthesis)
			 ifTrue: [
				 self variable
					 ifTrue: [
						 (self peekForTypeNoPush: #ascii54)
							 ifTrue: [
								 self variable
									 ifTrue: [
										 (self peekForTypeNoPush: #rightParenthesis)
											 ifTrue: [
												 stack addLast: [
													 | t1 t2 t3 |
													 t1 := stack removeLast.
													 t2 := stack removeLast.
													 (t3 := stack removeLast) markerI: t2 markerJ: t1.
													 t3 ] value.
												 true ]
											 ifFalse: [ self expected: #rightParenthesis ] ]
									 ifFalse: [ self expected: 'variable' ] ]
							 ifFalse: [ self expected: ',' ] ]
					 ifFalse: [ self expected: 'variable' ] ]
			 ifFalse: [ self expected: #leftParenthesis ] ]) ifTrue: [ ^ true ].
	(((self peekForType: #word value: 'forceIJKi') and: [
		  stack addLast: GEOForceIJKi new.
		  true ]) or: [
		 (self peekForType: #word value: 'torqueIJKi') and: [
			 stack addLast: GEOTorqueIJKi new.
			 true ] ]) ifTrue: [
		(self peekForTypeNoPush: #leftParenthesis) ifTrue: [
			self variable ifTrue: [
				(self peekForTypeNoPush: #ascii54) ifTrue: [
					self variable ifTrue: [
						(self peekForTypeNoPush: #ascii54) ifTrue: [
							self variable ifTrue: [
								(self peekForTypeNoPush: #ascii54) ifTrue: [
									(self peekForType: #number) ifTrue: [
										(self peekForTypeNoPush: #rightParenthesis) ifTrue: [
											stack addLast: [
												| t4 t5 t6 t7 t8 |
												t4 := stack removeLast.
												t5 := stack removeLast.
												t6 := stack removeLast.
												t7 := stack removeLast.
												(t8 := stack removeLast)
													markerI: t7
													markerJ: t6
													markerK: t5
													axisK: t4.
												t8 ] value.
											^ true ].
										^ self expected: #rightParenthesis ].
									^ self expected: 'number' ].
								^ self expected: ',' ].
							^ self expected: 'variable' ].
						^ self expected: ',' ].
					^ self expected: 'variable' ].
				^ self expected: ',' ].
			^ self expected: 'variable' ].
		^ self expected: #leftParenthesis ].
	^ false
]

{ #category : 'parsing' }
StMFunctionParser >> namedFunction [

	self intrinsic ifTrue: [ ^ true ].
	self displacement ifTrue: [ ^ true ].
	self velocity ifTrue: [ ^ true ].
	^ self force
]

{ #category : 'parsing' }
StMFunctionParser >> parse: textOrStream as: construct notifying: aRequestor ifFail: aBlock [

	self initScanner.
	self init: textOrStream notifying: aRequestor failBlock: aBlock.
	self perform: construct.
	tokenType == #doIt ifFalse: [ self expected: 'Nothing more' ].
	stack size = 1 ifFalse: [ self notify: 'Stack size error, compiler bug!' ].
	^ stack
]

{ #category : 'parsing' }
StMFunctionParser >> parseUserFunction: userFunction notifying: aRequestor ifFail: aBlock [

	| func |
	units := userFunction units.
	self
		parse: userFunction funcText
		as: #expression
		notifying: aRequestor
		ifFail: aBlock.
	func := stack removeLast.
	stack addLast: func * userFunction myUnit.
	^ stack
]

{ #category : 'initialize-release' }
StMFunctionParser >> variablesSet [

	^ super variablesSet
		  add: container asmtTime;
		  yourself
]

{ #category : 'accessing' }
StMFunctionParser >> velocity [

	((((self peekForType: #word value: 'vIJ') and: [
		   stack addLast: GEOvIJ new * units velocity.
		   true ]) or: [
		  ((self peekForType: #word value: 'vrIJ') and: [
			   stack addLast: GEOvrIJ new * units velocity.
			   true ]) or: [
			  (self peekForType: #word value: 'omeIJ') and: [
				  stack addLast: GEOomeIJ new * units omega.
				  true ] ] ]) and: [
		 (self peekForTypeNoPush: #leftParenthesis)
			 ifTrue: [
				 self geoIJ
					 ifTrue: [
						 (self peekForTypeNoPush: #rightParenthesis)
							 ifTrue: [
								 stack addLast: self geoFunctionIJ.
								 true ]
							 ifFalse: [ self expected: #rightParenthesis ] ]
					 ifFalse: [ self expected: 'geoIJ' ] ]
			 ifFalse: [ self expected: #leftParenthesis ] ]) ifTrue: [ ^ true ].
	(((self peekForType: #word value: 'vIJKi') and: [
		  stack addLast: GEOvIJKi new * units velocity.
		  true ]) or: [
		 (self peekForType: #word value: 'omeIJKi') and: [
			 stack addLast: GEOomeIJKi new * units omega.
			 true ] ]) ifTrue: [
		(self peekForTypeNoPush: #leftParenthesis) ifTrue: [
			self geoIJ ifTrue: [
				(self peekForTypeNoPush: #ascii54) ifTrue: [
					(((self peekForType: #word value: 'I') and: [
						  stack addLast: #I.
						  true ]) or: [
						 ((self peekForType: #word value: 'J') and: [
							  stack addLast: #J.
							  true ]) or: [
							 (self peekForType: #word value: 'O') and: [
								 stack addLast: #O.
								 true ] ] ]) ifTrue: [
						(self peekForTypeNoPush: #ascii54) ifTrue: [
							(self peekForType: #number) ifTrue: [
								(self peekForTypeNoPush: #rightParenthesis) ifTrue: [
									stack addLast: self geoFunctionIJKi.
									^ true ].
								^ self expected: #rightParenthesis ].
							^ self expected: 'number' ].
						^ self expected: ',' ].
					^ self expected: '''I'' or ''J'' or ''O''' ].
				^ self expected: ',' ].
			^ self expected: 'geoIJ' ].
		^ self expected: #leftParenthesis ].
	^ false
]
