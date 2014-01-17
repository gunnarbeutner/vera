# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_fortune {nick arguments} {
	set fortune [exec -- /usr/games/fortune]

	foreach line [split $fortune \n] {
		vera_answer "$line"
	}
}

vera_register "fortune" 3 0 "vera_fortune" {
	/msg $::botnick fortune
	Returns a random fortune. Warning: Some of the fortunes might be offensive. Use with care.
}
