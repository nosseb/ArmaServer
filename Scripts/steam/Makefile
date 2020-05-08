version := "0.2"

backup_steam:
	# Make a list of config files to ignore
	ls ~/config/ > ~/.config.txt
	# Sync steam
	rsync -ar --delete --exclude-from=~/.config.txt ~/local/.steam ~/backup
	rsync -ar --delete ~/local/Steam ~/backup
	# Remove the list of ignored files
	rm ~/.config.txt

restore_steam:
	rsync -ar --delete ~/backup/.steam ~/local
	rsync -ar --delete ~/backup/Steam ~/local

update_config:
	cp -p ~/config/* ~/local/.steam/

arma_update:
	steamcmd +login Steam_Account Steam_Password +force_install_dir /home/steam/arma3 +app_update 233780 validate +quit

arma_start:
	#

arma_stop:
	#