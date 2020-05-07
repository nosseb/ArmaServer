version := "0.2"

backup_steam:
	rm -rf ~/backup/.steam/*
	ls ~/config/ > ~/.config.txt
	rsync -ar --exclude-from=~/.config.txt ~/local/.steam/
	rm ~/.config.txt
	#TODO: also backup ~/Steam folder

restore_steam:
	rm -rf ~/local/.steam/*
	cp -p ~/backup/.steam/* ~/local/.steam
	#TODO: also restore ~/Steam folder

update_config:
	cp -p ~/config/* ~/local/.steam/

arma_update:
	#TODO: change arma install location
	steamcmd +login Steam_Account Steam_Password +app_update 233780 validate +quit

#TODO: arma_start
#TODO: arma_stop