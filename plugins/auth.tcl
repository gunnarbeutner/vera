# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

bind account - * vera_refresh_join

proc vera_auth {nick arguments} {
	set account [getchanlogin $nick]

	if {$account == 0 || $account == ""} {
		auth:enqueuewho $nick

		vera_answer_direct "Done."
	} else {
		vera_answer_direct "You are already authed as '$account'."
	}
}

proc vera_refresh_join {nick host hand chan} {
	set account [vera_getaccount $nick]

	if {$account == 0 || $account == ""} {
		return
	}

	if {[info procs vera_accesscheck] != ""} {
		vera_accesscheck $nick $chan
	}
}

proc vera_getchanlogin2 {nick} {
	foreach chan [channels] {
		set auth [getchanlogin $nick $chan]

		if {$auth != ""} { return $auth }
	}

	return ""
}

vera_register "auth" 0 0 "vera_auth" {
	/msg $::botnick auth
	Auths you as a user of the bot.
}
