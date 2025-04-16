# JSON to XML Converter with Hash and Fixed Fields
# WEB API
# Deploy GCP - Cloud Run Functions

import json
import datetime
import dicttoxml
from flask import Flask, request, jsonify
import functions_framework

@functions_framework.http
def json2xml(request):
    if request.method != 'POST':
        return jsonify({"error": "Please use POST method"}), 405

    try:
        # Parse JSON from the request
        data = request.get_json()
        if not data:
            return jsonify({"error": "Invalid JSON payload"}), 400
        
        # q: Create a field named hash with the hash code based on the original json sent
        
        # Convert the JSON to a string and encode it to bytes
        json_string = json.dumps(data, sort_keys=True).encode('utf-8')
        
        # Calculate the hash
        hash_code = hashlib.sha256(json_string).hexdigest()
        
        # Add the hash to the data
        data['hash'] = hash_code
        
        # Add fixed fields
        data['company'] = "Insper"
        data['now'] = datetime.datetime.now().isoformat()

        # Convert to XML
        xml_data = dicttoxml.dicttoxml(data, custom_root='root', attr_type=False)

        return xml_data, 200, {'Content-Type': 'application/xml'}
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500
