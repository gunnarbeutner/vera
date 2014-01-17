# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_dummy {nick arguments} {
	vera_answer_direct "Nothing done."
}

vera_register "dummy" 7 0 "vera_dummy" {
	/msg $::botnick dummy
	Just a template for new commands. 'dummy' does not do anything.
}
