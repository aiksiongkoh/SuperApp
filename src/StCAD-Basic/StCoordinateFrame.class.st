"
Abstract class for coordinate frame

    Instance Variables
	sup: 		<StCoordinateFrame> Base frame of self
	subs:		<OrderedCollection> Collection of subframes
	aAFf:		<FullMatrix> Rotation matrix such that col(xyz)F = aAFf * col(xyz)f
	aAOf:		<FullMatrix> Rotation matrix such that col(xyz)O = aAOf * col(xyz)f
	body:		<Object> Any body or object attached to the frame
	rFfF:		<FullColumn> Displacement vector r from F to f in F components
	rOfO:		<FullColumn> Displacement vector r from O to f in O components

InertialFrame contains AssemblyFrame contains PartFrame contains MarkerFrame contains EndFrame
 
"
Class {
	#name : #StCoordinateFrame,
	#superclass : #StItem,
	#instVars : [
		'sup',
		'subs',
		'body',
		'rFfF',
		'aAFf',
		'rOfO',
		'aAOf'
	],
	#category : #'StCAD-Basic'
}

{ #category : #initialization }
StCoordinateFrame >> initialize [

	subs := OrderedCollection new
]

{ #category : #accessing }
StCoordinateFrame >> subs [
	^ subs
]
