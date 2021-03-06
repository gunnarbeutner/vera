# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_ban {nick chan arguments} {
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
				vera_answer_direct "Sorry, you can't ban that user."
				return
			}

			pushmode $chan +b "*!*@$account.users.quakenet.org"
			newchanban $chan "*!*@$account.users.quakenet.org" $myaccount [vera_db_getrule $reason] 0
			vera_answer_direct "Added ban: \002*!*@$account.users.quakenet.org\002, Reason: \002[vera_db_getrule $reason]\002"
		}

		if {[getchanhost $ban] != "" && ![string match "*@*.users.quakenet.org" [getchanhost $ban]]} {
			pushmode $chan +b [maskhost [getchanhost $ban]]
			newchanban $chan [maskhost [getchanhost $ban]] $myaccount [vera_db_getrule $reason] 0
			vera_answer_direct "Added ban: \002[maskhost [getchanhost $ban]]\002, Reason: \002[vera_db_getrule $reason]\002"

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

		newchanban $chan $ban $myaccount [vera_db_getrule $reason] 0
		vera_answer_direct "Nobody matching \002$ban\002 on $chan, adding to internal banlist\, Reason: \002[vera_db_getrule $reason]\002"
		vera_answer_direct "\002Warning:\002 People matching this host will be kickbanned on join."
	} else {
		vera_answer_direct "$ban is neither a nick nor a hostmask."
	}
}

proc vera_bans {nick chan arguments} {
	set i 0

	puthelp "NOTICE $nick :Chanbans:"

	foreach ban [chanbans $chan] {
		incr i
		puthelp "NOTICE $nick :\002[lindex $ban 0]\002 set by [lindex [split [lindex $ban 1] !] 0] [duration [lindex $ban 2]] ago"
	}

	puthelp "NOTICE $nick :Botbans:"

	foreach ban [banlist $chan] {
		incr i
		puthelp "NOTICE $nick :\002[lindex $ban 0]\002 set by [lindex $ban 5]: [lindex $ban 1]"
	}

	puthelp "NOTICE $nick :End of BANS."
}

proc vera_unban {nick chan arguments} {
	global botnick

	set ban [lindex $arguments 0]
	set iban [lindex $arguments 0]
	set bans [banlist $chan]

	if {$ban == ""} {
		set ban [lindex [lindex [chanbans $chan] [expr [llength [chanbans $chan]] - 1]] 0]
	}

	set ban [lindex [chanbans $chan] [lsearch [chanbans $chan] "$ban *"]]

	if {$ban == ""} {
		set ban [lindex [lindex [banlist $chan] [lsearch [banlist $chan] "$ban *"]] 0]
	}

	if {$ban == "" && [lsearch -index 0 -exact $bans $iban] == -1} {
		vera_answer_direct "There is no such ban set on $chan"
		return
	}
        if {$ban == "" && [lsearch -index 0 -exact $bans $iban] != -1} {
                killchanban $chan [lindex $iban 0]
                vera_answer_direct "Removed ban: \002[lindex $iban 0]\002 from the internal banlist for \002$chan\002"
	} else {
		killchanban $chan [lindex $ban 0]
		pushmode $chan -b [lindex $ban 0]

		vera_answer_direct "Done."
	}


}


proc vera_unbanall {nick chan arguments} {
	puthelp "MODE $chan +b-b *!*@* *!*@*"

	vera_answer_direct "Done."
}

vera_register "ban" 3 1 "vera_ban" {
	/msg $::botnick ban ?channel? <host/nick> [reason]
	Bans the specified hostmask/nick.
}

vera_register "out" 3 1 "vera_ban" {
        /msg $::botnick out ?channel? <host/nick> [reason]
        Bans the specified hostmask/nick.
}


vera_register "bans" 3 1 "vera_bans" {
	/msg $::botnick bans ?channel?
	Gives the list of bans on a channel.
}

vera_register "unban" 3 1 "vera_unban" {
	/msg $::botnick unban ?channel? <mask/#nr>
	Removes a channel ban. You can either specify the mask or the ordinal number of the ban. Use the 'bans' function to retrieve a list of bans.
}

vera_register "unbanall" 3 1 "vera_unbanall" {
	/msg $::botnick unbanall ?channel?
	Removes all bans on a specific channel.
}

