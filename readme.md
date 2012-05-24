#mongomerge

mongomerge is a utility for merging the collections of one mongodb database
into another

##usage

```
$ mongomerge.rb source_uri target_uri [--drop]
```

##example

```
$ mongomerge.rb mongodb://user:pass@db.example.com:8432/source mongodb://user:pwd@db2.example.org:9481/target
```


