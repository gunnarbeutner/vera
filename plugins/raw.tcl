# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_raw {nick arguments} {
	set numeric [lindex $arguments 0]

	if {$numeric == ""} {
		vera_answer_direct "You need to specify a numeric."
	} else {
		set text [vera_db_getraw $numeric]

		if {$text == ""} {
			vera_answer_direct "Could not find that raw event."
		} else {
			vera_answer $text
		}
	}
}

vera_register "raw" 2 0 "vera_raw" {
	/msg $::botnick raw <numeric>
	Returns information about the specified raw event.
}
