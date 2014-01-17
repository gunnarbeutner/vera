# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_warn {nick chan arguments} {
	global vera_warn botnick

	set user [lindex $arguments 0]

	if {$user == ""} {
		vera_answer_direct "You need to specify a nick."
		return
	}

	if {![onchan $user $chan]} {
		vera_answer_direct "$user is not on $chan."
		return
	}

	if {[string equal -nocase $botnick $user]} {
		vera_answer_direct "Sorry, you can't do that."
		return
	}

	set account [vera_getaccount $user]
	set myaccount [vera_getaccount $nick]
	set reason [vera_db_getrule [join [lrange $arguments 1 end]]]

	if {$account == 0 || $account == ""} {
		vera_answer_direct "$user is not authed. Can't warn him. Use kick instead."
		return
	}

	if {[vera_getlevel $account] >= [vera_getlevel $myaccount]} {
		vera_answer_direct "Sorry, you can't warn that user."
		return
	}

	if {![info exists vera_warn(${chan}::$account)]} {
		set vera_warn(${chan}::$account) 1
	} else {
		incr vera_warn(${chan}::$account)
	}

	putserv "NOTICE $user :$reason ($vera_warn(${chan}::$account)/3)"

	if {$vera_warn(${chan}::$account) >= 3} {
		vera_answer_direct "User has been warned three times. Kicking."
		putkick $chan $user
		unset vera_warn(${chan}::$account)
	} else {
		vera_answer_direct "User has been warned: $reason ($vera_warn(${chan}::$account)/3)"
	}
}

vera_register "warn" 3 1 "vera_warn" {
	/msg $::botnick warn ?channel? <nick> [reason]
	Warns a user. The user gets kicked after the third warning.
}
