# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_asc {nick arguments} {
	if {[lindex $arguments 0] != ""} {
		vera_answer "Ascii value of \"[string range [lindex $arguments 0] 0 0]\": [scan [lindex $arguments 0] "%c"]"
	} else {
		vera_answer_direct "You need to specify a character."
	}

	vera_answer_direct "Done."
}

vera_register "asc" 2 0 "vera_asc" {
	/msg $::botnick asc <character>
	Returns the ascii value of a character.
}
