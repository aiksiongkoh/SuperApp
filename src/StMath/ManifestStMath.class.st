"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestStMath',
	#superclass : 'PackageManifest',
	#category : 'StMath-Manifest',
	#package : 'StMath',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestStMath class >> ruleCollectionProtocolRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#StMProduct #simplifyPower #false)) #'2024-06-07T10:59:49.758-06:00') #(#(#RGMethodDefinition #(#StMSum #simplifyPower #false)) #'2024-06-07T11:04:09.792-06:00') #(#(#RGClassDefinition #(#StMSum)) #'2024-06-07T11:42:11.515-06:00') #(#(#RGClassDefinition #(#StMProduct)) #'2024-06-07T11:51:55.215-06:00') )
]

{ #category : 'code-critics' }
ManifestStMath class >> ruleLongMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#StMMultibodyDynamics #initialize #false)) #'2024-03-02T16:51:17.226-07:00') )
]
