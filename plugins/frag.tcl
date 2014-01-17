# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_frag {nick chan arguments} {
	if {[lindex $arguments 0] != ""} {
		putserv "PRIVMSG $chan :\001ACTION takes her railgun and frags [lindex $arguments 0]\001"
	} else {
		putserv "PRIVMSG $chan :\001ACTION takes her railgun and frags $nick\001"
	}

	vera_answer_direct "Done."
}

vera_register "frag" 3 1 "vera_frag" {
	/msg $::botnick frag ?channel? <nick>
	Lets $::botnick frag someone.
}
