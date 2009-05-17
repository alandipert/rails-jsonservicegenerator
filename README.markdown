To use, rename this repo's directory to: 

      ~/.rails/generators/service


Then, you can:

      script/generate service shirt name:string size:integer

And you'll get a scaffolded thing that parses CouchDB-style JSON-bodied requests.  This works (hackishly?) with request.body.string and ActiveSupport's from_json.
