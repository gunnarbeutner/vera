# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_moo {nick chan arguments} {
	putserv "PRIVMSG $chan :mooooooo!"
}

vera_register "moo" 3 1 "vera_moo" {
	/msg $::botnick moo ?channel?
	Lets $::botnick moo on the specified channel.
}
