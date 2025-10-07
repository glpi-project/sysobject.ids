
test: sysobject.ids
	@perl test.pl sysobject.ids && echo VALIDATION: OK || ( echo VALIDATION: NOT OK; false)
