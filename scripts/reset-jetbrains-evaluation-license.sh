#!/bin/bash
# Script que faz o reset do evalutaion license do PhpStorm
JETBRAINS_CONFIG_DIR="$HOME/.config/JetBrains/"

if [ -d "$JETBRAINS_CONFIG_DIR" ]; then
	echo 'Removendo a licença trial...'
	sleep 3
	echo '###############################################################################'
	echo '# Digite uma das opções abaixo:                                               #'
	echo '# ps - Para remover a licença do PhpStorm                                     #'
	echo '# ws - Para remover a licença do WebStorm                                     #'
	echo '# dg - Para remover a licença do DataGrip                                     #'
	echo '# rm - Para remover a licença do RubyMine                                     #'
	echo '# sair - Para sair das opções e a removoção padrão do PhpStorm será executada #'
	echo '##############################################################################'

	LAST_VERSION_CONFIG=$(find "$HOME/.config/JetBrains/" -maxdepth 1 -type d -name "PhpStorm2021.2*" | sort -V | tail -1)

	while :
	do
        read INPUT_STRING
        case $INPUT_STRING in
            ps)
                LAST_VERSION_CONFIG=$(find "$HOME/.config/JetBrains/" -maxdepth 1 -type d -name "PhpStorm2021.2*" | sort -V | tail -1)
                break
                ;;
            ws)
                LAST_VERSION_CONFIG=$(find "$HOME/.config/JetBrains/" -maxdepth 1 -type d -name "WebStorm2021.2*" | sort -V | tail -1)
                break
                ;;
            dg)
                LAST_VERSION_CONFIG=$(find "$HOME/.config/JetBrains/" -maxdepth 1 -type d -name "DataGrip2021.2*" | sort -V | tail -1)
                break
                ;;
			rm)
                LAST_VERSION_CONFIG=$(find "$HOME/.config/JetBrains/" -maxdepth 1 -type d -name "RubyMine2021.2*" | sort -V | tail -1)
                break
                ;;
            sair)
                echo "Removendo a licença trail do PhpStorm..."
                sleep 3
                break
                ;;
            *)
                echo "Esta opção não existe!"
                ;;
        esac
    done

	if [ -d "$LAST_VERSION_CONFIG/eval" ]; then
		echo "#1 Removendo -> $LAST_VERSION_CONFIG/eval"
		rm -rf "$LAST_VERSION_CONFIG/eval"
		sleep 2
		echo "#2 Removendo -> $LAST_VERSION_CONFIG/options/other.xml"
		rm -rf "$LAST_VERSION_CONFIG/options/other.xml"
		sleep 2
	fi

	JETBRAINS_CONSENTOPTIONS=$(find "$HOME/.local/share/JetBrains/" -maxdepth 1 -type d -name "consentOptions*" | sort -V | tail -1)
	JAVA_USERPREFS=$(find "$HOME/.java/" -maxdepth 1 -type d -name ".userPrefs*" | sort -V | tail -1)

	if [ -d "$JETBRAINS_CONSENTOPTIONS" ]; then
		echo "#3 Removendo -> $JETBRAINS_CONSENTOPTIONS"
		rm -rf "$JETBRAINS_CONSENTOPTIONS"
		sleep 2
	fi
	if [ -d "$JAVA_USERPREFS" ]; then
		echo "#4 Removendo -> $JAVA_USERPREFS"
		rm -rf "$JAVA_USERPREFS"
		sleep 2
	fi

	echo "."
	sleep 1
	echo ".."
	sleep 1
	echo "..."
	sleep 2
	echo "Remoção efetuada com sucesso! HAPPY HACKING..."
	
else
	echo 'Nenhuma IDE da JetBrains está instalada na máquina...'
fi
