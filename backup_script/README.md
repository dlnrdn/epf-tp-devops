# backup.py

## Description
Le script **`backup.py`** permet de **sauvegarder un dossier spécifique** vers un répertoire de sauvegarde avec un **timestamp unique**.  

Il inclut :
- Gestion d’erreurs pour vérifier que le dossier source existe et que les permissions sont correctes.  
- Simulation d’envoi d’email pour notifier le succès ou l’échec de la sauvegarde.  
- Possibilité de passer les chemins source et destination en arguments.  

Ce script est idéal pour automatiser des sauvegardes locales ou pour tester des procédures de sauvegarde.

---

## Fonctionnalités principales

- **Sauvegarde avec timestamp** : chaque sauvegarde est stockée dans un dossier nommé `backup_YYYY-MM-DD_HH-MM-SS`.  
- **Gestion d’erreurs** : messages clairs et traçables si la source n’existe pas ou en cas de problème de copie.  
- **Notification par email simulée** : affiche le message dans le terminal.  
- Compatible **Windows, Linux, macOS**.  
- Utilisation d’arguments facultatifs pour personnaliser les dossiers source et destination.

---

## Utilisation

```bash
python backup.py [dossier_source] [dossier_sauvegarde]
