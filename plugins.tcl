# Vera 0.2
# (c) 2005-2013 Gunnar Beutner
# #help.script @ QuakeNet

set ::vera_commands [list]

set plugins {
	help clock country debug rehash auth voice op ban shun
	kick away topic warn version whois whoisknown seen
	rating notes fortune moo figlet kiss frag fish hum hug
	give asc chr raw search rules dummy uptime usermanagement
	password shorthelp quotes birthday
}

foreach plugin $plugins {
	source vera/plugins/$plugin.tcl
}

source vera/private/games.tcl
source vera/private/inviter.tcl
source vera/private/madhacker.tcl
source vera/private/auto-rating.tcl
