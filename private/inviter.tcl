# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_setinviter {nick arguments} {
	if {[vera_getlevel [vera_getaccount $nick]] >= 6} {
		if {[llength $arguments] < 2} {
			vera_answer_direct "You need to specify an account and an inviter."
			return
		}

		set user [lindex $arguments 0]
		set inviter [lindex $arguments 1]
	} else {
		if {[llength $arguments] > 1} {
			vera_answer_direct "You cannot set the inviter for another user."
			return
		}

		if {[llength $arguments] < 1} {
			vera_answer_direct "You need to specify an inviter."
			return
		}

		if {[string equal -nocase $nick [lindex $arguments 0]]} {
			vera_answer_direct "You can't invite yourself."
			return
		}

		set user $nick
		set inviter [lindex $arguments 0]
	}

	set account [vera_getaccount $user]
	set account_inviter [vera_getaccount $inviter]

	if {[vera_getlevel $account] == 0} {
		vera_answer_direct "The user you specified ($user) does not exist."
		return
	}

	if {[vera_getlevel $account_inviter] == 0} {
		vera_answer_direct "The user you specified ($inviter) does not exist."
		return
	}

	vera_db_setinviter $account $account_inviter
	vera_answer_direct "Done."

	exec /home/sbflbot/graph/sbflgraph.sh &
}

vera_register "setinviter" 2 0 "vera_setinviter"
