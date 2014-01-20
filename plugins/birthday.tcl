# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

bind time - "00 *" vera_announcebirthday
set ::birthdayannouncechans [list "#sbfl"]

proc vera_splittopic {topic} {
	set sections ""
	set topic [split $topic |]
	foreach section $topic {
		set section [string trim $section]
		if {$section == ""} { continue }
		lappend sections $section
	}
	return $sections
}

proc vera_announcebirthday {args} {
	# reset info
	set announces {}
	foreach chan $::birthdayannouncechans {
		dict set announces $chan {}
	}
	# add nicks to channel announce lists
	foreach user [vera_db_users] {
		lassign $user level account
		if {$level < 2 || $account eq "" || $account eq "0"} {
			continue
		}
		foreach nick [vera_getnicks $account] {
			foreach chan $::birthdayannouncechans {
				set bd [vera_db_getbirthday $account]
				if {[onchan $nick $chan] && $bd ne "" && [clock format [clock seconds] -format "%m-%d"] eq [clock format $bd -format "%m-%d"]} {
					dict lappend announces $chan "$nick ([yearsBetween $bd [clock seconds]])"
				}
			}
		}
	}
	# announce/remove old entry
	dict for {chan nicks} $announces {
		set change 0
		set topicsections [vera_splittopic [vera_db_gettopic $chan]]
		set pos [lsearch -glob $topicsections {Happy Birthday *}]
		if {$pos > -1} {
			set topicsections [lreplace $topicsections $pos $pos]
			set change 1
		}
		if {[llength $nicks]} {
			lappend topicsections "Happy Birthday [join $nicks {, }]!"
			set change 1
		}
		# hard-coded topic set nickname (?)
		if {$change} {
			set topic [join $topicsections " | "]
			vera_db_settopic $chan $topic
			puthelp "TOPIC $chan :$topic"
		}
	}
}

# yearsBetween --
#
# Returns the years elapsed between two given timestamps
#
# Arguments:
#  oldertime
#  newertime
proc yearsBetween {oldertime newertime} {
	set i 1

	if {$oldertime > $newertime} {
		set temp $newertime
		set newertime $oldertime
		set oldertime $temp
	}

	while {$oldertime <= [clock scan "$i year ago" -base $newertime]} {
		incr i
	}

	return [expr {$i - 1}]
}

proc vera_birthday {nick arguments} {
	if {[llength $arguments] < 1} {
		set user $nick
	} else {
		set user [lindex $arguments 0]
	}

	set account [vera_getaccount $user]

	if {$account == 0 || $account == ""} {
		vera_answer "I don't know that user."

		return
	}

	set birthday [vera_db_getbirthday $account]

	if {$account == "bindi"} {
		set birthday [expr [clock seconds] - 379476640]
	}

	if {[llength $arguments] < 1 || [vera_getaccount $nick] == $account} {
		if {$birthday == ""} {
			vera_answer "I don't know your birthday."
		} else {
			vera_answer "You were born on [clock format $birthday -format "%A %B %d %Y"]."
		}
	} else {
		if {$birthday == ""} {
			vera_answer "I don't know $user's birthday."
		} else {
			vera_answer "$user was born on [clock format $birthday -format "%A %B %d %Y"] and is [yearsBetween $birthday [clock seconds]] years old."
		}
	}
}

proc vera_setbirthday {nick arguments} {
	if {[llength $arguments] < 1} {
		vera_answer_direct "Syntax: setbirthday <yyyy-mm-dd>"

		return
	}

	if {[catch [list clock scan [lindex $arguments 0] -format "%Y-%m-%d"] birthday]} {
		vera_answer_direct "Invalid date format. Should be YYYY-MM-DD."

		return
	}

	vera_db_setbirthday [vera_getaccount $nick] $birthday
	vera_answer_direct "Done."
}

vera_register "birthday" 2 0 "vera_birthday" {
	/msg $::botnick birthday ?user?
	Gets someone's birthday.
}

vera_register "setbirthday" 5 0 "vera_setbirthday" {
	/msg $::botnick setbirthday <yyyy-mm-dd>
	Sets your birthday.
}
