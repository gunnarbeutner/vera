# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_voice {nick chan arguments} {
	if {[llength $arguments] == 0} {
		lappend arguments $nick
	}

	foreach unick [chanlist $chan] {
		foreach argument $arguments {
			if {![string match -nocase $argument $unick] && ![string equal -nocase $argument $unick]} {
				continue
			}

			if {![isvoice $unick $chan]} {
				pushmode $chan +v $unick
			}
		}
	}

	vera_answer_direct "Done."
}

proc vera_devoice {nick chan arguments} {
	if {[llength $arguments] == 0} {
		lappend arguments $nick
	}

	foreach unick [chanlist $chan] {
		foreach argument $arguments {
			if {![string match -nocase $argument $unick] && ![string equal -nocase $argument $unick]} {
				continue
			}

			if {[isvoice $unick $chan]} {
				pushmode $chan -v $unick
			}
		}
	}

	vera_answer_direct "Done."
}

vera_register "voice" 3 1 "vera_voice" {
	/msg $::botnick op ?channel? [nick]
	Voices you or the specified user in a channel.
}

vera_register "devoice" 3 1 "vera_devoice" {
	/msg $::botnick devoice ?channel? [nick]
	Devoices you or the specified user in a channel.
}
