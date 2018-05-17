tests
pointCreatorFrom: cornerXView and: cornerYView

	^ (GenericModelCreatorBuilder named: 'corner' building: Point accessedUsing: #(x y)) x: (self numberCodecFor: cornerXView) y: (self numberCodecFor: cornerYView)