# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_give {nick chan arguments} {
	if {[lindex $arguments 1] != "" && [onchan [lindex $arguments 0] $chan]} {
		putserv "PRIVMSG $chan :\001ACTION gives [join $arguments]\001"
	} else {
		vera_answer_direct "You need to specify a valid nick and an item."
		return
	}

	vera_answer_direct "Done."
}

vera_register "give" 3 1 "vera_give" {
	/msg $::botnick give ?channel? <nick> <item>
	Gives someone something.
}
