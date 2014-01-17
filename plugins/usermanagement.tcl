# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_add {nick arguments} {
	set user [lindex $arguments 0]
	set level [lindex $arguments 1]

	if {$level == ""} {
		vera_answer_direct "You need to specify an account and a level."
		return
	}

	if {![string is digit $level]} {
		vera_answer_direct "The level must be numeric. Use 'levels' to get a list of available levels."
		return
	}

	if {$level == 0} {
		vera_answer_direct "You cannot add a user with level 0."
		return
	}

	set account [vera_getaccount $user]

	if {[vera_getlevel $account] > 0} {
		vera_answer_direct "$user is already added as a [vera_db_gethrdesc [vera_db_getlevel $user]]."
		return
	}

	if {$account == "" || $account == 0} {
		vera_answer_direct "$user is not authed."
		return
	}

	set result [vera_db_addaccount $account $level]

	if {$result} {
		vera_answer_direct "$user was added as a [vera_db_gethrdesc $level]"
	} else {
		vera_answer_direct "ERROR: Could not add $user."
	}
}

proc vera_delete {nick arguments} {
	set user [lindex $arguments 0]

	if {$user == ""} {
		vera_answer_direct "You need to specify an account."
		return
	}

	set account [vera_getaccount $user]

	if {[vera_getlevel $account] == 0} {
		vera_answer_direct "$user does not exist in my database."
		return
	}

	if {$account == "" || $account == 0} {
		vera_answer_direct "$user is not authed."
		return
	}

	set result [vera_db_remaccount $account]

	if {$result} {
		vera_answer_direct "$user has been removed."
	} else {
		vera_answer_direct "ERROR: Could not remove $user."
	}
}

proc vera_modify {nick arguments} {
	set user [lindex $arguments 0]
	set level [lindex $arguments 1]

	if {$level == ""} {
		vera_answer_direct "You need to specify an account and a level."
		return
	}

	if {![string is digit $level]} {
		vera_answer_direct "The level must be numeric. Use 'levels' to get a list of available levels."
		return
	}

	if {$level == 0} {
		vera_answer_direct "You cannot remove a user that way, use 'remove' instead."
		return
	}

	set account [vera_getaccount $user]

	set reallevel [vera_db_getlevel $account]

	if {$reallevel == 0} {
		vera_answer_direct "$user does not exist. Use 'add' to add him/her."
		return
	}

	if {$reallevel == $level} {
		vera_answer_direct "$user is already a [vera_db_gethrdesc $level]. Nothing changed."
		return
	}

	set result [vera_db_modaccount $account $level]

	if {$result} {
		vera_answer_direct "$user has been modified."
	} else {
		vera_answer_direct "ERROR: Could not modify $user."
	}
}

proc vera_levels {nick arguments} {
	set levels [vera_db_levels]

	foreach level $levels {
		puthelp "NOTICE $nick :\002[lindex $level 0]\002 [lindex $level 1]"
	}
}

vera_register "add" 6 0 "vera_add" {
	/msg $::botnick add <account> <level>
	Adds a new user.
}

vera_register "delete" 6 0 "vera_delete" {
	/msg $::botnick delete <account>
	Removes a user.
}

vera_register "modify" 6 0 "vera_modify" {
	/msg $::botnick modify <account> <new level>
	Modifies a user's level.
}

vera_register "levels" 5 0 "vera_levels" {
	/msg $::botnick levels
	Gives the list of available user-levels.
}

