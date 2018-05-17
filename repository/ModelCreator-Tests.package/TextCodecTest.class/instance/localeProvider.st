private - accessing
localeProvider

	^FixedLocaleProvider providing: (
		MCPConfigurableLocale
			thousandsSeparator: (PluggableSeparator printing: $.)
			decimalSeparator: (PluggableSeparator printing: $,))