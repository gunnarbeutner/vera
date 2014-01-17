# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_showhelp {nick topic} {
	set node [vera_getcomnode $topic]
	set text ""

	if {$node != -1} {
		set text [lindex $node 4]
	}

	if {$text == ""} {
		set text "No help available for $topic"
	}

	foreach line [split $text "\n"] {
		if {$line == ""} {
			continue
		}

		puthelp "NOTICE $nick :[subst -nobackslashes -nocommands [string trim $line]]"
	}
}

proc vera_help {nick arguments} {
	global vera_commands

	set level [vera_getlevel [vera_getaccount $nick]]
	set topic [lindex $arguments 0]

	if {$topic != ""} {
		set node [vera_getcomnode $topic]

		if {$node == -1 || [lindex $node 1] > $level} {
			puthelp "NOTICE $nick :No such command."
		} else {
			vera_showhelp $nick $topic
		}

		return
	}

	set i 0

	while {$i <= $level} {
		set available ""
		set desc [vera_db_gethrdesc $i]

		foreach cmd $vera_commands {
			if {[lindex $cmd 1] == $i} {
				lappend available [lindex $cmd 0]
			}
		}

		if {$available != ""} {
			vera_answer_direct "$desc: [join $available]"
		}

		incr i
	}
}

proc vera_commands {nick arguments} {
	global vera_commands

	set i 0

	while {$i <= 6} {
		foreach cmd $vera_commands {
			if {[lindex $cmd 1] == $i} {
				puthelp "NOTICE $nick :[lindex $cmd 0] - level [lindex $cmd 1]"
			}
		}

		puthelp "NOTICE $nick :-----"

		incr i
	}

	puthelp "NOTICE $nick :End of COMMANDS."
}

vera_register "help" 0 0 "vera_help" {
	/msg $::botnick help [command]
	Gives a list of available commands and shows help for individual commands.
}

vera_register "commands" 6 0 "vera_commands" {
	/msg $::botnick commands
	Lists all available commands including their respective level.
}
