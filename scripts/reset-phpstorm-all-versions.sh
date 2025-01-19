#!/bin/bash
JAVA_USERPREFS_DIR="$HOME/.java/.userPrefs/"
if [ -d "$JAVA_USERPREFS_DIR" ]; then
	echo 'Removendo a licença trial...'
	sleep 2
  JAVA_USERPREFS_JETBRAINS_DIR="$HOME/.java/.userPrefs/jetbrains/"

	remove_prefs_files() {
      local TARGET_DIR="$1"

      if [ -d "$TARGET_DIR" ]; then
          echo "Removendo arquivo prefs.xml do diretório: $TARGET_DIR"
          find "$TARGET_DIR" -maxdepth 1 -type f -name "prefs.xml" -exec rm -f {} \;
          sleep 1
          echo "."
          sleep 1
          echo ".."
          sleep 1
          echo "..."
      else
          echo "Diretório não encontrado: $TARGET_DIR"
      fi
  }

  remove_prefs_files "$JAVA_USERPREFS_DIR"
  remove_prefs_files "$JAVA_USERPREFS_JETBRAINS_DIR"

	echo "Remoção efetuada com sucesso! HAPPY HACKING..."
else
	echo 'Não foi possível remover a licença trail do PhpStorm...'
fi
