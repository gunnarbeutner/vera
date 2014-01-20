# Vera 0.2.1
# (c) 2013 Uyttersprot Kim (Iceman_X)
# #Iceman_X @ QuakeNet

proc vera_uptime {nick arguments} {
   global server server-online
   vera_answer "Process uptime: [duration [expr {[clock seconds]-$::uptime}]]"
   vera_answer "Connection uptime: $server for [duration [expr {[clock seconds]-${server-online}}]]"
}

vera_register "uptime" 3 0 vera_uptime {
	/msg $::botnick uptime
	Shows information about the process uptime and server connection uptime
}
