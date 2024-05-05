Class {
	#name : #StMMultibodyDynamics,
	#superclass : #StMSymbolic,
	#instVars : [
		'rOaO',
		'rapa',
		'rpmp',
		'rmem'
	],
	#category : #'StMath-Symbolic'
}

{ #category : #'initialize-release' }
StMMultibodyDynamics >> initialize [ 
	| t rOaO1 rOaO2 rOaO3 qXd1 qXd2 qXd3 qXd rapa1 rapa2 rapa3 rpmp1 rpmp2 rpmp3 rmem1 rmem2 rmem3 rmemt1 rmemt2 rmemt3 rmemt qXt1 qXt2 qXt3 qXt st1 st2 st sd1 sd2 sd s1 s2 s rmems1 rmems2 rmems3 rmems qE2 qE3 qE4 qE1 qE |
	t := StMIndependentVariable name: #t.
	rOaO1 := StMVariableParameter name: #rOaO1.
	rOaO2 := StMVariableParameter name: #rOaO2.
	rOaO3 := StMVariableParameter name: #rOaO3.
	rOaO := StMFullColumn with: rOaO1 with: rOaO2 with: rOaO3.
	rOaO do: [ :r | r x: t ].	"Prescribed function of time"
	qXt1 := StMVariableParameter name: #qXt1.
	qXt2 := StMVariableParameter name: #qXt2.
	qXt3 := StMVariableParameter name: #qXt3.
	qXt := StMFullColumn with: qXt1 with: qXt2 with: qXt3.
	qXt do: [ :q | q x: t ].	"Prescribed function of time"
	qXd1 := StMDependentVariable name: #qXd1.
	qXd2 := StMDependentVariable name: #qXd2.
	qXd3 := StMDependentVariable name: #qXd3.
	qXd := StMFullColumn with: qXd1 with: qXd2 with: qXd3.
	qXd do: [ :q | q x: t ].	"Unknown function of time"
	rapa1 := StMSum with: qXt1 plus: qXd1.
	rapa2 := StMSum with: qXt2 plus: qXd2.
	rapa3 := StMSum with: qXt3 plus: qXd3.
	rapa := StMFullColumn with: rapa1 with: rapa2 with: rapa3.
	rpmp1 := StMConstantParameter name: #rpmp1.
	rpmp2 := StMConstantParameter name: #rpmp2.
	rpmp3 := StMConstantParameter name: #rpmp3.
	rpmp := StMFullColumn with: rpmp1 with: rpmp2 with: rpmp3.
	rmem1 := StMConstantParameter name: #rmem1.
	rmem2 := StMConstantParameter name: #rmem2.
	rmem3 := StMConstantParameter name: #rmem3.
	rmem := StMFullColumn with: rmem1 with: rmem2 with: rmem3.
	rmemt1 := StMVariableParameter name: #rmemt1.
	rmemt2 := StMVariableParameter name: #rmemt2.
	rmemt3 := StMVariableParameter name: #rmemt3.
	rmemt := StMFullColumn with: rmemt1 with: rmemt2 with: rmemt3.
	rmemt do: [ :r | r x: t ].	"Prescribed function of time"
	st1 := StMVariableParameter name: #st1.
	st2 := StMVariableParameter name: #st2.
	st := StMFullColumn with: st1 with: st2.
	st do: [ :r | r x: t ].	"Prescribed function of time"
	sd1 := StMDependentVariable name: #sd1.
	sd2 := StMDependentVariable name: #sd2.
	sd := StMFullColumn with: sd1 with: sd2.
	sd do: [ :r | r x: t ].	"Unknown function of time"
	s1 := StMSum with: st1 plus: sd1.
	s2 := StMSum with: st2 plus: sd2.
	s := StMFullColumn with: s1 with: s2.
	rmems1 := StMVariableParameter name: #rmems1.
	rmems2 := StMVariableParameter name: #rmems2.
	rmems3 := StMVariableParameter name: #rmems3.
	rmems := StMFullColumn with: rmems1 with: rmems2 with: rmems3.
	rmems do: [ :r | r x: s ].	"Prescribed function of s"
	"
	aAOa(t) in terms of the1x(t), the2y(t), the3z(t) Bryant Angles
	qE = Euler parameters qE1(t), qE2(t), qE3(t), qE4(t)
	(qEi abs) is always < 1.0. No need for perturbation technique.
	aAap(qE)	
	aApm is constant
	aAme is constant
	aAme(t)
	aAme(s)
	"
	qE1 := StMDependentVariable name: #qE1.
	qE2 := StMDependentVariable name: #qE2.
	qE3 := StMDependentVariable name: #qE3.
	qE4 := StMDependentVariable name: #qE4.
	qE := StMFullColumn with: qE1 with: qE2 with: qE3 with: qE4.
	qE do: [ :q | q x: t ].	"Unknown function of time"






]

{ #category : #'initialize-release' }
StMMultibodyDynamics >> initialize2 [
	"self initialize2."

	| t rOaO1 rOaO2 rOaO3 qX1 qX2 qX3 qX rapa1 rapa2 rapa3 rpmp1 rpmp2 rpmp3 rmem1 rmem2 rmem3 rmemt1 rmemt2 rmemt3 rmemt s1 s2 s rmems1 rmems2 rmems3 rmems qE2 qE3 qE4 qE1 qE theOa1x theOa2y theOa3z theOa aAOa aAap thepm1x thepm2y thepm3z thepm aApm |
	t := StMIndependentVariable name: #t.
	rOaO1 := StMVariableParameter name: #rOaO1.
	rOaO2 := StMVariableParameter name: #rOaO2.
	rOaO3 := StMVariableParameter name: #rOaO3.
	rOaO := StMFullColumn with: rOaO1 with: rOaO2 with: rOaO3.
	rOaO do: [ :r | r x: t ]. "Prescribed function of time"
	qX1 := StMDependentVariable name: #qX1.
	qX2 := StMDependentVariable name: #qX2.
	qX3 := StMDependentVariable name: #qX3.
	qX := StMFullColumn with: qX1 with: qX2 with: qX3.
	qX do: [ :q | q x: t ]. "Unknown function of time"
	rapa1 := qX1.
	rapa2 := qX2.
	rapa3 := qX3.
	rapa := StMFullColumn with: rapa1 with: rapa2 with: rapa3.
	rpmp1 := StMConstantParameter name: #rpmp1.
	rpmp2 := StMConstantParameter name: #rpmp2.
	rpmp3 := StMConstantParameter name: #rpmp3.
	rpmp := StMFullColumn with: rpmp1 with: rpmp2 with: rpmp3.
	rmem1 := StMConstantParameter name: #rmem1.
	rmem2 := StMConstantParameter name: #rmem2.
	rmem3 := StMConstantParameter name: #rmem3.
	rmem := StMFullColumn with: rmem1 with: rmem2 with: rmem3.
	rmemt1 := StMVariableParameter name: #rmemt1.
	rmemt2 := StMVariableParameter name: #rmemt2.
	rmemt3 := StMVariableParameter name: #rmemt3.
	rmemt := StMFullColumn with: rmemt1 with: rmemt2 with: rmemt3.
	rmemt do: [ :r | r x: t ]. "Prescribed function of time"
	s1 := StMDependentVariable name: #s1.
	s2 := StMDependentVariable name: #s2.
	s := StMFullColumn with: s1 with: s2.
	rmems1 := StMVariableParameter name: #rmems1.
	rmems2 := StMVariableParameter name: #rmems2.
	rmems3 := StMVariableParameter name: #rmems3.
	rmems := StMFullColumn with: rmems1 with: rmems2 with: rmems3.
	rmems do: [ :r | r x: s ]. "Prescribed function of s"
	"
	aAOa(t) in terms of the1x(t), the2y(t), the3z(t) Bryant Angles
	qE = Euler parameters qE1(t), qE2(t), qE3(t), qE4(t)
	(qEi abs) is always < 1.0.
	aAap(qE)	
	aApm is constant
	aAme is constant
	aAme(t)
	aAme(s)
	"
	theOa1x := StMVariableParameter name: #theOa1x.
	theOa2y := StMVariableParameter name: #theOa2y.
	theOa3z := StMVariableParameter name: #theOa3z.
	theOa := SymEulerAngles with: theOa1x with: theOa2y with: theOa3z.
	theOa do: [ :the | the x: t ]. "Prescribed function of time"
	aAOa := theOa
		        calc;
		        aA.
	qE1 := StMDependentVariable name: #qE1.
	qE2 := StMDependentVariable name: #qE2.
	qE3 := StMDependentVariable name: #qE3.
	qE4 := StMDependentVariable name: #qE4.
	qE := SymEulerParameters
		      with: qE1
		      with: qE2
		      with: qE3
		      with: qE4.
	qE do: [ :q | q x: t ]. "Unknown function of time"
	aAap := qE calcABC aA.
	thepm1x := StMConstantParameter name: #thepm1x.
	thepm2y := StMConstantParameter name: #thepm2y.
	thepm3z := StMConstantParameter name: #thepm3z.
	thepm := SymEulerAngles with: thepm1x with: thepm2y with: thepm3z.
	aApm := thepm
		        calcABC;
		        aA
]
