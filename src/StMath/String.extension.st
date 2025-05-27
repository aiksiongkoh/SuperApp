Extension { #name : 'String' }

{ #category : '*StMath' }
String >> expandWithArgument: string [ 
	"Substitute %1 with string."

	| stream buffer |
	stream := self readStream.
	buffer := (String new: 256) writeStream.
	[stream atEnd]
		whileFalse: 
			[| char |
			char := stream next.
			char = $%
				ifTrue: [(Integer readFrom: stream)
						== 1 ifTrue: [buffer nextPutAll: string]]
				ifFalse: [buffer nextPut: char]].
	^buffer contents
]

{ #category : '*StMath' }
String >> mbdMessage [
	"Detect prefix 'MbD' or 'ADM'."
	"Then skip pass the first blank space."
	"Then convert all \'s to cr's."

	| prefix stream buffer char |
	^(self size > 2
		and: 
			[prefix := self copyFrom: 1 to: 3.
			(prefix = 'ADM' or: [prefix = 'MbD'])
				or: [prefix = 'StM']])
		ifTrue: 
			[stream := self readStream.
			stream skipThrough: Character space.
			buffer := (String new: 256) writeStream.
			[stream atEnd]
				whileFalse: 
					[char := stream next.
					buffer nextPut: (char = $\
							ifTrue: [Character cr]
							ifFalse: [char])].
			buffer contents]
		ifFalse: [self withCRs]
]
