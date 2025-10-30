#!/bin/bash

# ==============================
# Objectif : Surveiller l’espace disque et alerter en cas de dépassement de seuil
# ==============================

# Seuil critique en pourcentage
THRESHOLD=80

# Fichier de log
LOG_FILE="espace_disque.log"

# Date et heure actuelle
DATE=$(date +"%Y-%m-%d %H:%M:%S")

# On récupère les partitions montées et leur utilisation
# On ignore la première ligne d'en-tête de df
df -h --output=target,pcent | tail -n +2 | while read line; do
    # Séparer le point de montage et le pourcentage
    MOUNT=$(echo $line | awk '{print $1}')
    USAGE=$(echo $line | awk '{print $2}' | tr -d '%')

    # Message de base
    MESSAGE="[$DATE] Partition $MOUNT : utilisation $USAGE%"

    # Vérification du seuil
    if [ "$USAGE" -ge "$THRESHOLD" ]; then
        echo "$MESSAGE   ATTENTION : seuil critique ($THRESHOLD%) dépassé !" | tee -a "$LOG_FILE"
    else
        echo "$MESSAGE   OK" >> "$LOG_FILE"
    fi
done