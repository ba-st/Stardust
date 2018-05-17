tests
rectangleCreatorFrom: originPicker to: cornerCreator

	^ (GenericModelCreatorBuilder named: 'rectangle' building: Rectangle accessedUsing: #(#origin #corner)) origin: originPicker corner: cornerCreator