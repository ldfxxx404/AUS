For more convenience, move the .desktop file to the /usr/share/applications directory. Then move the script to the /usr/bin directory. This will allow you to run the script from the application launcher

UPD. In the .desktop file, replace in this line ---> Exec=sakura -e 'bash -c 'doas /usr/bin/autoupdate.sh; exec bash'"
Sakura terminal name to your terminal name