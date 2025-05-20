Class {
	#name : 'BaselineOfSuperApp',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfSuperApp',
	#package : 'BaselineOfSuperApp'
}

{ #category : 'accessing' }
BaselineOfSuperApp >> baseline: spec [

	<baseline>
	spec for: #common do: [ "Packages"
		spec
			package: 'StCAD-Basic'
			with: [ spec requires: #( 'Magnitude-General' 'VWCompatibility' ) ];
			package: 'StCAD-Geo' with: [
				spec requires:
						#( 'StCAD-UI' 'Jun-Geometry-Boundaries' 'Jun-OpenGL-Trim' 'Magnitude-Numbers'
						   'StCAD-Basic' 'StMath' 'StCAD-MbD' 'StCAD-Misc'
						   'VWCompatibility' ) ];
			package: 'StMath'
			with: [ spec requires: #( 'Magnitude-Numbers' 'VWCompatibility' ) ];
			package: 'StCAD-MbD' with: [
				spec requires:
						#('StCAD-UI' 'Magnitude-Numbers' 'StMath' 'VWCompatibility' ) ];
			package: 'StCAD-Misc'
			with: [ spec requires: #( 'StMath' 'VWCompatibility' ) ];
			package: 'StCAD-NMT' with: [
				spec requires:
						#( 'StCAD-Basic' 'StCAD-Geo' 'StMath' 'StCAD-Misc'
						   'VWCompatibility' ) ];
			package: 'StCAD-STEP'
			with: [ spec requires: #( 'StMath' 'VWCompatibility' ) ];
			package: 'StCAD-UI'
			with: [
				spec requires: #( 'StMath' 'VWCompatibility' ) ];
			package: 'GFST' with: [ spec requires: #( 'VWCompatibility' ) ];
			package: 'Jun-DXF-Support';
			package: 'Jun-Geometry-Basic'
			with: [ spec requires: #( 'VWCompatibility' ) ];
			package: 'Jun-Geometry-Boundaries'
			with: [ spec requires: #( 'VWCompatibility' ) ];
			package: 'Jun-OpenGL-Display'
			with: [ spec requires: #( 'VWCompatibility' ) ];
			package: 'Jun-OpenGL-Objects'
			with: [ spec requires: #( 'VWCompatibility' ) ];
			package: 'Jun-OpenGL-Projection';
			package: 'Jun-OpenGL-Support'
			with: [ spec requires: #( 'VWCompatibility' ) ];
			package: 'Jun-OpenGL-Trim'
			with: [ spec requires: #( 'VWCompatibility' ) ];
			package: 'Magnitude-General';
			package: 'Magnitude-Numbers'
			with: [ spec requires: #( 'VWCompatibility' ) ];
			package: 'VWCompatibility' ]
]

{ #category : 'accessing' }
BaselineOfSuperApp >> projectClass [
	^ MetacelloCypressBaselineProject
]
