#!/bin/bash

# Récupérer les noms de colonnes dynamiquement avec ogrinfo
columns=$(ogrinfo data/swissNAMES3D.gpkg \
    -sql "PRAGMA table_info('Historisches_Areal');" \
    | grep 'name (String)' \
    | grep -v -E 'fid|geom' \
    | cut -d '=' -f2 | tr -d ' ')

# Construire la liste des colonnes pour la requête SQL
column_list=$(echo $columns | tr ' ' ',')

# Construire dynamiquement la commande SQL
sql_query="SELECT geom, $column_list FROM 'Historisches_Areal';"

# Exécuter la requête SQL et formater les résultats en JSON avec jq
ogr2ogr -f GeoJSON /vsistdout/ data/swissNAMES3D.gpkg -dialect SQLite -sql "$sql_query" \
| jq -c '.features[] | {geom: .geometry, properties: .properties}' \
| while read -r doc; do
    curl -X POST "http://localhost:9200/historisches_areal/_doc" -H 'Content-Type: application/json' -d "$doc"
done