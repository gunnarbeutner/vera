# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

bind pubm -|- * vera_intern_rating
bind time -|- "00 00 * * *" vera_intern_resetday

proc vera_intern_resetday {m h d mo y} {
	set users [vera_db_users]

	foreach user $users {
		vera_db_setrate [lindex $user 1] 0
	}
}

proc vera_intern_rating {nick host hand chan text} {
	set account [vera_getaccount $nick]
	set level [vera_getlevel $account]

	if {$level > 0} {
		set rate [vera_db_getrateday $account]

		set seen [vera_db_seen $account]

		if {[expr [unixtime] - $seen] > 600} {
			set val 120
		} else {
			set val [expr [unixtime] - $seen]
		}

		incr rate $val

		vera_db_setrate $account $rate
		vera_db_setnick $account $nick
	}
}

proc vera_rating {nick arguments} {
	set user [lindex $arguments 0]

	if {$user != ""} {
		set account [vera_getaccount $user]

		if {[vera_getlevel $account] == 0} {
			vera_answer_direct "There's no such user."
			return
		}

		if {[vera_getlevel [vera_getaccount $nick]] <= [vera_getlevel $account]} {
			vera_answer_direct "You cannot view that user's rating."
			return
		}
	} else {
		set account [vera_getaccount $nick]
	}

	set rate [vera_db_getrateday $account]
	set rateweek [vera_db_getrateweek $account]
	set rweek 0

	foreach day $rateweek {
		incr rweek $day
	}

	vera_answer_direct "Today's rating: [duration $rate] This week's rating: [duration $rweek]"
}

vera_register "rating" 2 0 "vera_rating" {
	/msg $::botnick rating [account]
	Shows your or someone else's rating.
}
