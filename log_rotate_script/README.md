# log_rotate.sh

## Description
Le script **`log_rotate.sh`** permet d’automatiser la **rotation et la suppression** de fichiers journaux (`.log`) dans un dossier donné.  
Il est conçu pour être **simple, flexible et personnalisable**, afin d’éviter que les logs ne saturent le disque dur.

Le script :
- Fait **tourner** les fichiers de log lorsque leur taille dépasse un certain seuil (rotation).
- **Supprime automatiquement** les anciens logs dépassant un âge défini (en jours).
- Garde un nombre configurable d’historiques (log.1, log.2, …).
- Écrit toutes les actions dans un **fichier de suivi (`rotation.log`)**.

---

## Fonctionnalités principales

- **Rotation automatique** des logs dépassant une taille donnée (en Mo).
- **Nettoyage automatique** des fichiers logs plus anciens qu’un nombre de jours spécifié.
- **Historique configurable** : conserve un certain nombre de versions précédentes (log.1, log.2, etc.).
- **Timestamps complets** pour tracer toutes les actions dans le fichier `rotation.log`.
- Léger, portable et compatible **Linux / macOS / WSL sous Windows**.

---

## Utilisation

### Syntaxe de commande

```bash
./log_rotate.sh [-d dossier_logs] [-t jours] [-s taille_Mo] [-r rotations]
