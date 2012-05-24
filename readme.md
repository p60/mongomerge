#mongomerge

mongomerge is a utility for merging the collections of one mongodb database
into another

##usage

```
$ mongomerge.rb source_uri target_uri [--drop]
```

##example

```
$ mongomerge.rb mongodb://user:pass@mongo.example.com:18432/source-db mongodb://ouser:opass@db.othermongohost.com:19481/target-db
```


