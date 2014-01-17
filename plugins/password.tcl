# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_password {nick arguments} {
	set newpass [lindex $arguments 0]

	if {$newpass == ""} {
		vera_answer_direct "You need to specify a new password."
		return
	}

	if {[string length $newpass] < 6} {
		vera_answer_direct "Your new password is too short."
		return
	}

	vera_db_setpass [vera_getaccount $nick] $newpass

	vera_answer_direct "Done."
}

vera_register "password" 2 0 "vera_password" {
	/msg $::botnick password <new password>
	Sets your Intranet password.
}
