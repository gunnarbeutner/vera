# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_op {nick chan arguments} {
	if {[llength $arguments] == 0} {
		lappend arguments $nick
	}

	foreach unick [chanlist $chan] {
		foreach argument $arguments {
			if {![string match -nocase $argument $unick] && ![string equal -nocase $argument $unick]} {
				continue
			}

			if {![isop $unick $chan]} {
				pushmode $chan +o $unick
			}
		}
	}

	vera_answer_direct "Done."
}

proc vera_deop {nick chan arguments} {
	global botnick

	if {[llength $arguments] == 0} {
		lappend arguments $nick
	}

	foreach unick [chanlist $chan] {
		foreach argument $arguments {
			if {![string match -nocase $argument $unick] && ![string equal -nocase $argument $unick]} {
				continue
			}

			if {[string equal -nocase $unick $botnick]} {
				vera_answer_direct "No, i won't deop myself."

				continue
			}

			if {[isop $unick $chan]} {
				pushmode $chan -o $unick
			}
		}
	}

	vera_answer_direct "Done."
}

vera_register "op" 5 1 "vera_op" {
	/msg $::botnick op ?channel? [nick]
	Ops you or the specified user in a channel. Wildcards may be used.
}

vera_register "deop" 5 1 "vera_deop" {
	/msg $::botnick deop ?channel? [nick]
	Deops you or the specified user in a channel. Wildcards may be used.
}
