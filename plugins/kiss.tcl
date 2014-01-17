# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_kiss {nick chan arguments} {
	if {[lindex $arguments 0] != "" && [onchan [lindex $arguments 0] $chan]} {
		putserv "PRIVMSG $chan :\001ACTION kisses [lindex $arguments 0] on the cheek\001"
	} else {
		putserv "PRIVMSG $chan :\001ACTION kisses $nick on the cheek\001"
	}

	vera_answer_direct "Done."
}

vera_register "kiss" 3 1 "vera_kiss" {
	/msg $::botnick kiss ?channel? <nick>
	Kisses the specified nick.
}
