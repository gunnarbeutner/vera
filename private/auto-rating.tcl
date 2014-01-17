# Vera 0.1a
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

internaltimer 60 1 vera_autovoice_rating

set ::autovoice_channels [list #sbfl]
set ::autovoice_threshold 1800

proc sumrate {rates} {
	set result 0

	foreach rate $rates {
		incr result $rate
	}

	return $result
}

proc vera_autovoice_rating {} {
	global autovoice_channels

	foreach channel $autovoice_channels {
		foreach nick [internalchanlist $channel] {
			vera_accesscheck $nick $channel
		}
	}
}

proc vera_accesscheck {nick channel} {
	global autovoice_threshold

	if {[string equal -nocase $channel "#labspace"]} {
		return
	}

	set auth [getchanlogin $nick]

	if {[vera_db_getlevel $auth] < 2} {
		return
	}

	set voiced_old [isvoice $nick $channel]
	set voiced_new [expr -- [sumrate [vera_db_getrateweek $auth]] > $autovoice_threshold]

	if {$voiced_old && !$voiced_new} {
		pushmode $channel -v $nick
	} elseif {!$voiced_old && $voiced_new && ![isop $nick $channel]} {
		pushmode $channel +v $nick
	}
}
