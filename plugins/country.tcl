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

vera_register "country" 2 0 "vera_country"
