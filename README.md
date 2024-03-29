# Pathfind

## Introduction

Pathfind est un programme pour trouver le plus court chemin de fichier .map sous différents algorithmes.

## Fonctionnalités

PathFind implémente les algorithmes suivants
- FloodFill
- Dijkstra
- A*
- Weighted A*

## Installation

Pour installer et exécuté le programme il faut d'abord installer julia

```sh
https://julialang.org/downloads/
```
Se mettre en pkg
```sh
]
```
Dans la console 

Installé DataStructures
```sh
add DataStructures
```
Installé
```sh
add Images
```

Installé
```sh
add ImageView
```

Téléchargé les fichiers sources et mettre ça dans un répertoire. 
```sh
cd src
```

Puis 
```sh
include("main.jl")
```

## Précision fichiers

Les fichiers .map doit être du format 
-ligne 1 
-height ligne
-width colonne
-ligne 4
-contenant

Puis ils les caratères
- W correspond à une case de penalité de 8
- . correspond à une case normal de 1
- S correspond à une case penalité de 5
- T correspond à une case bloquante
- @ correspond à une case bloquante

Le reste sont des caises normals de 1





