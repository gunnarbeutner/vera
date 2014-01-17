# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_fish {nick chan arguments} {
	if {[lindex $arguments 0] != ""} {
		putserv "PRIVMSG $chan :\001ACTION slaps [lindex $arguments 0] with a fish\001"
	} else {
		putserv "PRIVMSG $chan :\001ACTION slaps $nick with a fish\001"
	}

	vera_answer_direct "Done."
}

vera_register "fish" 3 1 "vera_fish" {
	/msg $::botnick fish ?channel? <nick>
	Slaps someone with a fish.
}
