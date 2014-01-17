# anti-begging script
# (c) 2008 Gunnar Beutner

set ::transformrules {
	"\\?*\$" ""
	"^\\d*\$" ""
	"'?s\$" ""
	"don't" "do not"
	"can't" "can not"
	"^(become|became|got|suche|brauche)\$" "get"
	"^(a|one|some|i|free)\$" ""
	"^pl(s|z|x)\$" "please"
	"^bnc\$" "bouncer"
}

set ::begrules {
	{"free" "get bouncer" "!not" "!download"}
	{"free" "need bouncer" "!not" "!download"}
	{"free" "want bouncer" "!not" "!download"}
	{"free" "can have bouncer" "!not" "!download"}
	{"free" "\\!request"}
	{"free" "\\!admin"}
	{"free" "\\!bnc"}
	{"adv" "meineex"}
	{"adv" "myex"}
}

bind pubm -|- * beg_pubm

proc beg_transform {message} {
	global transformrules

	set message [string tolower $message]

	foreach {pattern newword} $transformrules {
		set resultmessage [list]

		foreach word [split $message] {
			set resultword [regsub $pattern $word $newword]

			if {[string length $resultword] > 0} {
				lappend resultmessage $resultword
			}
		}

		set message [join $resultmessage]
	}

	return $message
}

proc beg_pubm {nick host hand chan arg} {
	global begrules

	if {[bncgettag $chan $nick "firstmsg"] != "" || [expr {[unixtime] - [getchanjoin $nick $chan]}] > 300} {
		return
	}

	bncsettag $chan $nick "firstmsg" "0"

	set tmsg [beg_transform $arg]

	set match 0

	foreach rule $begrules {
		set match 1

		set ruletext [lindex $rule 0]

		foreach subrule [lrange $rule 1 end] {
			set negate 0

			if {[string range $subrule 0 0] == "!"} {
				set subrule [string range $subrule 1 end]
				set negate 1
			}

			set submatch [regexp $subrule $tmsg]

			if {(!$submatch && !$negate) || ($submatch && $negate)} {
				set match 0

				break
			}
		}

		if {$match} {
			break
		}
	}

	if {!$match} {
		return
	}

	puthelp "PRIVMSG #shroudtest2 :match for rule '[lrange $rule 1 end]': $arg ($tmsg) -> [lindex $rule 0]"

	set account [vera_getaccount $nick]

	set reason "Automated ban: [vera_db_getrule [lindex $rule 0]]"

	if {$account != 0 && $account != ""} {
        	pushmode $chan +b "*!*@$account.users.quakenet.org"
	        newchanban $chan "*!*@$account.users.quakenet.org" [vera_getaccount $nick] $reason 0
	}

	if {[getchanhost $nick] != "" && ![string match "*@*.users.quakenet.org" [getchanhost $nick]]} {
	        pushmode $chan +b [maskhost [getchanhost $nick]]

	        newchanban $chan [maskhost [getchanhost $nick]] [vera_getaccount $nick] $reason 0
	}

	puthelp "NOTICE $nick :This is an automated ban which was triggered by certain words in your message. If you think that this ban was unjustified please send an e-mail to gunnar@beutner.name with details about what exactly you said."
}

