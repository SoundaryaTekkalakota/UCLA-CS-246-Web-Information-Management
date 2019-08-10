#!/bin/bash

# Uncomment the following two commands to compile and execute your modified ParseJSON code in this script.

 javac ParseJSON.java
 java ParseJSON

# TASK 2A:
# Create and index the documents using the default standard analyzer
#created an index names task2a for bulk type and prettied them
#the input for this is taken from the out.txt into which JSON docs prepended with

curl -XPOST 'localhost:9200/task2a/_bulk?pretty' --data-binary @data/out.txt


# TASK 2B:
# Create and index with a whitespace analyzer

curl -XPUT 'localhost:9200/task2b?pretty' -H 'Content-Type: application/json' -d' 
{
    "mappings": {
        "wikipage" : {
            "_all" : {
                "type" : "text",
                "index" : "analyzed", 
                "analyzer" : "whitespace"
            },
            "properties" : {
                "abstract" : {
                    "type" : "text", 
                    "analyzer" : "whitespace"
                },
                "title" : {
                    "type" : "text", 
                    "analyzer" : "whitespace"
                },
                "url" : {
                    "type" : "text", 
                    "analyzer" : "whitespace"
                },
                "sections" : {
                    "type" : "text", 
                    "analyzer" : "whitespace"
                }
            }
        }
    }
}'

curl -XPOST 'localhost:9200/task2b/_bulk?pretty' --data-binary @data/out.txt




# TASK 2C:
# Create and index with a custom analyzer as specified in Task 2C



curl -XPUT 'localhost:9200/task2c?pretty' -H 'Content-Type: application/json' -d'
{
    "settings": {
        "analysis": {
            "char_filter": {
                "my_char_filter": {
                    "type": "html_strip"
                }
            },
            "tokenizer": {
                "my_tokenizer": {
                    "type": "standard"
                }
            },
            "filter": {
                "my_ascii_folding": {
                    "type": "asciifolding"
                },
                "my_lowercase": {
                    "type": "lowercase"
                },
                "my_stop": {
                    "type": "stop"
                },
                "my_snow": {
                    "type": "snowball"
                }
            },
            "analyzer": {
                "my_analyzer": {
                    "type": "custom",
                    "char_filter": "my_char_filter",
                    "tokenizer": "my_tokenizer",
                    "filter": ["my_ascii_folding", "my_lowercase", "my_stop", "my_snow"]
                }
            }
        }
    },
    "mappings": {
        "wikipage" : {
            "_all" : {
                "type" : "text",
                "index" : "analyzed", 
                "analyzer" : "my_analyzer"
            },
            "properties" : {
                "abstract" : {
                    "type" : "text", 
                    "analyzer" : "my_analyzer"
                },
                "title" : {
                    "type" : "text", 
                    "analyzer" : "my_analyzer"
                },
                "url" : {
                    "type" : "text", 
                    "analyzer" : "my_analyzer"
                },
                "sections" : {
                    "type" : "text", 
                    "analyzer" : "my_analyzer"
                }
            }
        }
    }
}'

curl -XPOST 'localhost:9200/task2c/_bulk?pretty' --data-binary @data/out.txt
