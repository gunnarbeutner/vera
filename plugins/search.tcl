# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_search {nick arguments} {
	set word [lindex $arguments 0]

	if {$word == ""} {
		vera_answer_direct "You need to specify a query word."
	} else {
		set text [vera_db_search $word]

		if {$text == 0} {
			vera_answer_direct "Could not find that shorthelp trigger."
		} else {
			vera_answer_direct $text
		}
	}
}

vera_register "search" 2 0 "vera_search" {
	/msg $::botnick search <word>
	Searches the database of shorthelp triggers.
}
