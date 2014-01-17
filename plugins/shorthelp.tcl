# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_addterm {nick arguments} {
	set term [lindex $arguments 0]
	set text [join [lrange $arguments 1 end]]

	if {$term == ""} {
		vera_answer_direct "You need to specify a term."
		return
	}

	if {$text == ""} {
		vera_answer_direct "You need to specify some text for the term."
		return
	}

	vera_db_addshorthelp $term $text
	vera_answer_direct "Done."
}

proc vera_delterm {nick arguments} {
	set term [lindex $arguments 0]

	if {$term == ""} {
		vera_answer_direct "You need to specify a term."
		return
	}

	if {[vera_db_shorthelp $term] != 0} {
		vera_db_delshorthelp $term
		vera_answer_direct "Done."
	} else {
		vera_answer_direct "There is no such term."
	}
}

proc vera_getterm {nick arguments} {
	set term [lindex $arguments 0]

	if {$term != ""} {
		set text [vera_db_shorthelp $term]

		if {$text != 0} {
			vera_answer_direct "\002$term\002: $text"
		} else {
			vera_answer_direct "There is no such term."
		}
	} else {
		vera_answer_direct "You need to specify a term."
	}
}

vera_register "addterm" 4 0 "vera_addterm" {
	/msg $::botnick addterm <term> <text>
	Adds a term to the shorthelp database.
}

vera_register "delterm" 4 0 "vera_delterm" {
	/msg $::botnick delterm <term>
	Removes a term from the shorthelp database.
}

vera_register "getterm" 4 0 "vera_getterm" {
	msg $::botnick getterm <term>
	Shows you the text of a shorthelp term.
}
