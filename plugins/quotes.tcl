# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_quotes {nick arguments} {
	set quotes [vera_db_getquotes]

	foreach quote $quotes {
		set text "Quote #[lindex $quote 0] (added by [lindex $quote 1]): [lindex $quote 2]"

		if {[vera_getlevel [vera_getaccount $nick]] > 0} {
			vera_answer $text
		} else {
			vera_answer_direct $text
		}
	}

	vera_answer_direct "Done."
}

proc vera_quote {nick arguments} {
	if {[lindex $arguments 0] == ""} {
		set count [vera_db_countquotes]
		set idx [rand [expr $count + 1]]
		if {$idx == 0} { set idx 1 }

		set quote [vera_db_getquotebynum $idx]
	} else {
		set idx [lindex $arguments 0]

		if {![string is digit $idx]} {
			vera_answer_direct "The # of the quote has to be numeric."
			return
		}

		set quote [vera_db_getquotebyid $idx]
	}

	if {$quote != 0} {
		set txt "Quote #[lindex $quote 0] (added by [lindex $quote 1]): [lindex $quote 2]"
	} else {
		vera_answer_direct "There is no such quote."
		return
	}

	if {[vera_getlevel [vera_getaccount $nick]] > 0} {
		vera_answer $txt
	} else {
		vera_answer_direct $txt
	}
}

proc vera_addquote {nick arguments} {
	if {[lindex $arguments 0] == ""} {
		vera_answer_direct "You need to specify a quote."
	} else {
		vera_db_addquote [vera_getaccount $nick] [join $arguments]
		vera_answer_direct "Done."
	}
}

proc vera_delquote {nick arguments} {
	set idx [lindex $arguments 0]

	if {![string is digit $idx]} {
		vera_answer_direct "The # of the quote has to be numeric."
		return
	}

	set quote [vera_db_getquotebyid $idx]

	if {$quote == 0} {
		vera_answer_direct "There is no such quote."
	} else {
		vera_answer "Quote #[lindex $quote 0] (added by [lindex $quote 1]) was: [lindex $quote 2]"
		vera_db_delquote $idx
		vera_answer_direct "Done."
	}
}

vera_register "quote" 3 0 "vera_quote"
vera_register "quotes" 0 0 "vera_quotes"
vera_register "addquote" 3 0 "vera_addquote"
vera_register "delquote" 5 0 "vera_delquote"
