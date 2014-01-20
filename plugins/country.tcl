# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_country {nick arguments} {
	set tld [string tolower [lindex $arguments 0]]

	if {$tld != ""} {
		vera_answer "$tld is \"[vera_db_tld2country $tld]\""
	} else {
		vera_answer_direct "You need to specify a TLD."
	}
}

proc vera_setcountry {nick arguments} {
	if {[vera_getlevel [vera_getaccount $nick]] >= 6} {
		if {[llength $arguments] < 2} {
			vera_answer_direct "You need to specify an account and a country code."
			return
		}

		set user [lindex $arguments 0]
		set tld [lindex $arguments 1]
	} else {
		if {[llength $arguments] > 1} {
			vera_answer_direct "You cannot set the country for another user."
			return
		}

		if {[llength $arguments] < 1} {
			vera_answer_direct "You need to specify a country code."
			return
		}

		set user $nick
		set tld [lindex $arguments 0]
	}

	set account [vera_getaccount $user]

	if {[vera_getlevel $account] == 0} {
		vera_answer_direct "The user you specified ($user) does not exist."
		return
	}

	if {$tld == "none"} {
		set tld ""
	} else {
		set country [vera_db_tld2country $tld]

		if {$country == "unknown"} {
			vera_answer_direct "The country code you specified is invalid."
			return
		}
	}

	vera_db_setcountry $account $tld
	vera_answer_direct "Done."
}

vera_register "country" 2 0 "vera_country"
vera_register "setcountry" 2 0 "vera_setcountry"
