# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_whois {nick arguments} {
	set user [lindex $arguments 0]

	if {$user == ""} {
		vera_answer_direct "You need to specify a nick."
		return
	}

	set account [vera_getaccount $user]

	if {$account == 0} {
		vera_answer "$user is not authed."
	} else {
		set level [vera_db_gethrdesc [vera_getlevel $account]]

		if {[lsearch -exact {a e i o u} [string index $level 0]] != -1} {
			set article "an"
		} else {
			set article "a"
		}

		set inviter [vera_db_getinviter $account]

		if {$inviter != ""} {
			set invited "(invited by $inviter)"
		} else {
			set invited ""
		}

		set createdinfo ""

		set created [vera_db_getcreated $account]

		if {$created > 0} {
			set createdinfo ", Created: [clock format $created]"
		}

		vera_answer "[vera_prettyuser $user] (Account: $account$createdinfo) is $article $level $invited"
	}
}

proc vera_whoami {nick arguments} {
	vera_whois $nick $nick
}

vera_register "whois" 2 0 "vera_whois" {
	/msg $::botnick whois <nick>
	Tells you who someone is.
}

vera_register "whoami" 2 0 "vera_whoami" {
	/msg $::botnick whoami
	Tells you what the bot thinks about who you are.
}
