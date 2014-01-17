# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

package require mysqltcl
package require sha1

set ::vera_connection ""

proc vera_db_link {} {
	global vera_connection sql_user sql_pass sql_db sql_host

 	if {[info exists vera_connection]} {
 	 	if {[catch [list mysqlquery $vera_connection "SELECT 1"] query]} {
 	 	 	catch [list mysqlclose $vera_connection] errors
 	 	} else {
 	 	 	mysqlendquery $query
 	 	 	return $vera_connection
 	 	}
 	}

	if {[catch [list mysqlconnect -user $sql_user -password $sql_pass -db $sql_db -host $sql_host] vera_connection]} {
		return 0
	} else {
		return $vera_connection
	}
}

vera_db_link

proc vera_db_getlevel {account} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT level FROM users WHERE `account`='[mysqlescape $account]'"]

	set level [mysqlnext $query]

	mysqlendquery $query

	if {$level == ""} {
		return 0
	} else {
		return $level
	}
}

proc vera_db_shorthelp {trigger} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT hint FROM triggers WHERE `trigger`='[mysqlescape $trigger]'"]

	set hint [mysqlnext $query]

	mysqlendquery $query

	if {$hint == ""} {
		return 0
	} else {
		return [join $hint]
	}
}

proc vera_db_search {word} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT `trigger` FROM triggers WHERE `trigger` LIKE '%[mysqlescape $word]%'"]

	set result ""

	while {[set res [mysqlnext $query]] != ""} {
		lappend result $res

		if {[llength $result] == 5} { break }
	}

	mysqlendquery $query

	if {$result == ""} {
		return 0
	} else {
		return [join $result ","]
	}
}

proc vera_db_getaway {account} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT awaysince,awaytext FROM users WHERE `account`='[mysqlescape $account]'"]

	set away [mysqlnext $query]

	mysqlendquery $query

	if {$away == ""} {
		return -1
	} else {
		return $away
	}
}

proc vera_db_setaway {account text} {
	global vera_connection

	if {$text == ""} {
		set time 0
	} else {
		set time [unixtime]
	}

	set query [mysqlexec $vera_connection "UPDATE users SET `awaysince` = '$time', `awaytext` = '[mysqlescape $text]' WHERE `account`='[mysqlescape $account]'"]
}

proc vera_db_gethrdesc {level} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT text FROM levels WHERE `level`='[mysqlescape $level]'"]

	set text [mysqlnext $query]

	mysqlendquery $query

	if {$text == ""} {
		return unknown
	} else {
		return [join $text]
	}
}

proc vera_db_levels {} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT level,text FROM levels ORDER BY `level`"]

	set result ""

	while {[set res [mysqlnext $query]] != ""} {
		lappend result $res
	}

	mysqlendquery $query

	return $result
}

proc vera_db_tld2country {tld} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT name FROM countries WHERE `tld`='[mysqlescape $tld]'"]

	set text [mysqlnext $query]

	mysqlendquery $query

	if {$text == ""} {
		return unknown
	} else {
		return [join $text]
	}
}

proc vera_db_getraw {numeric} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT text FROM raws WHERE `numeric`='[mysqlescape $numeric]'"]

	set row [mysqlnext $query]

	mysqlendquery $query

	if {$row == ""} {
		return ""
	}

	return [lindex $row 0]
}

proc vera_db_getrulebyid {rule} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT text FROM rules WHERE `id`='[mysqlescape $rule]'"]

	set text [mysqlnext $query]

	mysqlendquery $query

	if {$text == ""} {
		return $rule
	} else {
		return [join $text]
	}
}

proc vera_db_getrule {rule} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT text FROM rules WHERE `rule`='[mysqlescape $rule]'"]

	set text [mysqlnext $query]

	mysqlendquery $query

	if {$text == ""} {
		return [vera_db_getrulebyid $rule]
	} else {
		return [join $text]
	}
}

proc vera_db_rules {} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT rule,text FROM rules"]

	while {[set res [mysqlnext $query]] != ""} {
		lappend result $res
	}

	mysqlendquery $query

	if {$result == ""} {
		return 0
	} else {
		return $result
	}
}

proc vera_db_users {} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT level,account FROM users"]

	while {[set res [mysqlnext $query]] != ""} {
		lappend result $res
	}

	mysqlendquery $query

	if {$result == ""} {
		return 0
	} else {
		return $result
	}
}

proc vera_db_getrateday {account} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT [clock format [unixtime] -format %A] FROM rating WHERE `account`='[mysqlescape $account]'"]

	set text [mysqlnext $query]

	mysqlendquery $query

	if {$text == ""} {
		return 0
	} else {
		return $text
	}
}

proc vera_db_seen {account} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT `lastact` FROM rating WHERE `account`='[mysqlescape $account]'"]

	set text [mysqlnext $query]

	mysqlendquery $query

	if {$text == ""} {
		return 0
	} else {
		return $text
	}
}

proc vera_db_getrateweek {account} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT monday,tuesday,wednesday,thursday,friday,saturday,sunday FROM rating WHERE `account`='[mysqlescape $account]'"]

	set text [mysqlnext $query]

	mysqlendquery $query

	if {$text == ""} {
		return 0
	} else {
		return $text
	}
}

proc vera_db_setrate {account rate} {
	global vera_connection

	set seensql ""

	if {$rate > 0} {
		set seensql ", lastact='[unixtime]'"
	}

	if {[catch [list mysqlexec $vera_connection "INSERT INTO `rating` ( `account` , `[clock format [unixtime] -format %A]` , `lastact` ) VALUES ( '[mysqlescape $account]', '$rate' , '[unixtime]' ) ON DUPLICATE KEY UPDATE `[clock format [unixtime] -format %A]`='$rate' $seensql"] sql_res]} {
		return 0
	}

	return 1
}

proc vera_db_setnick {account nick} {
	global vera_connection
	mysqlexec $vera_connection "UPDATE `users` SET `nickname`='[mysqlescape $nick]' WHERE `account`='[mysqlescape $account]'"
}

proc vera_db_gettopic {channel} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT `topic` FROM `topics` WHERE `channel`='[mysqlescape $channel]'"]

	set text [mysqlnext $query]

	mysqlendquery $query

	if {$text == ""} {
		return ""
	} else {
		return [join $text]
	}
}

proc vera_db_settopic {channel topic} {
	global vera_connection

	if {[catch [list mysqlexec $vera_connection "INSERT INTO `topics` ( `channel` , `topic` ) VALUES ( '[mysqlescape $channel]', '[mysqlescape $topic]' )"] sql_res]} {
		if {[catch [list mysqlexec $vera_connection "UPDATE `topics` SET `topic`='[mysqlescape $topic]' WHERE `channel`='[mysqlescape $channel]'"] sql_res]} {
			return 0
		}
	}

	return 1
}

proc vera_db_addaccount {account level} {
	global vera_connection

	if {[catch [list mysqlexec $vera_connection "INSERT INTO `users` ( `account` , `level`, `created`, `modified` ) VALUES ( '[mysqlescape $account]', '[mysqlescape $level]', '[clock seconds]', '[clock seconds]' )"] sql_res]} {
		return 0
	}

	return 1
}

proc vera_db_modaccount {account level} {
	global vera_connection

	if {[catch [list mysqlexec $vera_connection "UPDATE `users` SET `level`='[mysqlescape $level]', `modified`='[clock seconds]' WHERE `account`='[mysqlescape $account]'"] sql_res]} {
		return 0
	}

	return 1
}

proc vera_db_remaccount {account} {
	global vera_connection

	if {[catch [list mysqlexec $vera_connection "DELETE FROM `users` WHERE `account`='[mysqlescape $account]'"] sql_res]} {
		return 0
	}

	return 1
}

proc vera_db_setpass {account password} {
	global vera_connection

	if {[catch [list mysqlexec $vera_connection "UPDATE `users` SET `password`='[mysqlescape [md5 $password]]', `passwordsha1`='[mysqlescape [::sha1::sha1 $password]]' WHERE `account`='[mysqlescape $account]'"] sql_res]} {
		return 0
	}

	return 1
}

proc vera_db_addnote {from to text} {
	global vera_connection

	if {[catch [list mysqlexec $vera_connection "INSERT INTO `notes` ( `time`, `from` , `to`, `text` ) VALUES ( '[unixtime]', '[mysqlescape $from]', '[mysqlescape $to]', '[mysqlescape $text]' )"] sql_res]} {
		return 0
	}

	return 1
}

proc vera_db_notes {account} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT `time`, `from`, `text`, `read` FROM `notes` WHERE `to`='[mysqlescape $account]' ORDER BY `time`"]

	set result ""

	while {[set res [mysqlnext $query]] != ""} {
		lappend result $res
	}

	mysqlendquery $query

	return $result
}

proc vera_db_setread {account} {
	global vera_connection

	if {[catch [list mysqlexec $vera_connection "UPDATE `notes` SET `read`='1' WHERE `to`='[mysqlescape $account]'"] sql_res]} {
		return 0
	}

	return 1
}

proc vera_db_purgenotes {account} {
	global vera_connection

	if {[catch [list mysqlexec $vera_connection "DELETE FROM `notes` WHERE `to`='[mysqlescape $account]'"] sql_res]} {
		return 0
	}

	return 1
}

proc vera_db_addshorthelp {trigger hint} {
	global vera_connection

	if {[catch [list mysqlexec $vera_connection "INSERT INTO `triggers` ( `trigger`, `hint` ) VALUES ( '[mysqlescape $trigger]', '[mysqlescape $hint]' )"] sql_res]} {
		return 0
	}

	return 1
}

proc vera_db_delshorthelp {trigger} {
	global vera_connection

	if {[catch [list mysqlexec $vera_connection "DELETE FROM `triggers` WHERE `trigger`='[mysqlescape $trigger]'"] sql_res]} {
		return 0
	}

	return 1
}

proc vera_db_randquote {} {
	global vera_connection

	if {[catch [list mysqlexec $vera_connection "INSERT INTO `quotes` ( `text` ) VALUES ( '[mysqlescape $text]' )"] sql_res]} {
		return 0
	}

	return 1
}

proc vera_db_countquotes {} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT COUNT(*) FROM quotes"]

	set count [mysqlnext $query]

	mysqlendquery $query

	if {$count == ""} {
		return 0
	} else {
		return [lindex $count 0]
	}
}

proc vera_db_getquotebyid {id} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT `id`,`creator`,`text` FROM `quotes` WHERE `id`='[mysqlescape $id]'"]

	set quote [mysqlnext $query]

	mysqlendquery $query

	if {$quote == ""} {
		return 0
	} else {
		return $quote
	}
}

proc vera_db_getquotes {} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT `id`,`creator`,`text` FROM `quotes` ORDER BY `id` ASC"]

	set result [list]

	while {[set res [mysqlnext $query]] != ""} {
		lappend result $res
	}

	return $result
}

proc vera_db_getquotebynum {num} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT `id`,`creator`,`text` FROM `quotes` ORDER BY `id` ASC"]

	set result 0

	set count 0

	while {[set res [mysqlnext $query]] != ""} {
		incr count

		if {$count >= $num} {
			if {$res != ""} {
				set result $res
			} else {
				set result 0
			}

			break
		}
	}

	mysqlendquery $query

	return $result
}

proc vera_db_addquote {creator text} {
	global vera_connection

	if {[catch [list mysqlexec $vera_connection "INSERT INTO `quotes` ( `creator`, `text` ) VALUES ( '[mysqlescape $creator]', '[mysqlescape $text]' )"] sql_res]} {
		return 0
	}

	return 1
}

proc vera_db_delquote {id} {
	global vera_connection

	if {[catch [list mysqlexec $vera_connection "DELETE FROM `quotes` WHERE `id`='[mysqlescape $id]'"] sql_res]} {
		return 0
	}

	return 1
}

proc vera_db_get_captcha_user {account} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT COUNT(*) FROM `captcha` WHERE `account` = '[mysqlescape $account]'"]

	set count [mysqlnext $query]

	mysqlendquery $query

	if {$count == ""} {
		return 0
	} else {
		return [lindex $count 0]
	}
}

proc vera_db_add_captcha_user {account} {
	global vera_connection

	if {[catch [list mysqlexec $vera_connection "INSERT INTO `captcha` ( `account` ) VALUES ( '[mysqlescape $account]' )"] sql_res]} {
		return 0
	}

	return 1
}

proc vera_db_games {} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT `name`, `shortcut` FROM `games` ORDER BY `name` ASC"]

	set result [list]

	while {[set res [mysqlnext $query]] != ""} {
		lappend result $res
	}

	return $result
}

proc vera_db_addgame_user {user game} {
	global vera_connection

	if {[catch [list mysqlexec $vera_connection "INSERT INTO `users_games` ( `account`, `game` ) VALUES ( '[mysqlescape $user]', '[mysqlescape $game]' )"] sql_res]} {
		return 0
	}

	return 1
}

proc vera_db_delgame_user {user game} {
	global vera_connection

	if {[catch [list mysqlexec $vera_connection "DELETE FROM `users_games` WHERE `account`='[mysqlescape $user]' AND `game`='[mysqlescape $game]'"] sql_res]} {
		return 0
	}

	return 1
}

proc vera_db_getgames_user {user} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT `game` FROM `users_games` WHERE `account`='[mysqlescape $user]' ORDER BY `game` ASC"]

	set result [list]

	while {[set res [mysqlnext $query]] != ""} {
		lappend result [lindex $res 0]
	}

	return $result
}

proc vera_db_getusers_game {game} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT `account` FROM `users_games` WHERE `game`='[mysqlescape $game]' ORDER BY `account` ASC"]

	set result [list]

	while {[set res [mysqlnext $query]] != ""} {
		lappend result [lindex $res 0]
	}

	return $result
}

proc vera_db_resolvegame {game} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT `name` FROM `games` WHERE `name`='[mysqlescape $game]' OR `shortcut`='[mysqlescape $game]'"]

	set fullname [mysqlnext $query]

	mysqlendquery $query

	if {$fullname == ""} {
		return 0
	} else {
		return [lindex $fullname 0]
	}
}

proc vera_db_setinviter {user inviter} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT `account` FROM `users` WHERE `account`='[mysqlescape $inviter]'"]
	set row [mysqlnext $query]
	set canonuser [lindex $row 0]

	mysqlexec $vera_connection "UPDATE users SET `inviter` = '[mysqlescape $canonuser]' WHERE `account`='[mysqlescape $user]'"
}

proc vera_db_getinviter {user} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT `inviter` FROM `users` WHERE `account`='[mysqlescape $user]'"]

	set row [mysqlnext $query]

	mysqlendquery $query

	return [lindex $row 0]
}

proc vera_db_getcreated {account} {
	global vera_connection

	set result [mysqlquery $vera_connection "SELECT `created` FROM `users` WHERE `account`='[mysqlescape $account]'"]
	set row [mysqlnext $result]
	mysqlendquery $result

	if {$row == ""} {
		return 0
	}

	return [lindex $row 0]
}

proc vera_db_setbirthday {user birthday} {
	global vera_connection

	mysqlexec $vera_connection "UPDATE users SET `birthday` = '[mysqlescape $birthday]' WHERE `account`='[mysqlescape $user]'"
}

proc vera_db_getbirthday {user} {
	global vera_connection

	set query [mysqlquery $vera_connection "SELECT `birthday` FROM `users` WHERE `account`='[mysqlescape $user]'"]

	set row [mysqlnext $query]

	mysqlendquery $query

	return [lindex $row 0]
}

