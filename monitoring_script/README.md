# check_disk_space.sh

## Description
Le script **`check_disk_space.sh`** est un utilitaire Bash simple et efficace permettant de **surveiller l’utilisation de l’espace disque** sur un système Linux, macOS ou **Windows (via WSL)**.  

Il vérifie chaque partition montée, compare le taux d’utilisation avec un **seuil critique** défini, et :  
- Affiche un **message d’alerte** si ce seuil est dépassé,  
- Enregistre les résultats dans un **fichier de log séparé**,  
- Fournit un moyen simple de suivre la santé du stockage du système.

---

## Fonctionnalités principales

- Analyse automatique de toutes les partitions montées (`df -h`).  
- Alerte lorsque le taux d’utilisation dépasse un seuil critique configurable (ex. 80%).  
- Journalisation des résultats dans un fichier log (`disk_space.log`).  
- Ajout d’un horodatage pour chaque vérification.  
- Compatible Linux, macOS et WSL (Windows 10/11).  

---

## Structure du script

Le script contient :
1. Une **variable `THRESHOLD`** définissant le pourcentage critique (par défaut 80%).  
2. Une **boucle** qui parcourt chaque partition renvoyée par `df`.  
3. Un **test conditionnel** pour générer une alerte si le seuil est dépassé.  
4. Un **fichier de log** où toutes les vérifications sont enregistrées.

---
