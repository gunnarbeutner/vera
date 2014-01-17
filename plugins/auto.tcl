# Vera 0.1a
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

proc vera_accesscheck {nick channel} {
	if {![onchan $nick $channel]} {
		return
	}

	set auth [getchanlogin $nick]

#	if {[vera_db_getlevel $auth] >= 4 && ![isop $nick $channel]} {
#		pushmode $channel +o $nick
#	} elseif {[vera_db_getlevel $auth] >= 2 && ![isop $nick $channel] && ![isvoice $nick $channel]} {
	# }

	if {[string equal -nocase $channel "#labspace"]} {
		return
	}

	if {[vera_db_getlevel $auth] >= 2 && ![isop $nick $channel] && ![isvoice $nick $channel]} {
		pushmode $channel +v $nick
	}
}
