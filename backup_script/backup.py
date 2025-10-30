#!/usr/bin/env python3
"""
Objectif : Sauvegarder un dossier vers un répertoire de sauvegarde 
           avec gestion d’erreurs et notification.
"""

import os
import shutil
import sys
import datetime
import traceback

# ==============================
# CONFIGURATION
# ==============================
SOURCE_DIR = "C:\\Users\\dln\\Documents\\projets"      # Dossier à sauvegarder
BACKUP_DIR = "C:\\Users\\dln\\Documents\\Backups"                 # Répertoire de sauvegarde
ADMIN_EMAIL = "test@exemple.fr"                        # Email de notification (simulé)

# ==============================
# FONCTIONS
# ==============================

def send_email_simulation(subject, message):
    """Simule l’envoi d’un email (affiche dans le terminal)."""
    print("\n=== Simulation d’envoi d’email ===")
    print(f"À : {ADMIN_EMAIL}")
    print(f"Sujet : {subject}")
    print("Message :")
    print(message)
    print("=== Fin du message ===\n")


def create_backup(src, dest):
    """Crée une sauvegarde du dossier source dans le dossier de destination."""
    try:
        if not os.path.exists(src):
            raise FileNotFoundError(f"Le dossier source n’existe pas : {src}")

        if not os.path.exists(dest):
            os.makedirs(dest)

        # Génération du timestamp (ex: backup_2025-10-30_14-20-05)
        timestamp = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
        backup_name = f"backup_{timestamp}"
        backup_path = os.path.join(dest, backup_name)

        print(f"Création de la sauvegarde : {backup_path}")
        shutil.copytree(src, backup_path)

        print(f"Sauvegarde réussie ✅ : {backup_path}")
        send_email_simulation(
            subject="Sauvegarde réussie",
            message=f"La sauvegarde du dossier '{src}' a été effectuée avec succès.\nEmplacement : {backup_path}"
        )

    except Exception as e:
        error_message = f"❌ Erreur lors de la sauvegarde : {str(e)}\n\nTraceback :\n{traceback.format_exc()}"
        print(error_message)
        send_email_simulation(
            subject="Échec de la sauvegarde ❌",
            message=error_message
        )


# ==============================
# POINT D’ENTRÉE DU SCRIPT
# ==============================
if __name__ == "__main__":
    print("=== Script de sauvegarde automatique ===")

    # Si des arguments sont passés : python backup.py <source> <destination>
    if len(sys.argv) == 3:
        SOURCE_DIR = sys.argv[1]
        BACKUP_DIR = sys.argv[2]

    print(f"Dossier source      : {SOURCE_DIR}")
    print(f"Répertoire de backup : {BACKUP_DIR}\n")

    create_backup(SOURCE_DIR, BACKUP_DIR)
