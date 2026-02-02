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

## Processus

- L'information TIME correspond au temps CPU cumulé, le temps total pendant lequel le processus a travaillé depuis son lancement.
- Le processus ayant le plus utilisé le CPU est la commande `ps -eo pid,ppid,cmd,pcpu --sort=-pcpu | head -n 15` [image ps-cpu](../images/tp2/ps-cpu.png)
- Le premier processus qui a été lancé est /bin/init, on utilise la commande `ps -eo pid,ppid,start,cmd | head -n 10` [image ps-start](../images/tp2/ps-start.png)
- Pour savoir à quelle heure la machine a été demarrée on utilise la commande `who -b` [image who-b](../images/tp2/who-b.png)
- Pour savoir le nombre de processus créés par depuis le démarrage on utilise la commande `cat /proc/loadavg` [image loadavg](../images/tp2/loadavg.png)

### PPID
- Pour afficher le PPID d'un processus on utilise la commande `ps -o pid,ppid,cmd` [image ppid](../images/tp2/ppid.png)
- Pour afficher la list ordonée des processus ancêtres de la commande ps en cours d'exécution on utilise la commande `ps -o pid,ppid,cmd --sort=-pid` [image parent](../images/tp2/parent.png)

### PSTREE
- `pstree` : affiche la structure de processus en arbre [image pstree](../images/tp2/pstree.png)

### TOP
- `top` : affiche les processus en cours d'exécution et leurs utilisation CPU 
- Quand on est dans `top` on appuie sur `shift + m` pour avoir la liste des processus par ordre décroissant de mémoire utilisée [images top M](../images/tp2/memory.png)
- Le processus ayant le plus utilisé de mémoire c'est `systemd`. C'est le gestionnaire de processus qui est lancé au démarrage de la machine. 
- Commandes:
  - Passer l'affichage en couleur: appuyer sur `z`
  - Mettre en avant la colonne de tri: `b`
  - Changer la colonne de tri: `<` et `>`
- `htop`: [image htop](../images/tp2/htop.png)
  - Avantages de htop:
    - Lisibilité immédiate : Les jauges en haut de l'écran permettent de comprendre instantanément si le système est saturé.
    - Gestion des processus : Vous pouvez envoyer un signal (comme SIGKILL) à un processus simplement en le sélectionnant et en appuyant sur F9.
    - Vue en arbre : Appuyer sur F5 affiche directement la hiérarchie parent-enfant (comme pstree), ce qui est très utile pour voir quel processus a lancé quel autre.
  - Inconvénients de htop:
    - Dépendances : Sur un serveur de production minimaliste ou en mode secours (Rescue), il est rare qu'il soit installé. Il faut donc toujours savoir manipuler top.
    - Consommation : Il utilise légèrement plus de cycles CPU pour rafraîchir son interface colorée, ce qui peut être un facteur sur des systèmes extrêmement limités.
