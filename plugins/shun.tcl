# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_shun {nick chan arguments} {
	global botnick

	set ban [lindex $arguments 0]
	set reason [join [lrange $arguments 1 end]]

	if {$ban == ""} {
		vera_answer_direct "You need to specify a nick or hostmask."
		return
	}

	set myaccount [vera_getaccount $nick]

	if {[onchan $ban $chan]} {
		if {[string equal -nocase $botnick $ban]} {
			vera_answer_direct "Sorry, you can't do that."
			return
		}

		set account [vera_getaccount $ban]

		if {$account != 0 && $account != ""} {
			if {[vera_getlevel $account] >= [vera_getlevel $myaccount]} {
				vera_answer_direct "Sorry, you can't shun that user."
				return
			}

			pushmode $chan -v $ban
			pushmode $chan -o $ban
			pushmode $chan +b "*!*@$account.users.quakenet.org"
		}

		if {[getchanhost $ban] != "" && ![string match "*@*.users.quakenet.org" [getchanhost $ban]]} {
			pushmode $chan +b [maskhost [getchanhost $ban]]
		}
	} elseif {[string match "*!*@*" $ban]} {
		foreach user [internalchanlist $chan] {
			set uhost "$user![getchanhost $user]"

			set account [vera_getaccount $user]

			if {$account != 0 && $account != "" && [string match -nocase $ban $uhost] && [vera_getlevel $account] >= [vera_getlevel $myaccount]} {
				vera_answer_direct "Sorry, that ban can't be set because it would affect known users."
				return
			}
		}

		pushmode $chan +b $ban
	} else {
		vera_answer_direct "$ban is neither a nick nor a hostmask."
	}
}

vera_register "shun" 3 1 "vera_shun"
