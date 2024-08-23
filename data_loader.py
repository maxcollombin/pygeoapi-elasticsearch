import json
import requests

# Create an index in Elasticsearch
index_name = "geojson_index"
index_url = f"http://localhost:9200/{index_name}"
index_mapping = {
    "mappings": {
        "properties": {
            "location": {
                "type": "geo_shape"
            }
        }
    }
}

response = requests.put(index_url, json=index_mapping)
print(response.status_code, response.text)

# Path to your GeoJSON file
geojson_file = 'data/ne_110m_populated_places_simple.geojson'

# Read the GeoJSON file
with open(geojson_file, 'r') as file:
    geojson_data = json.load(file)

# Elasticsearch URL
es_url = "http://localhost:9200/geojson_index/_doc"

# Iterate through each feature in the GeoJSON file and post it to Elasticsearch
for feature in geojson_data['features']:
    # You might need to modify this if your GeoJSON structure is different
    document = {
        "location": feature['geometry'],
        "properties": feature['properties']
    }
    response = requests.post(es_url, json=document)
    print(response.status_code, response.text)
