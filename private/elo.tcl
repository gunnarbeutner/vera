proc elo_get_score {account} {
	global vera_connection

	set result [mysqlsel $vera_connection "SELECT elo_score FROM users WHERE account = '[mysqlescape $account]'" -list]
	return [lindex $result 0]
}

proc elo_get_accountid {name} {
	global vera_connection

	set result [mysqlsel $vera_connection "SELECT id FROM users WHERE account = '[mysqlescape $name]'" -list]

	if {[llength $result] > 0} {
		set user [lindex $result 0]
		return [lindex $user 0]
	}

	return -1
}

proc elo_update_scores {} {
	global vera_connection

	mysqlexec $vera_connection "UPDATE users SET elo_score = 1000"

	# TODO: figure out kfactor depending on number of games...
	set kfactor1 15
	set kfactor2 15

	set result [mysqlsel $vera_connection "SELECT id, player1, player2, player1result AS result FROM elo_game WHERE (player1result IS NOT NULL AND player2result IS NOT NULL) ORDER BY date ASC" -list]

	foreach game $result {
		set id [lindex $game 0]
		set player1 [lindex $game 1]
		set player2 [lindex $game 2]
		set result [lindex $game 3]

		if {![info exists scores($player1)]} {
			set scores($player1) 1000
		}

		if {![info exists scores($player2)]} {
			set scores($player2) 1000
		}

		set ea [expr {1 / (1 + pow(10, ($scores($player2)-$scores($player1))/400))}]
		set eb [expr {1 - $ea}]

		if {$result == "win"} {
			set sa 1.0
			set sb 0.0
		} elseif {$result == "draw"} {
			set sa 0.5
			set sb 0.5
		} else {
			set sa 0.0
			set sb 1.0
		}

		set oldscores($player1) $scores($player1)
		set oldscores($player2) $scores($player2)

		set scores($player1) [expr {$scores($player1) + $kfactor1 * ($sa - $ea)}]
		set scores($player2) [expr {$scores($player2) + $kfactor2 * ($sb - $eb)}]

		set changes($player1) [expr {$scores($player1) - $oldscores($player1)}]
		set changes($player2) [expr {$scores($player2) - $oldscores($player2)}]

		mysqlexec $vera_connection "UPDATE elo_game SET player1change='[mysqlescape $changes($player1)]', player2change='[mysqlescape $changes($player2)]', player1score='[mysqlescape $scores($player1)]', player2score='[mysqlescape $scores($player2)]' WHERE id = '[mysqlescape $id]'"
	}

	foreach {id score} [array get scores] {
		mysqlexec $vera_connection "UPDATE users SET elo_score = '[mysqlescape $score]' WHERE id = '[mysqlescape $id]'"
	}
}

proc elo_pub_score {nick arguments} {
	if {[llength $arguments] == 0} {
		set account [vera_getaccount $nick]
	} else {
		set target [lindex $arguments 0]

		if {[string index $target 0] == "#"} {
			set account [string range $target 1 end]
		} else {
			set account [vera_getaccount $target]

			if {$account == 0} {
				vera_answer "The user you specified is not authed."
				return
			}
		}

		if {[vera_getlevel $account] == 0} {
			vera_answer "The account you specified does not exist."
			return
		}
	}

	set score [elo_get_score $account]

	vera_answer "$account's score: $score"
}

vera_register "score" 2 0 "elo_pub_score"

proc elo_pub_challenge {nick arguments} {
	global vera_connection

	if {[llength $arguments] == 0} {
		vera_answer_direct "Syntax: challenge <nick>"
		return 0
	}

	set account [vera_getaccount $nick]

	set id [elo_get_accountid $account]

	set other [lindex $arguments 0]

	set accountother [vera_getaccount $other]

	if {$accountother == 0} {
		vera_answer_direct "$other is not authed."
		return
	}

	set idother [elo_get_accountid $accountother]

	if {$idother == -1} {
		vera_answer_direct "$other does not have an ELO account."
		return
	}

	if {$id == $idother} {
		vera_answer_direct "You can't play against yourself."
		return
	}

	set result [mysqlsel $vera_connection "SELECT id FROM elo_game WHERE (player1 = '[mysqlescape $id]' OR player2 = '[mysqlescape $idother]' OR player1 = '[mysqlescape $idother]' OR player2 = '[mysqlescape $id]') AND (player1result IS NULL OR player2result is NULL)" -list]

	if {[llength $result] > 0} {
		set game [lindex $result 0]
		vera_answer "You or your opponent is already playing a game (match ID [lindex $game 0])."
		return
	}

	mysqlexec $vera_connection "INSERT INTO elo_game (player1, player2) VALUES ('[mysqlescape $id]', '[mysqlescape $idother]')"

	vera_answer "A new game (match ID [mysqlinsertid $vera_connection]) has been set up between \002$account\002 and \002$other\002. Use -win, -draw or -loss to update its status."
}

vera_register "challenge" 2 0 "elo_pub_challenge"

proc elo_pub_lastgames {nick arguments} {
	global vera_connection

	if {[llength $arguments] == 0} {
		set account [vera_getaccount $nick]
	} else {
		set target [lindex $arguments 0]

		if {[string index $target 0] == "#"} {
			set account [string range $target 1 end]
		} else {
			set account [vera_getaccount $target]

			if {$account == 0} {
				vera_answer "The user you specified is not authed."
				return
			}
		}

		if {[vera_getlevel $account] == 0} {
			vera_answer "The account you specified does not exist."
			return
		}
	}

	set id [elo_get_accountid $account]

	set result [mysqlsel $vera_connection "SELECT * FROM (SELECT g.date, p1.account AS player1name, p2.account AS player2name, g.player1result, g.player2result, g.player1change, g.player2change, g.player1score, g.player2score FROM elo_game g LEFT JOIN users p1 ON g.player1=p1.id LEFT JOIN users p2 ON g.player2=p2.id WHERE g.player1result != '' AND g.player2result != '' AND (g.player1='[mysqlescape $id]' OR g.player2='[mysqlescape $id]') ORDER BY g.date DESC LIMIT 5) AS g ORDER BY g.date ASC" -list]

	if {[llength $result] == 0} {
		vera_answer "No games found."
		return
	}

	foreach game $result {
		set date [lindex $game 0]
		set player1 [lindex $game 1]
		set player2 [lindex $game 2]
		set player1result [lindex $game 3]
		set player2result [lindex $game 4]
		set player1change [lindex $game 5]
		set player2change [lindex $game 6]
		set player1score [lindex $game 7]
		set player2score [lindex $game 8]

		if {$player1change >= 0} {
			set player1change "+$player1change"
		}

		if {$player2change >= 0} {
			set player2change "+$player2change"
		}

		vera_answer "$date: \002$player1\002 ($player1result, $player1change -> $player1score) vs. \002$player2\002 ($player2result, $player2change -> $player2score)"
	}
}

vera_register "lastgames" 2 0 "elo_pub_lastgames"

proc elo_pub_win {nick arguments} {
	elo_finish_game $nick "win"
}

vera_register "win" 2 0 "elo_pub_win"

proc elo_pub_draw {nick arguments} {
	elo_finish_game $nick "draw"
}

vera_register "draw" 2 0 "elo_pub_draw"

proc elo_pub_loss {nick arguments} {
	elo_finish_game $nick "loss"
}

vera_register "loss" 2 0 "elo_pub_loss"

proc elo_finish_game {nick result} {
	global vera_connection

	set account [vera_getaccount $nick]

	set id [elo_get_accountid $account]

	set result_sql [mysqlsel $vera_connection "SELECT id, player1, player2, player1result, player2result FROM elo_game WHERE (player1result IS NULL OR player2result IS NULL) AND (player1 = '[mysqlescape $id]' OR player2 = '[mysqlescape $id]')" -list]

	if {[llength $result_sql] == 0} {
		vera_answer "There's no game in-progress."
		return
	}

	set game [lindex $result_sql 0]

	set matchid [lindex $game 0]

	if {[lindex $game 1] == $id} {
		set otherresult [lindex $game 4]
		set self "player1"
		set other "player2"
	} else {
		set otherresult [lindex $game 3]
		set self "player2"
		set other "player1"
	}

	if {$result == "win" && $otherresult == "win"} {
		vera_answer "The other player already set their game result to 'win'."
		return
	} elseif {$result == "loss" && $otherresult == "loss"} {
		vera_answer "The other player already set their game result to 'loss'."
		return
	} elseif {$result == "draw" && ($otherresult == "win" || $otherresult == "loss")} {
		vera_answer "You can't set the game result to 'draw' as the other player's result is '$otherresult'."
		return
	} elseif {$otherresult == "draw" && ($result == "win" || $result == "loss")} {
		vera_answer "You can't set the game to '$result' as the other player's result is 'draw'."
		return
	}

	elo_update_scores

	mysqlexec $vera_connection "UPDATE elo_game SET ${self}result = '[mysqlescape $result]', date = NOW() WHERE id = '[mysqlescape $matchid]'"

	vera_answer "Updated your game."

	if {$otherresult != ""} {
		set result_before_sql [mysqlsel $vera_connection "SELECT account, elo_score FROM users WHERE id IN ('[mysqlescape [lindex $game 1]]', '[mysqlescape [lindex $game 2]]') ORDER BY id DESC" -list]

		elo_update_scores

		set result_after_sql [mysqlsel $vera_connection "SELECT account, elo_score FROM users WHERE id IN ('[mysqlescape [lindex $game 1]]', '[mysqlescape [lindex $game 2]]') ORDER BY id DESC" -list]

		vera_answer "Score change: \002[lindex [lindex $result_before_sql 0] 0]\002 ([lindex [lindex $result_before_sql 0] 1] -> [lindex [lindex $result_after_sql 0] 1])"
		vera_answer "Score change: \002[lindex [lindex $result_before_sql 1] 0]\002 ([lindex [lindex $result_before_sql 1] 1] -> [lindex [lindex $result_after_sql 1] 1])"
	} else {
		vera_answer "The other player still needs to set their result."
	}
}
