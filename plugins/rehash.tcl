# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_rehash {nick arguments} {
	rehash

	vera_answer_direct "Done."
}

proc vera_restart {nick arguments} {
	vera_answer_direct "Done."

	restart
}

vera_register "rehash" 7 0 "vera_rehash" {
	/msg $::botnick rehash
	Reloads the bot's scripts.
}

vera_register "restart" 7 0 "vera_restart" {
	/msg $::botnick restart
	Restarts the bot.
}
