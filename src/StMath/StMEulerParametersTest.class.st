Class {
	#name : 'StMEulerParametersTest',
	#superclass : 'TestCase',
	#category : 'StMath-StMathArray',
	#package : 'StMath',
	#tag : 'StMathArray'
}

{ #category : 'tests' }
StMEulerParametersTest >> testInterpolation [

	| axis theta1 theta2 qEO1 aAO1 qEO2 aAO2 cosHalfTheta qEOmid halfTheta sinHalfTheta factor ratio1 ratio2 qEOmidexact |
	axis := (StMFullColumn newWithElements: #( 0.0 0.0 1.0 )) normalizeSelf.
	theta1 := 10.0 degreesToRadians.
	theta2 := 80.0 degreesToRadians.
	qEO1 := StMEulerParameters withAxis: axis theta: theta1.
	aAO1 := qEO1 aA.
	qEO2 := StMEulerParameters withAxis: axis theta: theta2.
	aAO2 := qEO2 aA.
	factor := 0.5.

	cosHalfTheta := qEO1 dot: qEO2.
	[ cosHalfTheta equal: (theta2 - theta1 / 2) cos tol: 1.0e-6 ] assert.
	cosHalfTheta abs >= 1.0
		ifTrue: [ qEOmid := qEO1 copy ]
		ifFalse: [
			halfTheta := cosHalfTheta arcCos.
			sinHalfTheta := halfTheta sin.
			ratio1 := (1.0 - factor * halfTheta) sin / sinHalfTheta.
			ratio2 := (factor * halfTheta) sin / sinHalfTheta.
			qEOmid := qEO1 times: ratio1 plusFullColumn: qEO2 times: ratio2 ].
	qEOmidexact := StMEulerParameters withAxis: axis theta: 1.0 - factor * theta1 + (factor * theta2).
	[ qEOmid equal: qEOmidexact tol: 1.0e-6 ] assert
	"               auto cosTheta4D = qEOold->dot(qEOnew);
                if (abs(cosTheta4D) >= 1.0) {
                    qEOmid = qEOold->copy();
                }
                else {
                    auto theta4D = std::acos(cosTheta4D);
                    auto sinHalfTheta = std::sin(theta4D);
                    double ratioA = std::sin((1 - factor) * theta4D) / sinHalfTheta;
                    double ratioB = std::sin(factor * theta4D) / sinHalfTheta;
                    qEOmid = qEOold->times(ratioA)->plusFullColumn(qEOnew->times(ratioB));
                }
                qEOmid->calcABC();
                dragASMTPart->updateMbDFromRotationMatrix(qEOmid->aA);
                //Alternate derivation to check
                //{IJK} = [A]Oo[A]on{ijk}
                //{IJK} = [A]On{ijk}
                //[A]On = [A]Oo[A]on
                //[A]on = [A]OoT[A]On
                qEOold->calcABC();
                auto aAOo = qEOold->aA;
                qEOnew->calcABC();
                auto aAOn = qEOnew->aA;
                auto aAon = aAOo->transposeTimesFullMatrix(aAOn);
                auto qEon = aAon->asEulerParameters();
                cosTheta4D = qEon->at(3);
                auto theta4D = std::acos(cosTheta4D);
                auto sinHalfTheta = std::sin(theta4D);
                auto axisOfRotation = std::make_shared<std::vector<double>>();
                for (size_t i = 0; i < 3; i++) {
                    axisOfRotation->push_back(qEon->at(i) / sinHalfTheta);
                }
                auto qEomid = std::make_shared<EulerParameters<double>>();
                theta4D = factor * theta4D;
                cosTheta4D = std::cos(theta4D);
                sinHalfTheta = std::sin(theta4D);
                for (size_t i = 0; i < 3; i++) {
                    qEomid->at(i) = axisOfRotation->at(i) * sinHalfTheta;
                }
                qEomid->at(3) = cosTheta4D;
                qEomid->calcABC();
                auto aAOmid = aAOo->timesFullMatrix(qEomid->aA);
"
]

{ #category : 'tests' }
StMEulerParametersTest >> testInterpolationEulerParamenters [

	| axis theta1 theta2 qEO1 aAO1 qEO2 aAO2 cosHalfTheta qEOmid halfTheta sinHalfTheta factor ratio1 ratio2 qEOmidexact |
	axis := (StMFullColumn newWithElements: #( 0.0 1.0 1.0 )) normalizeSelf.
	theta1 := 10.0 degreesToRadians.
	theta2 := 80.0 degreesToRadians.
	qEO1 := StMEulerParameters withAxis: axis theta: theta1.
	aAO1 := qEO1 aA.
	qEO2 := StMEulerParameters withAxis: axis theta: theta2.
	aAO2 := qEO2 aA.
	factor := 0.5.

	cosHalfTheta := qEO1 dot: qEO2.
	[ cosHalfTheta equal: (theta2 - theta1 / 2) cos tol: 1.0e-6 ] assert.
	cosHalfTheta abs >= 1.0
		ifTrue: [ qEOmid := qEO1 copy ]
		ifFalse: [
			halfTheta := cosHalfTheta arcCos.
			sinHalfTheta := halfTheta sin.
			ratio1 := (1.0 - factor * halfTheta) sin / sinHalfTheta.
			ratio2 := (factor * halfTheta) sin / sinHalfTheta.
			qEOmid := qEO1 times: ratio1 plusFullColumn: qEO2 times: ratio2 ].
	qEOmidexact := StMEulerParameters withAxis: axis theta: 1.0 - factor * theta1 + (factor * theta2).
	[ qEOmid equal: qEOmidexact tol: 1.0e-6 ] assert
]

{ #category : 'tests' }
StMEulerParametersTest >> testInterpolationRotMat [
	"
		Alternate derivation to check
		{IJK} = [A]O1[A]12{ijk}
		{IJK} = [A]O2{ijk}
		[A]O2 = [A]O1[A]12
		[A]12 = [A]O1T[A]O2
	"

	| axis theta1 theta2 qEO1 aAO1 qEO2 aAO2 cosHalfTheta12 qE1mid qEOmid halfTheta12 sinHalfTheta12 factor qEOmidexact aA12 qE12 axisOfRotation halfTheta1mid cosHalfTheta1mid sinHalfTheta1mid aAOmid |
	axis := (StMFullColumn newWithElements: #( 0.0 0.0 1.0 )) normalizeSelf.
	theta1 := 10.0 degreesToRadians.
	theta2 := 80.0 degreesToRadians.
	qEO1 := StMEulerParameters withAxis: axis theta: theta1.
	aAO1 := qEO1 aA.
	qEO2 := StMEulerParameters withAxis: axis theta: theta2.
	aAO2 := qEO2 aA.
	factor := 0.5.
	aA12 := aAO1 transposeTimesFullMatrix: aAO2.
	qE12 := aA12 stmEulerParameters.
	cosHalfTheta12 := qE12 at: 4.
	[ cosHalfTheta12 equal: (theta2 - theta1 / 2) cos tol: 1.0e-6 ] assert.
	halfTheta12 := cosHalfTheta12 arcCos.
	sinHalfTheta12 := halfTheta12 sin.
	axisOfRotation := StMFullColumn new: 3.
	1 to: 3 do: [ :i | axisOfRotation at: i put: (qE12 at: i) ].
	axisOfRotation normalizeSelf.

	halfTheta1mid := factor * halfTheta12.
	cosHalfTheta1mid := halfTheta1mid cos.
	sinHalfTheta1mid := halfTheta1mid sin.
	qE1mid := StMEulerParameters new.
	qE1mid at: 1 putFullColumn: (axisOfRotation times: sinHalfTheta1mid).
	qE1mid at: 4 put: cosHalfTheta1mid.
	qE1mid calcABC.
	aAOmid := aAO1 timesFullMatrix: qE1mid aA.
	qEOmid := aAOmid stmEulerParameters.
	qEOmidexact := StMEulerParameters withAxis: axis theta: 1.0 - factor * theta1 + (factor * theta2).
	[ qEOmid equal: qEOmidexact tol: 1.0e-6 ] assert
]

{ #category : 'tests' }
StMEulerParametersTest >> testRange [

	| axis qE aA qEnew aAnew |
	-1.0 to: 1.0 by: 2.0 / 10 do: [ :x |
		-1.0 to: 1.0 by: 2.0 / 10 do: [ :y |
			-1.0 to: 1.0 by: 2.0 / 10 do: [ :z |
				Float pi negated to: Float pi by: Float pi / 5 do: [ :theta |
					axis := (StMFullColumn with: x with: y with: z) normalizeSelf.
					qE := StMEulerParameters withAxis: axis theta: theta.
					aA := qE aA.
					qEnew := aA stmEulerParameters.
					aAnew := qEnew aA.
					[ qE equal: qEnew tol: 1.0e-6 ] assert.
					[ (qE equal: qEnew tol: 1.0e-6) or: [ qE equal: qEnew negated tol: 1.0e-6 ] ] assert.
					[ aA equal: aAnew tol: 1.0e-6 ] assert ] ] ] ]
]
