private - accessing
selectablePoints

	^ #(1 2 3) collect: [ :number | UISelectableModel representing: number @ number with: ('<1p>@<1p>' expandMacrosWith: number) ]