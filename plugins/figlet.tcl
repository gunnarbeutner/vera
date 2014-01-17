# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_figlet {nick chan arguments} {
	set word [join $arguments]
	regsub -all {[^A-Za-z0-9\.=\+\? ';,:()^]} $word "" word
	set output [string map [list " " "\xA0"] [exec figlet -w 140 $word]]
	foreach line [split $output \n] {
		set xline [string trim $line "\xA0"]

		if {[string length $xline] > 0} {
			puthelp "PRIVMSG $chan :$line"
		}
	}
}

vera_register "figlet" 3 1 "vera_figlet"
