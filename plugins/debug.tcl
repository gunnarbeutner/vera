# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_tcl {nick arguments} {
	catch {eval [join $arguments]} result

	if {$result == ""} { set result "<null>" }

	foreach sline [split $result \n] {
		vera_answer "( [join $arguments] ) = $sline"
	}
}

vera_register "tcl" 7 0 "vera_tcl" {
	/msg $::botnick tcl <code>
	Executes arbitrary tcl commands.
}
