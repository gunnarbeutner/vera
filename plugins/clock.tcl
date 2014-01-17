# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_clock {nick arguments} {
	vera_answer_direct "It's [clock format [unixtime]]"
}

vera_register "clock" 0 0 "vera_clock" {
	/msg $::botnick clock
	Shows the current time.
}
