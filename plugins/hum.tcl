# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_hum {nick chan arguments} {
	putserv "PRIVMSG $chan :hum"

	vera_answer_direct "Done."
}

vera_register "hum" 3 1 "vera_hum" {
	/msg $::botnick hum ?channel?
	Hum!
}
