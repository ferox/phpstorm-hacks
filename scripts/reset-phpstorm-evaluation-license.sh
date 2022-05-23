#!/bin/bash
# Script que faz o reset do evalutaion license do PhpStorm
JETBRAINS_CONFIG_DIR="$HOME/.config/JetBrains/"
if [ -d "$JETBRAINS_CONFIG_DIR" ]; then
	echo 'Removendo a licença trial...'
	sleep 3
	LAST_VERSION_CONFIG=$(find "$HOME/.config/JetBrains/" -maxdepth 1 -type d -name "PhpStorm2021.2*" | sort -V | tail -1)
	JETBRAINS_CONSENTOPTIONS=$(find "$HOME/.local/share/JetBrains/" -maxdepth 1 -type d -name "consentOptions*" | sort -V | tail -1)
	JAVA_USERPREFS=$(find "$HOME/.java/" -maxdepth 1 -type d -name ".userPrefs*" | sort -V | tail -1)
	echo "#1 Removendo -> $LAST_VERSION_CONFIG/eval"
	rm -rf "$LAST_VERSION_CONFIG/eval"
	sleep 2
	echo "#2 Removendo -> $LAST_VERSION_CONFIG/options/other.xml"
	rm -rf "$LAST_VERSION_CONFIG/options/other.xml"
	sleep 2
	echo "#3 Removendo -> $JETBRAINS_CONSENTOPTIONS"
	rm -rf "$JETBRAINS_CONSENTOPTIONS"
	sleep 2
	echo "#4 Removendo -> $JAVA_USERPREFS"
	rm -rf "$JAVA_USERPREFS"
	sleep 2
	echo "."
	sleep 1
	echo ".."
	sleep 1
	echo "..."
	sleep 2
	echo "Remoção efetuada com sucesso! HAPPY HACKING..."
	
else
	echo 'PhpStorm não está instalado na máquina...'
fi
