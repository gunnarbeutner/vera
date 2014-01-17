# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

bind pubm -|- * vera_pub_core
bind msgm -|- * vera_priv_core

set vera_version "0.2"

proc vera_priv_core {nick host hand text} {
	global botnick vera

	if {[vera_db_link] == 0} {
		puthelp "PRIVMSG $nick :ERROR: Could not connect to MySQL databse."

		return
	}

	if {[regexp {^\?(.*?)\?$} [lindex [split $text] 0] foo trigger]} {
		set hint [vera_db_shorthelp $trigger]

		if {$hint == 0} { return }

		puthelp "PRIVMSG $nick :$hint"

		return
	}

	set command [lindex [split $text] 0]

	set node [vera_getcomnode $command]

	if {$node == -1} {
		puthelp "NOTICE $nick :Unknown command. try /msg $botnick help"
	} else {
		if {[lindex $node 1] > [vera_getlevel [vera_getaccount $nick]]} {
			puthelp "NOTICE $nick :Access denied"
		} else {
			set vera(answer) $nick
			set vera(cmd) "NOTICE"
			set vera(nick) $nick

			if {[lindex $node 2]} {
				set chan [lindex [split $text] 1]
				set arguments [lrange [split $text] 2 end]

				if {$chan == "" || ![vera_onchan $chan]} {
					puthelp "NOTICE $nick :You need to specify a valid channel."

					return
				}

				vera_logcommand [lindex $node 3] $nick $chan [join $arguments]

				[lindex $node 3] $nick $chan $arguments
			} else {
				set arguments [lrange [split $text] 1 end]

				vera_logcommand [lindex $node 3] $nick {} [join $arguments]

				[lindex $node 3] $nick $arguments
			}
		}
	}
}

proc vera_pub_core {nick host hand chan text} {
	global botnick vera

	set trigger [lindex [split $text] 0]
	if {[string index $trigger end] == ":" || [string index $trigger end] == ","} {
		set trigger [string range $trigger 0 end-1]
	}

	if {[string index $trigger 0] == "-"} {
		set trigger $botnick
		set text "$botnick [string range $text 1 end]"
	}

	if {[string equal -nocase $trigger $botnick]} {
		set command [lindex [split $text] 1]
		set arguments [lrange [split $text] 2 end]

		set node [vera_getcomnode $command]

		if {$node == -1} {
			puthelp "NOTICE $nick :Unknown command. try /msg $botnick help"
		} else {
			if {[lindex $node 1] > [vera_getlevel [vera_getaccount $nick]]} {
				puthelp "NOTICE $nick :Access denied"
			} else {
				set vera(answer) $chan
				set vera(cmd) "PRIVMSG"
				set vera(nick) $nick

				if {[lindex $node 2]} {
					vera_logcommand [lindex $node 3] $nick $chan [join $arguments]
					[lindex $node 3] $nick $chan $arguments
				} else {
					vera_logcommand [lindex $node 3] $nick {} [join $arguments]
					[lindex $node 3] $nick $arguments
				}
			}
		}
	}

	if {[regexp {^\?(.*?)\?$} [lindex [split $text] 0] foo trigger]} {
		set hint [vera_db_shorthelp $trigger]

		if {$hint == 0} {
			return
		}

		if {[vera_getlevel [vera_getaccount $nick]] < 2} {
			puthelp "PRIVMSG $nick :$hint"
		} else {
			if {[onchan [lindex [split $text] 1] $chan]} {
				putserv "PRIVMSG $chan :[lindex [split $text] 1]: $hint"
			} else {
				putserv "PRIVMSG $chan :$nick: $hint"
			}
		}
	}
}

proc vera_getcomnode {command} {
	global vera_commands

	set nodeidx [lsearch $vera_commands "$command *"]

	if {$nodeidx == -1} {
		return -1
	} else {
		return [lindex $vera_commands $nodeidx]
	}
}

proc vera_register {command level requirechan tcl_command {helptext ""}} {
	global vera_commands

	if {[vera_getcomnode $command] == -1} {
		lappend vera_commands [list $command $level $requirechan $tcl_command $helptext]
	}
}

proc vera_getlevel {account} {
	if {$account == 0} {
		return 0
	} else {
		return [vera_db_getlevel $account]
	}
}

proc vera_getaccount {nick} {
	if {[string index $nick 0] == "#"} {
		return [string range $nick 1 end]
	}

	set account [vera_getchanlogin2 $nick]

	if {$account == 0 || $account == ""} {
		return 0
	}

	return $account
}

proc vera_getnicks {account} {
	set nicks [list]

	foreach channel [channels] {
		foreach nick [chanlist $channel] {
			if {[string equal -nocase [vera_getaccount $nick] $account] && [lsearch -exact $nicks $nick] == -1} {
				lappend nicks $nick
			}
		}
	}

	return $nicks
}

proc vera_prettyuser {user} {
	if {[string index $user 0] == "#"} {
		set nicks [vera_getnicks [vera_getaccount $user]]

		if {[llength $nicks] > 0} {
			return [join $nicks ", "]
		}
	}

	return $user
}

proc vera_answer {text} {
	global vera

	putserv "$vera(cmd) $vera(answer) :$text"
}

proc vera_answer_direct {text} {
	global vera

	puthelp "NOTICE $vera(nick) :$text"
}

proc vera_logcommand {command nick chan arguments} {
	set file [open "vera/vera.log" "a"]

	if {$chan != ""} {
		puts $file "[unixtime] $command ($chan) $nick\[[vera_getaccount $nick]\] $arguments"
	} else {
		puts $file "[unixtime] $command $nick\[[vera_getaccount $nick]\] $arguments"
	}

	close $file
}

proc vera_onchan {channel} {
	set error [catch [list botonchan $channel] value]

	if {$error} {
		return 0
	} else {
		return $value
	}
}

set ::vera_bot [getctx]

source "vera/config.tcl"
source "vera/sql.tcl"
source "vera/plugins.tcl"
