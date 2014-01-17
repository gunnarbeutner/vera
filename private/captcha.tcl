set ::captcha_chans [list "#sbnc" "#sbnc.beta"]

bind join - * vera_captcha_join
bind account - * vera_captcha_auth

proc vera_captcha_join {nick host hand chan} {
	global captcha_chans

	set captcha [randstring 16]

	set found 0
	foreach captcha_chan $captcha_chans {
		if {[string equal -nocase $chan $captcha_chan]} {
			set found 1

			break
		}
	}

	if {$found == 0} {
		return
	}

	bncsettag $chan $nick "captcha" $captcha

	puthelp "NOTICE $nick :In order to get voice in $chan you will need to pass this CAPTCHA: http://captcha.shroudbnc.info/?id=$captcha"

}

proc vera_captcha_auth {nick host hand chan} {
	global captcha_chans

	set account [getchanlogin $nick]

	set found 0
	foreach captcha_chan $captcha_chans {
		if {[string equal -nocase $chan $captcha_chan]} {
			set found 1

			break
		}
	}

	if {$found == 0} {
		return
	}

	if {$account != 0 && $account != ""} {
		set known [vera_db_get_captcha_user $account]

		if {$known > 0} {
			bncsettag $chan $nick "captcha" ""
			putquick "MODE $chan +v $nick"
		}
	}
}

proc vera_captcha {nick chan arguments} {
	set captcha [bncgettag $chan $nick "captcha"]

	if {$captcha == "" || [isvoice $nick $chan]} {
		vera_answer_direct "No CAPTCHA is available for you."
	} else {
		vera_answer_direct "Your CAPTCHA: http://shroudbnc.info/captcha/?id=$captcha"
	}
}

vera_register "captcha" 2 1 "vera_captcha"

proc captcha:finish {captcha status} {
	global captcha_chans

	setctx "sbncbot"
#	putmsg #shroudtest2 "CAPTCHA finished: $captcha"

	foreach captcha_chan $captcha_chans {
		foreach user [internalchanlist $captcha_chan] {
			if {[string equal [bncgettag $captcha_chan $user "captcha"] $captcha] && $captcha != ""} {
				bncsettag $captcha_chan $user "captcha" ""

				if {[isvoice $user $captcha_chan]} {
					continue
				}

#				putmsg #shroudtest2 "Captcha belonged to $user"

				set account [getchanlogin $user]

				if {[string equal -nocase $status "fail"]} {
					set reason "CAPTCHA failed"

					if {$account != 0 && $account != ""} {
				                pushmode $captcha_chan +b "*!*@$account.users.quakenet.org"
#				                newchanban $captcha_chan "*!*@$account.users.quakenet.org" [vera_getaccount $user] $reason 1d
				        }

				        if {[getchanhost $user] != "" && ![string match "*@*.users.quakenet.org" [getchanhost $user]]} {
				                pushmode $captcha_chan +b [maskhost [getchanhost $user]]

#			        	        newchanban $captcha_chan [maskhost [getchanhost $user]] [vera_getaccount $user] $reason 1d
			        	}

					putquick "KICK $captcha_chan $user :CAPTCHA failed (try again in a while)"

					return [itype_string "fail"]
				} else {
					putquick "MODE $captcha_chan +v $user"

					if {$account != "" && $account != 0} {
						vera_db_add_captcha_user $account
					}

					return [itype_string "ok"]
				}

				return ""
			}
		}
	}

#	putmsg #shroudtest2 "Captcha belonged to unknown user."

	return [itype_string "unknown"]
}

registerifacecmd "captcha" "finishcaptcha" "captcha:finish"
