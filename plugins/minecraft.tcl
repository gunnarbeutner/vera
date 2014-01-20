# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_minecraft {nick arguments} {
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

	set minecraft [vera_db_getminecraft $account]

	if {[llength $arguments] < 1 || [vera_getaccount $nick] == $account} {
		if {$minecraft == ""} {
			vera_answer "I don't know your minecraft username."
		} else {
			vera_answer "Your Minecraft username is \"$minecraft\"."
		}
	} else {
		if {$minecraft == ""} {
			vera_answer "I don't know $user's minecraft username."
		} else {
			vera_answer "$user's minecraft username: $minecraft"
		}
	}
}

proc vera_setminecraft {nick arguments} {
	if {[llength $arguments] < 1} {
		vera_answer_direct "Syntax: setminecraft <username>"

		return
	}

	set minecraft [lindex $arguments 0]

	vera_db_setminecraft [vera_getaccount $nick] $minecraft
	vera_answer_direct "Done."
}

vera_register "minecraft" 2 0 "vera_minecraft" {
	/msg $::botnick minecraft ?user?
	Gets someone's minecraft username.
}

vera_register "setminecraft" 5 0 "vera_setminecraft" {
	/msg $::botnick setminecraft <username>
	Sets your minecraft username.
}
