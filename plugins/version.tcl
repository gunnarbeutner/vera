# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_version {nick arguments} {
	global vera_version

	if {[vera_getlevel $nick] > 0} {
		vera_answer "I'm Vera, Dana's sister, Version $vera_version, coded by BlackShroud"
	} else {
		vera_answer_direct "I'm Vera, Dana's sister, Version $vera_version, coded by BlackShroud"
	}
}

vera_register "version" 0 0 "vera_version" {
	/msg $::botnick version
	Tells you the version of $::botnick.
}
