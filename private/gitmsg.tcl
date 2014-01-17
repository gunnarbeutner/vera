proc iface-gitmsg:gitnotify {msg} {
	if {[getctx] != "gate"} {
		return -code error "Access denied."
	}

	setctx sbncbot

	putmsg "#shroudtest2" $msg

	return ""
}

registerifacecmd "gitmsg" "gitnotify" "iface-gitmsg:gitnotify"
