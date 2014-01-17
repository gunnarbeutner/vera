# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_notes {nick arguments} {
	global botnick

	set subcommand [lindex $arguments 0]

	if {$subcommand == ""} { set subcommand "list" }

	if {[string equal -nocase $subcommand "list"]} {
		set notes [vera_db_notes [vera_getaccount $nick]]

		foreach note $notes {
			puthelp "NOTICE $nick :\002[lindex $note 1]\002 wrote: '[lindex $note 2]' at [clock format [lindex $note 0]]"
		}

		puthelp "NOTICE $nick :End of NOTES."

		vera_db_setread [vera_getaccount $nick]
	} elseif {[string equal -nocase $subcommand "send"]} {
		set to [lindex $arguments 1]
		set text [join [lrange $arguments 2 end]]

		if {$text == ""} {
			vera_answer_direct "You need to specify a destination and a text."
			return
		}

		set account_to [vera_getaccount $to]

		if {[vera_getlevel $account_to] == 0} {
			vera_answer_direct "$to is not a valid users. Use 'whoisknown' to get a list of users."
			return
		}

		if {[string equal -nocase [vera_getaccount $nick] $account_to]} {
			vera_answer_direct "You cannot send yourself a note, you fool!"
			return
		}

		if {[llength [vera_db_notes $account_to]] >= 10} {
			vera_answer_direct "Sorry, that user's inbox is full. No further notes can be delivered."
			return
		}

		vera_db_addnote [vera_getaccount $nick] $account_to $text

		vera_answer_direct "Done."

		set recipients [vera_getnicks $account_to]

		if {[llength $recipients] > 0} {
			foreach recipient $recipients {
				puthelp "NOTICE $recipient :[vera_getaccount $nick] just sent you a note. Type \"/msg $botnick notes\" to read it."
			}
		}
	} elseif {[string equal -nocase $subcommand "purge"]} {
		vera_db_purgenotes [vera_getaccount $nick]

		vera_answer_direct "Done."
	} else {
		vera_answer_direct "This subcommand is not known. Valid commands: list, send, purge"
	}
}

vera_register "notes" 2 0 "vera_notes" {
	/msg $::botnick notes
	Retrieves any queued notes.
	/msg $::botnick notes send <account> <text>
	Sends someone a note.
	/msg $::botnick notes purge
	Deletes any queued notes.
}
