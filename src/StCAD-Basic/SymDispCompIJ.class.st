"
rIJO := rOJO - rOIO.
rIJI := aAOI^T * (rOJO - rOIO).
rIJI := aAOI^T * rIJO.

"
Class {
	#name : 'SymDispCompIJ',
	#superclass : 'SymKinematicIJ',
	#instVars : [
		'rIJO'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}
