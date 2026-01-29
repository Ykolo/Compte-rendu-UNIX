# Compte rendu du TP1

## Objectifs:
 - Installation de le linux sur une machine virtuelle
 - Comprendre le fonctionnement de Linux et de ses outils

## Installation de Machine virtuelle

### Debian et supports d'installation 

Pour cette installation nous allons utiliser la distribution Debian (version stable, trixie), accessible sur http://ftp.fr.debian.org/debian/dists/trixie/main/installer-amd64/current/images/netboot/

On utilise VirtualBox pour lancer la machine virtuelle:

- On crée une nouvelle machine virtuelle, en choisissant la distribution Debian (version stable, trixie) 
- On choisit la taille de la machine virtuelle (2 Go de RAM, 50 Go de disque dur)

Dans la machine virtuellem on lance l'installation en mode expert: 
- On choisit la langue et la zone géographique (en_US.UTF-8)
- On configure le clavier (moi j'utilise du qwerty donc je n'ai pas fait de changement)
- On configure le réseau avec comme nom de système 'serveur1 et comme domaine 'ufr-info-p6.jussieu.fr'
- On choisit le miroir d'installation en http en France et en standard
- On active et les shadow passwords, les connection compte super utilisateur (root) et on ne crée pas de compte supplémentaire 
- On configure l'horloge sur le fuseau horaire de Paris
- On partitionne le disque dur en 4 partitions:
  - '/' la racine avec 10GO de taille avec le système de fichier ext4 et `Bootable flag` activé
  - '/tmp' l'espace tempo avec 4GO de taille avec le système de fichier ext4
  - '/var/log' les logs avec 1GO de taille avec le système de fichier ext4
  - '/swap' l'espace swap avec l'espace restant sur le disque dur avec le système de fichier swap
- On installe le `base system` puis on installe le kernel `linux-image-amd64` (qui prennent beaucoup de temps)
- On configure le package manager:
  - On empeche les `non free software`, les `contrib software`, `source` et les `logiciels retroporté`
  - On vérifie que les mise à jours sont activées pour les `check de sécurité` et `release`
- On empêche l'installation de tous les softwares
- On installe GRUB

Et finalement on reboot la machine virtuelle 

## Linux et son environnement

### Package
On éxécute la commande `dpkg -l | wc -l` pour compter le nombre de paquets installés. Moi j'ai eu 229.
[image du dpkg -l | wc -l](../images/tp1/dpkg.png)

### SSH
La configuration de SSH sera dans le tp2.

### Space Usage
On éxécute la commande `df -h` pour avoir l'espace disque utilisé sur la machine virtuelle.
[image du df -h](../images/tp1/space-usage.png)

### Résultats des commandes:
- `echo $LANG`: en_US.UTF-8 [image LANG](../images/tp1/lang.png)
- `man hostname`: ça nous donne le man de hostname et on trouve l'option -d pour donner le nom de domaine [image man](../images/tp1/man.png)
- `hostname -d`: ufr-info-p6.jussieu.fr [image hostname](../images/tp1/hostname.png)
- `cat /etc/apt/sources.list | grep -v -E ’^#|^$’`: deb http://deb.debian.org/debian/ trixie main [image cat-sources](../images/tp1/cat-sources.png)
- `cat /etc/shadow | grep -vE ’:\*:|:!\*:’`: je n'ai rien je pense que j'ai dû mal configurer quelque chose [image shadow](../images/tp1/shadow.png)
- `cat /etc/passwd | grep -vE ’nologin|sync’` :  [image users](../images/tp1/users.png)
- `fdisk -l et fdisk -x`:  [image fdisk](../images/tp1/fdisk.png)
- `df -h`: sert à afficher l'espace disque utilisé sur la machine virtuelle compréhensible par un humain c'est à dire en MO, GO

## Aller plus loin
 
Le `pressed` sert à automatiser les installations de Debian. On fournit un fichier de configuration contenant les réponses (langue, partitionnement, etc.), permettant de déployer plusieurs serveurs de manière identique sans intervention manuelle.

Le `Rescue mode`:
1. Redémarrer la machine virtuelle et appuie sur `e` au menu GRUB
2. Trouve la ligne qui commence par `linux` et ajoute `init=/bin/bash` à la fin de la ligne
3. Appuie sur `Ctrl+x` pour quitter le mode de démarrage
4. Remonte la partition racine en écriture: `mount -o remount,rw /`
5. Tape `passwd` pour changer le mot de passe de l'utilisateur root

Redimensionne la partition racine:
1. Augmenter la taille du disque dur de la machine virtuelle dans VirtalBox
2. Utiliser `fdisk` pour agrandir la partition racine
3. Utiliser `resize2fs /dev/sda1` pour redimensionner la partition racine
