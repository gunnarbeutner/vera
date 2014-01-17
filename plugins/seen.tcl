# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_seen {nick arguments} {
	set user [lindex $arguments 0]

	if {$user == ""} {
		vera_answer_direct "You need to specify a user."
		return
	}

	set account [vera_getaccount $user]

	if {[vera_getlevel $account] == 0} {
		vera_answer_direct "$user is not known."
	} else {
		set seen [vera_db_seen $account]

		if {$seen == 0} {
			vera_answer "I haven't seen $user so far."
		} else {
			vera_answer "$user was last seen [join [lrange [split [duration [expr {[clock seconds] - $seen}]]] 0 3]] ago (on [clock format $seen])."
		}
	}
}

vera_register "seen" 0 0 "vera_seen" {
	/msg $::botnick seen <account>
	Tells you when someone was last seen by the bot. Note that joins/parts don't reset the seen-counter, just msgs do.
}
