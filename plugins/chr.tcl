# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_chr {nick arguments} {
	if {[lindex $arguments 0] != ""} {
		if {[string is digit [lindex $arguments 0]]} {
			vera_answer "Character for Ascii \"[lindex $arguments 0]\": [format "%c" [lindex $arguments 0]]"
		} else {
			vera_answer_direct "You need to specify a number, which represents an Ascii value."
		}
	} else {
		vera_answer_direct "You need to specify an Ascii value."
	}
}

vera_register "chr" 2 0 "vera_chr" {
	/msg $::botnick chr <ascii>
	Returns the character for an ascii value.
}
