private - accessing
selectableDiscounts

	^ #(10 15 20)
		collect: [ :number | 
			UISelectableModel
				representing: (Percentage of: number)
				with: ('<1p> %2' expandMacrosWith: number) ]