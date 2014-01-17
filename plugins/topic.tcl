# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

bind raw -|- TOPIC vera_intern_topicchange

proc vera_intern_topicchange {from keyword text} {
	set channel [lindex $text 0]
	set topic [join [lrange $text 1 end]]

	if {[string first ":" $topic] == 0} {
		set topic [string range $topic 1 end]
	}

	vera_db_settopic $channel $topic
}

proc vera_settopic {nick chan arguments} {
	set topic [vera_db_gettopic $chan]

	if {$arguments == ""} {
		vera_answer_direct "$chan's topic: $topic"
		return
	} else {
		vera_db_settopic $chan [join $arguments]

		if {[onchan Q $chan] && [matchattr Q T|T $chan]} {
			putserv "PRIVMSG Q :SETTOPIC $chan [join $arguments]"
		} else {
			putserv "TOPIC $chan :[join $arguments]"
		}

		vera_answer_direct "Done."
	}
}

proc vera_reftopic {nick chan arguments} {
	set topic [vera_db_gettopic $chan]

	if {$topic == ""} {
		vera_answer_direct "Sorry, i don't have a copy of $chan's topic."
		return
	}

	if {[onchan Q $chan]} {
		putserv "PRIVMSG Q :SETTOPIC $chan $topic"
	} else {
		putserv "TOPIC $chan :$topic"
	}

	vera_answer_direct "Done."
}

proc vera_addtopic {nick chan arguments} {
	set pieces [split [vera_db_gettopic $chan] "|"]

	set topic ""

	foreach piece $pieces {
		lappend topic [string trim $piece]
	}

	lappend pieces [join $arguments]

	vera_settopic $nick $chan [join $pieces " | "]
}

proc vera_deltopic {nick chan arguments} {
	set pieces [split [vera_db_gettopic $chan] "|"]
	set todel [lindex $arguments 0]

	if {$todel == "" || ![string is digit $todel]} {
		vera_answer_direct "You need to specify a valid part of the topic. e.g. /msg $::botnick deltopic $chan 1"
		return
	}

	set topic ""

	foreach piece $pieces {
		lappend topic [string trim $piece]
	}

	if {$todel >= [llength $pieces]} {
		vera_answer_direct "There aren't that many pieces in the topic."
		return
	}

	if {[llength $pieces] == 1} {
		vera_answer_direct "Sorry, you cannot remove the last piece of the topic. use reptopic instead."
		return
	}

	set pieces [lreplace $pieces $todel $todel]

	vera_settopic $nick $chan [join $pieces " | "]
}

proc vera_reptopic {nick chan arguments} {
	set pieces [split [vera_db_gettopic $chan] "|"]
	set todel [lindex $arguments 0]

	if {$todel == "" || ![string is digit $todel]} {
		vera_answer_direct "You need to specify a valid part of the topic. e.g. /msg $::botnick reptopic $chan 0 some text"
		return
	}

	set topic ""

	foreach piece $pieces {
		lappend topic [string trim $piece]
	}

	if {$todel >= [llength $pieces]} {
		vera_answer_direct "There aren't that many pieces in the topic."
		return
	}

	set pieces [lreplace $pieces $todel $todel [join [lrange $arguments 1 end]]]

	vera_settopic $nick $chan [join $pieces " | "]
}

proc vera_instopic {nick chan arguments} {
	set pieces [split [vera_db_gettopic $chan] "|"]
	set todel [lindex $arguments 0]

	if {$todel == "" || ![string is digit $todel]} {
		vera_answer_direct "You need to specify a valid position for the new piece. e.g. /msg $::botnick instopic $chan 0 some text"
		return
	}

	set topic ""

	foreach piece $pieces {
		lappend topic [string trim $piece]
	}

	if {$todel > [llength $pieces]} {
		vera_answer_direct "There aren't that many pieces in the topic."
		return
	}

	set pieces [linsert $pieces $todel [join [lrange $arguments 1 end]]]

	vera_settopic $nick $chan [join $pieces " | "]
}

vera_register "settopic" 5 1 "vera_settopic" {
	/msg $::botnick settopic ?channel? <topic>
	Sets the channel's topic.
}

vera_register "reftopic" 5 1 "vera_reftopic" {
	/msg $::botnick reftopic ?channel?
	Refreshes the channel's topic.
}

vera_register "addtopic" 5 1 "vera_addtopic" {
	/msg $::botnick addtopic ?channel? <new topic>
	Adds something to the current topic.
}

vera_register "deltopic" 5 1 "vera_deltopic" {
	/msg $::botnick deltopic ?channel? <piece>
	Removes a piece from the topic. 'piece' must be a number, which specifies the part of the topic. The number 0 refers to the first part of the topic.
}

vera_register "reptopic" 5 1 "vera_reptopic" {
	/msg $::botnick reptopic ?channel? <piece> <new topic>
	Replaces something in the current topic. 'piece' must be the index of the part of the topic which is to be replaced. The number 0 refers to the first part of the topic.
}

vera_register "instopic" 5 1 "vera_instopic" {
	/msg $::botnick instopic ?channel? <piece> <new topic>
	Inserts something into the current topic. 'piece' must be the index, after which the new topic should be inserted. The number 0 refers to the first part of the topic.
}
