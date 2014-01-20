# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_whoisknown {nick arguments} {
	set users [vera_db_users]
	set status ""

	set level 1

	while {$level < 15} {
		set status ""
		set desc [vera_db_gethrdesc $level]

		foreach user $users {
			if {[lindex $user 0] != $level} { continue }

			if {[vera_getnicks [lindex $user 1]] != ""} {
				lappend status "\002[lindex $user 1]\002"
			} else {
				lappend status [lindex $user 1]
			}

			if {[string length $status] > 300} {
				vera_answer_direct "$desc: [join $status]"
				set status ""
			}
		}

		if {$status != ""} {
			vera_answer_direct "$desc: [join $status]"
		}

		incr level
	}
}

vera_register "whoisknown" 3 0 "vera_whoisknown" {
	/msg $::botnick whoisknown
	Lists known users.
}
