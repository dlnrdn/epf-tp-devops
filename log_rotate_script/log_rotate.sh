#!/bin/bash
# ================================================
# Objectif : Faire tourner les logs d’un dossier,
#            supprimer les anciens ou trop volumineux
# ================================================

# --- CONFIGURATION PAR DÉFAUT ---
LOG_DIR="C:\Users\dln\Desktop\tp-devops\log_rotate_script"     # Dossier contenant les logs
MAX_DAYS=7                   # Supprime les logs plus vieux que X jours
MAX_SIZE_MB=10               # Taille maximale d’un log en Mo avant rotation
ROTATE_COUNT=5               # Nombre de versions à conserver (log.1, log.2, etc.)
LOG_ROTATE_FILE="rotation.log"  # Fichier de log de rotation interne

# --- FONCTION D’AIDE ---
usage() {
    echo "Usage: $0 [-d dossier_logs] [-t jours] [-s taille_Mo] [-r rotations]"
    echo "Exemple: $0 -d /var/log/app -t 14 -s 20 -r 3"
    exit 1
}

# --- PARSE DES ARGUMENTS ---
while getopts "d:t:s:r:" opt; do
    case $opt in
        d) LOG_DIR="$OPTARG" ;;
        t) MAX_DAYS="$OPTARG" ;;
        s) MAX_SIZE_MB="$OPTARG" ;;
        r) ROTATE_COUNT="$OPTARG" ;;
        *) usage ;;
    esac
done

# --- VALIDATIONS ---
if [ ! -d "$LOG_DIR" ]; then
    echo "❌ Erreur : le dossier $LOG_DIR n’existe pas."
    exit 1
fi

# --- DATE COURANTE ---
DATE=$(date +"%Y-%m-%d %H:%M:%S")

# --- ROTATION ---
echo "[$DATE] Démarrage de la rotation des logs dans $LOG_DIR" | tee -a "$LOG_ROTATE_FILE"

for file in "$LOG_DIR"/*.log; do
    [ -e "$file" ] || continue  # Ignore si aucun .log

    filename=$(basename "$file")
    size_mb=$(du -m "$file" | cut -f1)

    # Vérifie la taille du log
    if [ "$size_mb" -ge "$MAX_SIZE_MB" ]; then
        echo "[$DATE] 🔁 Rotation du fichier $filename (taille : ${size_mb}Mo)" | tee -a "$LOG_ROTATE_FILE"

        # Supprime l'ancien log le plus ancien si dépassement de ROTATE_COUNT
        if [ -e "$file.$ROTATE_COUNT" ]; then
            rm -f "$file.$ROTATE_COUNT"
        fi

        # Décale les fichiers (log.4 -> log.5, etc.)
        for (( i=$ROTATE_COUNT-1; i>=1; i-- )); do
            if [ -e "$file.$i" ]; then
                mv "$file.$i" "$file.$((i+1))"
            fi
        done

        # Renomme le log courant
        mv "$file" "$file.1"
        touch "$file"
        echo "[$DATE] ✅ Rotation terminée pour $filename" | tee -a "$LOG_ROTATE_FILE"
    fi
done

# --- SUPPRESSION DES LOGS TROP ANCIENS ---
echo "[$DATE] 🧹 Suppression des logs plus vieux que $MAX_DAYS jours..." | tee -a "$LOG_ROTATE_FILE"
find "$LOG_DIR" -type f -name "*.log*" -mtime +$MAX_DAYS -exec rm -f {} \;
echo "[$DATE] ✅ Nettoyage terminé." | tee -a "$LOG_ROTATE_FILE"

echo "[$DATE] --- Fin du script log_rotate.sh ---" | tee -a "$LOG_ROTATE_FILE"
