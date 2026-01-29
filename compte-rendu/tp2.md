# Compte rendu TP2

## Objectifs:
- Comprendre et configurer SSH
- Processus
- Tubes
- Logs

## SSH

### Installation 

1. `apt update && apt install openssh-server`: installation de openssh-server
2. Editer le fichier `/etc/ssh/sshd_config` pour activer le service sshd
3. Cherchez la ligne `PermitRootLogin yes` et changez le `yes` par `no`
4. Redémarrez le service sshd: `systemctl restart sshd`
5. `man sshd_config` pour avoir plus d'informations sur le fichier de configuration

### Clé d'authentification

`ssh-keygen -t rsa -b 4096`: générer une clé ssh sur la machine locale

### Conexion par clé

1. changer la connexion NAT en bridge sur la machine virtuelle
2. `ssh-copy-id -i ~/.ssh/id_rsa.pub root@192.168.1.44`: copier la clé sur la machine distante
3. `chmod 700 /root/.ssh`: Droit R/W/X pour le proprio 
4. `chmod 600 /root/.ssh/authorized_keys`: Droit R/W pour le proprio 

### Connexion SSH

`ssh root@192.168.1.44`: se connecter à la machine distante [image ssh](../images/tp2/ssh.png)

### Sécurisation 

Editer le fichier `/etc/ssh/sshd_config`, passer le `PermitRootLogin yes` en `prohibit-password`

Qu'est ce qu'une attaque par brute force en ssh ? C'est quand un robot essaye de deviner ton mot de passe en testant des milliers de combinaisons très rapidement jusqu'à trouver la bonne. C'est pour ça qu'utiliser une clé SSH est beaucoup plus sûr qu'un mot de passe.

Autres techniques pour se protéger :
- Fail2Ban : Un logiciel qui bannit l'adresse IP de celui qui se trompe trop de fois de mot de passe.
  - Avantage : Bloque les robots automatiquement.
  - Inconvénient : Si l'administrateur se trompe lui-même de mot de passe plusieurs fois, il peut être banni de son propre serveur.
- Changer le port (ex: 2222) : Déplacer le SSH du port 22 vers un autre numéro.
  - Avantage : Cache le serveur aux yeux des robots de base.
  - Inconvénient : Ce n'est pas une "vraie" sécurité (c'est juste du camouflage) ; un pirate expérimenté peut scanner tous les ports pour trouver le nouveau.
- AllowUsers : Créer une liste de noms d'utilisateurs qui ont le droit de se connecter, et interdire tous les autres.
  - Avantage : Contrôle total sur qui entre.
  - Inconvénient : Si tu crées un nouvel utilisateur et que tu oublies de l'ajouter à la liste, il ne pourra jamais se connecter au serveur.
