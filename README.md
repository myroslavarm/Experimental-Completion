# Experimental-Completion

This is my internship project. The goal of it is to improve the code completion in Pharo. For that I structured my completion tool into three main classes: the matcher (MatchedNodeProducer), the completer (CompletionEngine) and the sorter (Sorter). There are also several tests classes. At the moment the code completion returns the list of results that are possible considering the cursor position. So far there's no functionality to inject them into the code.

The package NewCompletionSpec contains the spec. To open it for testing some completion options execute:
```smalltalk
CompletionSpec new openWithSpec 
```
