Extension { #name : 'Float' }

{ #category : '*StCAD-Basic' }
Float class >> arcTanMpiTOpiY: y overX: x [
	"(y/x) arcTan in the range -pi to pi."

	"self arcTanMpiTOpiY: 1.0d overX: 1.0d."

	^ x > 0
		  ifTrue: [ "First and Fourth quadrants." (y / x) arcTan ]
		  ifFalse: [
			  x < 0
				  ifTrue: [
					  y >= 0
						  ifTrue: [ "Second quadrant." (y / x) arcTan + self pi ]
						  ifFalse: [ "Third quadrant." (y / x) arcTan - self pi ] ]
				  ifFalse: [ "x = 0"
					  y = 0
						  ifTrue: [ self error: '0/0 arcTan is not defined.' ]
						  ifFalse: [ y sign * self pi / 2.0 ] ] ]
]
