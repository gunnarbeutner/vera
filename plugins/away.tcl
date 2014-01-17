# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_setaway {nick arguments} {
	vera_db_setaway [vera_getaccount $nick] $arguments

	if {$arguments != ""} {
		vera_answer_direct "You have been marked as being away."
	} else {
		vera_answer_direct "You are no longer marked as being away."
	}
}

proc vera_getaway {nick arguments} {
	if {[lindex $arguments 0] != ""} {
		set account [vera_getaccount [lindex $arguments 0]]
	} else {
		set account [vera_getaccount $nick]
	}

	set away [vera_db_getaway $account]

	if {$away == -1} {
		vera_answer_direct "No such user: $account"
	} else {
		if {[lindex $away 0] != 0} {
			vera_answer_direct "$account has been away since [clock format [lindex $away 0]]: [lindex $away 1]"
		} else {
			vera_answer_direct "$account is not marked as being away."
		}
	}
}

vera_register "setaway" 4 0 "vera_setaway"
vera_register "getaway" 4 0 "vera_getaway"
