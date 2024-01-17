from flask import Flask, request
from urllib.parse import unquote

app = Flask(__name__)

@app.route('/gloves', methods=['GET'])
def get_query_parameter():
    # Get the full path and query string
    full_path = request.full_path

    # Extract the 'query' parameter from the full path
    query_parameter = full_path.split('query=')[1]
# 
    # Decode the query parameter
    # decoded_query_value = unquote(ful)

    return f'Decoded value after "query" parameter: {query_parameter}'

if __name__ == '__main__':
    app.run(debug=True)
