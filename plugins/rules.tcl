# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_rules {nick arguments} {
	foreach rule [vera_db_rules] {
		vera_answer_direct "\002[lindex $rule 0]\002 [lindex $rule 1]"
	}

	vera_answer_direct "End of RULES."
}

vera_register "rules" 2 0 "vera_rules" {
	/msg $::botnick rules
	Returns predefined rules which can be used as reasons for kick/ban.
}
