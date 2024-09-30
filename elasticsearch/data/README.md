# Elasticsearch data ingestion with GDAL

```sh
ogr2ogr -f Elasticsearch \ 
-lco NOT_ANALYZED_FIELDS={ALL} \
-lco INDEX_NAME=historisches_areal \
-lco OVERWRITE_INDEX=YES \
http://localhost:9200 \
data/swissNAMES3D.gpkg
```

>[!IMPORTANT]
This command does not work because the properties must be nested in a field called `properties`.
It could also be simplified.

## Delete the index

```bash
curl -X DELETE "http://localhost:9200/historisches_areal"
```


ogr2ogr -f "Elasticsearch" \
    ES:http://localhost:9200 \
    elasticsearch/data/ \
    -lco WRITE_MAPPING=YES \
    -lco FIELD_NAME_ENCLOSURE=NONE \
    -dialect SQLite \
    -sql "SELECT geometry, json_group_object(key, value) as properties FROM 'Historisches_Areal'"



ogr2ogr -f Elasticsearch \
-lco NOT_ANALYZED_FIELDS={ALL} \
-lco INDEX_NAME=historisches_areal \
-lco OVERWRITE_INDEX=YES \
http://localhost:9200 \
-dialect SQLite \
-sql "SELECT geom, json_object('FID', 'NAME') as properties" \
data/swissNAMES3D.gpkg \



ogr2ogr -f "Elasticsearch" \
    ES:http://localhost:9200/ \
    elasticsearch/data/swissNAMES3D.gpkg \
    -lco WRITE_MAPPING=YES \
    -lco FIELD_NAME_ENCLOSURE=NONE \











## Create the mapping configuration

```sh
ogr2ogr -lco INDEX_NAME=historisches_areal -lco NOT_ANALYZED_FIELDS={ALL} -lco WRITE_MAPPING=./mapping.json ES:http://localhost:9200 swissNAMES3D.gpkg
```

## Ingest the data

```sh
ogr2ogr -lco INDEX_NAME=historisches_areal -lco OVERWRITE_INDEX=YES -lco MAPPING=./mapping.json ES:http://localhost:9200 swissNAMES3D.gpkg
```




## bin


ogr2ogr -lco MAPPING_NAME=doc -lco INDEX_NAME=historisches_areal -lco OVERWRITE_INDEX=YES -lco MAPPING=./mapping.json ES:http://localhost:9200 swissNAMES3D.gpkg





### More simple option

>[!IMPORTANT]
Cette option ne fonctionne pas car les propriétés doivent se trouver dans un nested field appelé `properties` 

```sh
ogr2ogr ES:http://localhost:9200 swissNAMES3D.gpkg 
```



## Query the data

```sh
curl -X GET "http://localhost:9200/historisches_areal/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "from": 0,
  "size": 1
}
'
```

http://localhost:9200/historisches_areal/_doc/TepNCZIBsCDxSL3SBLle?pretty


http://localhost:9200/ne_110m_populated_places_simple/_doc/0?pretty

