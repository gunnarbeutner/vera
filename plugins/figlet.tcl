# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# (c) 2013 Uyttersprot Kim
# #help.script @ QuakeNet

proc vera_figlet {nick chan arguments} {
	if {[lindex $arguments 0] == "-l"} {
		vera_answer_direct "Available fonts:"

		set files [exec dpkg -L figlet]

		set fonts [list]

		foreach file $files {
			if {[string match "*.flf" $file]} {
				lappend fonts [lindex [split [lindex [split $file "/"] end] "."] 0]
			}

			if {[llength $fonts] >= 10} {
				vera_answer_direct [join $fonts]
				set fonts [list]
			}
		}

		if {[llength $fonts] > 0} {
			vera_answer_direct [join $fonts]
		}

		vera_answer_direct "End of FONTS."

		return
	}

	if {[lindex $arguments 0] == "-f"} {
		set font [lindex $arguments 1]
		set arguments [lrange $arguments 2 end]
	} else {
		set font "standard"
	}

	set word [join $arguments]
	regsub -all {[^A-Za-z0-9\.=\+\? ';,:()^]} $word "" word
	set output [string map [list " " "\xA0"] [exec figlet -f $font -w 140 $word]]

	foreach line [split $output \n] {
		set xline [string trim $line "\xA0"]

		if {[string length $xline] > 0} {
			puthelp "PRIVMSG $chan :$line"
		}
	}
}

vera_register "figlet" 3 1 "vera_figlet" {
	/msg $::botnick figlet ?channel? [-l] [-f font] <text>
	Formats the specified text using the `figlet' program.
	Use the -l option to list available fonts.
}
