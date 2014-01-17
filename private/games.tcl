# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_helper_invalidgame {} {
	vera_answer_direct "Sorry, I don't know that game. The following games are known (ask someone with database access to add more):"

	set out [list]
	set games [vera_db_games]

	foreach game $games {
		set description "\002[lindex $game 0]\002"

		if {[lindex $game 1] != ""} {
			append description " ([lindex $game 1])"
		}

		lappend out $description

		if {[string length [join $out ", "]] > 100} {
			vera_answer_direct [join $out ", "]
			set out [list]
		}
	}

	if {[llength $out] > 0} {
		vera_answer_direct [join $out ", "]
	}

	if {[llength $games] == 0} {
		vera_answer_direct "\002(No games.)\002"
	}
}

proc vera_addgame {nick arguments} {
	set games [vera_db_games]

	set game [join $arguments]

	if {$game == ""} {
		vera_helper_invalidgame
		vera_answer_direct "End of ADDGAME."

		return
	}

	set game [vera_db_resolvegame $game]

	if {$game == 0} {
		vera_helper_invalidgame
		vera_answer_direct "End of ADDGAME."

		return
	}

	vera_db_delgame_user [vera_getaccount $nick] $game
	vera_db_addgame_user [vera_getaccount $nick] $game

	vera_answer_direct "'$game' was added to your list of games."
}

proc vera_delgame {nick arguments} {
	set game [join $arguments]

	if {$game == ""} {
		vera_answer_direct "You need to specify a game."
		return
	}

	if {$game == "bindi"} {
		vera_answer_direct "Sorry, no can do. :D"
		return
	}

	set game [vera_db_resolvegame $game]

	if {$game == 0} {
		vera_helper_invalidgame
		vera_answer_direct "End of DELGAME."

		return
	}

	vera_db_delgame_user [vera_getaccount $nick] $game

	vera_answer_direct "'$game' was removed from your list of games."
}

proc vera_highlight {nick channel arguments} {
	set game [join $arguments]

	if {$game == ""} {
		vera_answer_direct "You need to specify a game."
		return
	}

	set game [vera_db_resolvegame $game]

	if {$game == 0} {
		vera_helper_invalidgame
		vera_answer_direct "End of HIGHLIGHT."

		return
	}

	set hlusers [list]

	foreach user [vera_db_getusers_game $game] {
		foreach hnick [internalchanlist $channel] {
			if {[vera_getaccount $hnick] == $user} {
				lappend hlusers $hnick
			}
		}
	}

	if {[llength $hlusers] == 0} {
		vera_answer_direct "Sorry, there's nobody to highlight."

		return
	}

	putmsg $channel "Highlighting users for '\002$game\002' (requested by \002$nick\002):"

	while {[llength $hlusers] > 0} {
		putmsg $channel [join [lrange $hlusers 0 9] ", "]
		set hlusers [lrange $hlusers 10 end]
	}

	vera_answer_direct "Done."
}

proc vera_games {nick arguments} {
	set user [lindex $arguments 0]

	if {$user == ""} {
		set user $nick
	}

	if {[vera_getaccount $user] == 0} {
		vera_answer_direct "User '$user' is not authed."

		return
	}

	vera_answer "'$user' is subscribed to receive notices about the following games:"

	set out [list]
	set games [vera_db_getgames_user [vera_getaccount $user]]

	foreach game $games {
		lappend out $game

		if {[string length [join $out ", "]] > 100} {
			vera_answer "\002[join $out ", "]\002"
			set out [list]
		}
	}

	if {[llength $out] > 0} {
		vera_answer "\002[join $out ", "]\002"
	}

	if {[llength $games] == 0} {
		vera_answer "(No games.)"
	}

	vera_answer_direct "Done."
}

vera_register "addgame" 2 0 "vera_addgame"
vera_register "delgame" 2 0 "vera_delgame"
vera_register "hl" 3 1 "vera_highlight"
vera_register "games" 2 0 "vera_games"
