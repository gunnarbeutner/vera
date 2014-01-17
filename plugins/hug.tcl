# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_hug {nick chan arguments} {
	if {[lindex $arguments 0] != ""} {
		putserv "PRIVMSG $chan :\001ACTION hugs [lindex $arguments 0]\001"
	} else {
		putserv "PRIVMSG $chan :\001ACTION hugs $nick\001"
	}

	vera_answer_direct "Done."
}

vera_register "hug" 3 1 "vera_hug" {
	/msg $::botnick hug ?channel? <nick>
	Hugs someone.
}
