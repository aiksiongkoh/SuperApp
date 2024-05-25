Class {
	#name : 'AbstractCartesianFrame',
	#superclass : 'CoordinateFrame',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'copying' }
AbstractCartesianFrame >> postCopy [
	super postCopy.
	body := nil
]
