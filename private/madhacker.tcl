# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_madhacker {nick chan arguments} {
	putmsg $chan "╔══════╗"
	putmsg $chan "║      ║"
	putmsg $chan "║      ║"
	putmsg $chan "║      ║"
	putmsg $chan "║     O║ ──────┐"
	putmsg $chan "║      ║       │"
	putmsg $chan "║      ║      _│_"
	putmsg $chan "╚══════╝      \\ /"
	putmsg $chan "               v"
	putmsg $chan " "
	putmsg $chan "              O"
	putmsg $chan "            |/_"
	putmsg $chan "           _/"
	putmsg $chan "            | "

	vera_answer_direct "Done."
}

vera_register "madhacker" 6 1 "vera_madhacker" {
	/msg $::botnick madhacker ?channel?
	Posts the MadHacker ASCII art.
}
