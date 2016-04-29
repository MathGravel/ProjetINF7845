# INF7845 - Projet de session
Bienvenue dans le code source du projet de session pour le cours d'INF7845

# Équipiers
* Mathieu Gravel


# Description
Implémentation des nit des 3 algorithmes suivants :

* parseur Midi
* Algorithme PrefixSpan
* Clustering hiérachique

#Parseur Midi

Implémentation en Nit d'un parser de fichiers Midi.
Inspiré des sites des références :
 - [CSIE](https://www.csie.ntu.edu.tw/~r92092/ref/midi/)
 - [Université Stanford](http://www.ccarh.org/courses/253/handout/smf/)

## Utilisation
  * make
  * ./midiparser \{fichierMidi.mid\}
  * Le programme va alors afficher les tracks en cours d'analyse et aux finales, les notes retrouvés ainsi que leurs durées.
## Fichier de tests
	Des fichiers Midi peuvent être trouvés par les liens suivants :
 - [VgMusic](http://www.vgmusic.com/)
 - [mididb](http://mididb.com/)
 - [piano-midi](http://www.piano-midi.de/)



#Algorithme PrefixSpan

Implémentation en Nit de l'algorithme PrefixSpan
Inspiré des sites des références :
 - [Librairie SPMF](http://www.philippe-fournier-viger.com/spmf/)
 - [Université Alberta](https://webdocs.cs.ualberta.ca/~zaiane/courses/cmput695-04/slides/PrefixSpan-Wojciech.pdf)

## Utilisation
  * make
  * ./prefixspan \{fichierDeDonnes.txt\} datatype minSupport maxSupport
  * (datatype = 1 pour des Int et datatype = 2 pour des Strings)
  * minSupport égale le nombre d'occurence minimale pour les patterns à noter.
  * maxSupport égale la taille maximale d'un pattern possible. Pour n'avoir pas de taille limite, maxSupport = 0.
  * Le programme va alors afficher les patterns du fichier analysé.

## Fichiers de tests
  Des fichiers de tests peuvent être trouvés dans le folder Prefix.
  Attention : Dû à une erreur dans le fonctionnement de la fonction is_num en Nit pour certains caractères, tout fichiers de données String doivent être composés au min de 2 caractères. 

#Algorithme Clustering hiérachique

Implémentation en Nit de l'algorithme de clustering hiérachique
Inspiré des sites des références :
 - [Clustering](https://github.com/lbehnke/hierarchical-clustering-java)
 - [Clusters](https://github.com/gyaikhom/agglomerative-hierarchical-clustering)

Attention, cette librairie n'a pas été testé au même niveau que les 2 précédentes dû à son manque possible d'innovation en language objet et peut dont avoir des erreurs lors de son fonctionnement.

# Remerciements

* Jean Privat : Professeur du cours
* Jean Massardi : Aide pour le cours d'apprentissage automatique.
* Université d'alberta : Explications pour PrefixSpan
* CSIE et Stanford University : Explications sur la spécification MIDI.
* lbehnke et gyaikhom : Inspiration pour le clustering hiérachique.
* etc.