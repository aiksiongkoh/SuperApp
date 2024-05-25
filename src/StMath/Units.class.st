"
asmtNum*asmtUnit = siNum*siUnit = mbdNum*mbdUnit

"
Class {
	#name : 'Units',
	#superclass : 'StMNumeric',
	#instVars : [
		'time',
		'mass',
		'aJ',
		'length',
		'angle',
		'velocity',
		'omega',
		'acceleration',
		'alpha',
		'force',
		'torque'
	],
	#classVars : [
		'Math'
	],
	#category : 'StMath-StMathArraySpecial',
	#package : 'StMath',
	#tag : 'StMathArraySpecial'
}

{ #category : 'accessing' }
Units class >> Kilograms [
	^Kilograms
]

{ #category : 'accessing' }
Units class >> Meters [
	^Meters
]

{ #category : 'accessing' }
Units class >> Newtons [
	^Newtons
]

{ #category : 'accessing' }
Units class >> Seconds [
	^Seconds
]

{ #category : 'class initialization' }
Units class >> initializeForceUnits [
	Newtons at: #DYNE put: 1.0e-5.
	Newtons at: #KILOGRAMFORCE put: 9.81.
	Newtons at: #KILONEWTON put: 1000.0.
	Newtons at: #KILOPOUNDFORCE put: 4448.0.
	Newtons at: #NEWTON put: 1.0.
	Newtons at: #OUNCEFORCE put: 0.278.
	Newtons at: #POUNDFORCE put: 4.448.
	Newtons at: #POUNDAL put: 0.1383
]

{ #category : 'class initialization' }
Units class >> initializeLengthUnits [
	Meters at: #CENTIMETER put: 0.01.
	Meters at: #FOOT put: 0.3048.
	Meters at: #KILOMETER put: 1000.0.
	Meters at: #INCH put: 0.0254.
	Meters at: #METER put: 1.0.
	Meters at: #MILLIMETER put: 0.001.
	Meters at: #MILE put: 1609.0
]

{ #category : 'class initialization' }
Units class >> initializeMassUnits [
	Kilograms at: #GRAM put: 0.001.
	Kilograms at: #KILOGRAM put: 1.0.
	Kilograms at: #KILOPOUNDMASS put: 453.6.
	Kilograms at: #OUNCEMASS put: 0.02835.
	Kilograms at: #POUNDMASS put: 0.4536.
	Kilograms at: #SLUG put: 14.59
]

{ #category : 'class initialization' }
Units class >> initializeTimeUnits [
	Seconds at: #HOUR put: 3600.0.
	Seconds at: #MILLISECOND put: 0.001.
	Seconds at: #MINUTE put: 60.0.
	Seconds at: #SECOND put: 1.0
]

{ #category : 'class initialization' }
Units class >> initializeX [
	"StMPhysicalUnits initialize."

	Meters := IdentityDictionary new.
	Kilograms := IdentityDictionary new.
	Seconds := IdentityDictionary new.
	Newtons := IdentityDictionary new.
	self initializeLengthUnits.
	self initializeMassUnits.
	self initializeTimeUnits.
	self initializeForceUnits
]

{ #category : 'instance creation' }
Units class >> time: unitTime mass: unitMass length: unitLength angle: unitAngle [ 
	^super basicNew
		time: unitTime
		mass: unitMass
		length: unitLength
		angle: unitAngle
]

{ #category : 'VisualWorks metadata' }
Units class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
	)

]

{ #category : 'accessing' }
Units >> aJ [
	^aJ
]

{ #category : 'accessing' }
Units >> acceleration [
	^acceleration
]

{ #category : 'accessing' }
Units >> alpha [
	^alpha
]

{ #category : 'accessing' }
Units >> angle [
	^angle
]

{ #category : 'calc' }
Units >> calc [
	"Calculate derived units."

	aJ := mass * length * length.
	velocity := length / time.
	omega := angle / time.
	acceleration := velocity / time.
	alpha := omega / time.
	force := mass * acceleration.
	torque := force * length
]

{ #category : 'accessing' }
Units >> force [
	^force
]

{ #category : 'initialize-release' }
Units >> initialize [
	"Default units are second, kilogram, meter, radians."

	self
		time: 1.0
		mass: 1.0
		length: 1.0
		angle: 1.0
]

{ #category : 'accessing' }
Units >> length [
	^length
]

{ #category : 'accessing' }
Units >> mass [
	^mass
]

{ #category : 'accessing' }
Units >> omega [
	^omega
]

{ #category : 'accessing' }
Units >> time [
	^time
]

{ #category : 'accessing' }
Units >> time: unitTime mass: unitMass length: unitLength angle: unitAngle [ 
	time := unitTime.
	mass := unitMass.
	length := unitLength.
	angle := unitAngle.
	self calc
]

{ #category : 'accessing' }
Units >> torque [
	^torque
]

{ #category : 'accessing' }
Units >> velocity [
	^velocity
]
