# Experimental-Completion

This is my internship/GSoC2019 project. The goal of it is to improve the code completion in Pharo. For that I structured my completion tool into three main classes: the matcher (MatchedNodeProducer), the completer (CompletionEngine) and the sorter (Sorter). There are also several tests classes. At the moment the code completion returns the list of results that are possible considering the cursor position. To understand how it works one can use the spec (or just have a look at the tests).

The spec (which is in the NewCompletionSpec package) can be opened by executing:
```smalltalk
CompletionSpec new openWithSpec 
```

Some functionality (mainly the CompletionContext class) was added to hook the new completion into the system, using cleaned up and refactored code of the old completion. Using CompletionController the completion is appearing in the settings as the third completion option. It can be enabled by going to Settings Browser -> Code Browsing -> Code Completion, and then in the Controller section selecting CompletionController (see screenshot; NECController would represent the completion used in Pharo by default):

![alt text](https://github.com/myroslavarm/Experimental-Completion/blob/master/github.png)

So far this is still a work in progress: as of now only some of the basic typing functionality was done to actually be used by the system, most of the actual NewCompletion improvements are yet to replace the old functionality.
