# pygeoapi demo with elasticsearch

This is a demo of pygeoapi with elasticsearch as the data provider.

## Start the containers

```bash
docker compose up --build -d
```

## Access the pygeoapi endpoint

The API is available at [http://localhost:5000](http://localhost:5000)

## CRUD operations

Elasticsearch is one on the two pygeoapi data providers that support CRUD operations (see [pygeoapi documentation](https://docs.pygeoapi.io/en/latest/data-publishing/ogcapi-features.html#ogcapi-features) for more information).

### GET operation

Get the first item of the `ne_110m_populated_places_simple` collection:

```bash
curl -X GET http://localhost:5000/collections/ne_110m_populated_places_simple/items/0 | jq 'del(.links)' > output.geojson
```

> [!NOTE] The `jq` command is used to retrieve the response without the `links` object.

### DELETE operation

Delete the first item of the `ne_110m_populated_places_simple` collection:

```bash
curl -X DELETE http://localhost:5000/collections/ne_110m_populated_places_simple/items/0
```

### POST operation

Add the deleted item back to the `ne_110m_populated_places_simple` collection:

### PUT operation

Update the first item of the `ne_110m_populated_places_simple` collection:

```bash
curl -X PUT -H "Content-Type: application/json" -d @output.geojson http://localhost:5000/collections/ne_110m_populated_places_simple/items/186
```

> [!IMPORTANT] The `PUT` operation requires the whole item content to be sent in the request body.

### PATCH operation

The `PATCH` operation is not supported by the elasticsearch data provider.
