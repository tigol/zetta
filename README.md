# Zetta the server

## Overview
The server is a Rails based app

* A live instance: http://tgl.herokuapp.com

## Setup

0. Prerequisite: 1) Ruby 1.9.3 2) mongoDB 2.0.6 3) Rubygems 4) bundler

1. Start mongoDB with "mongod --path=/path/to/your/db/directory"

2. Check out source code via git

3. Enter zetta directory, run "bundle install"

4. Run "rake test", all tests should pass

5. Start the server by running "rails s"

6. Navigate to "http://localhost:3000/topics.json"

## Server API
### Topic
#### List all topics

    GET /topics.json

#### Retrieve a single topic

    GET /topics/{topic_id}.json

#### Create a new topic
* Client needs to specify the "Content-Type" HTTP header with value "application/json"
* The POST should be sent to /topics.json
* The HTTP request body needs to contain a JSON document with a JSON property called "topic"

Sample request:

    POST /topics.json
    Content-Type: "application/json"    
    {
      "topic": {
        "name": "gas filling",
        "properties": [
          {
            "name": "Location",
            "code": "location",
            "datatype": "string"
          },
          {
            "name": "Cost",
            "code": "cost",
            "datatype": "decimal"
          },
          {
            "name": "Gas Type",
            "code": "gas_type",
            "datatype": "enum"
          },
          {
            "name": "Date",
            "code": "date",
            "datatype": "datetime"
          }
        ]
      }
    }
    
#### Update a topic
* "code" property is generated and assigned to a topic and cannot be updated
* To update a topic, simply retrieve its JSON representation, and modify the corresponding value and send it back to server via PUT request with "Content-Type" header set to "application/json"
* In the following example, the topic name is updated, and the Gas Type property is updated to be of "string" type

Sample request:

    Content-Type: application/json

    PUT /topics/{topic_id}.json
       
    {
      "topic": {
        "name": "Gas Filling Updated",
        "properties": [
          {
            "name": "Location",
            "code": "location",
            "datatype": "string"
          },
          {
            "name": "Cost",
            "code": "cost",
            "datatype": "decimal"
          },
          {
            "name": "Gas Type",
            "code": "gas_type",
            "datatype": "string"
          },
          {
            "name": "Date",
            "code": "date",
            "datatype": "datetime"
          }
        ]
      }
    }
    
#### Delete a topic

    DELETE /topics/{topic_id}.json

### Tot
Tot stands for a log entry for a topic. It is called 'tot' because I cannot think of a better term for this concept and the word looks funny.

#### List all tots belonging to a topic

	GET /topics/{topic_id}/tots.json

#### Retrieve a single tot

	GET /topics/{topic_id}/tots/{tot_id}.json

### Topic schema
This will not be implemented in the initial version