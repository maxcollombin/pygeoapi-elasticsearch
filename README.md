# Basic elasticsearch docker setup

This is a basic setup for elasticsearch with docker and a python script to index a geojson file.

## Access Elasticsearch indices

You can access the elasticsearch indices at:

`http://localhost:9200/_cat/indices?v`

## Retrieve documents from the index

You can retrieve documents from the index using the following commands (replace `$INDEX_NAME` with the name of the index you created):

```bash
curl -X GET "http://localhost:9200/$INDEX_NAME/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match_all": {}
  }
}'
```

## Retrieve a document with a specific id

You can retrieve a document with a specific id from the index with the following command (replace `$INDEX_NAME` with the name of the index you created and `$DOCUMENT_ID` with the id of the document you want to retrieve):

```bash
curl -X GET "http://localhost:9200/$INDEX_NAME/_doc/$DOCUMENT_ID?pretty"
```

> [!NOTE]
The data_loader.py script is currently limited to geojson files.
