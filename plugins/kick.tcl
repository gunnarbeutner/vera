# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_kick {nick chan arguments} {
	global botnick

	set victim [lindex $arguments 0]
	set reason [join [lrange $arguments 1 end]]

	if {$victim == ""} {
		vera_answer_direct "You need to specify a nick."
		return
	}

	if {[string equal -nocase $botnick $victim]} {
		vera_answer_direct "Sorry, you can't do that."
		return
	}

	if {![onchan $victim $chan]} {
		vera_answer_direct "$victim is not on $chan."
		return
	}

	set account [vera_getaccount $victim]
	set myaccount [vera_getaccount $nick]

	if {$account != "" && $account != 0 && [vera_getlevel $account] >= [vera_getlevel $myaccount]} {
		vera_answer_direct "Sorry, you can't kick that user."
		return
	}

	putkick $chan $victim [vera_db_getrule $reason]
}

vera_register "kick" 3 1 "vera_kick" {
	/msg $::botnick kick ?channel? <host/nick> [reason]
	Kicks the specified user.
}
