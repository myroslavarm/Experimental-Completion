# Experimental-Completion

### Information about the project:

This is my internship/GSoC2019 project. The goal of it is to improve the code completion in Pharo.

> Important note: most of the recent changes as of late July 2019 are only available in Pharo 8 and this repository is only maintained as a draft dev version. The plan is to put the finished completion here once the main changes for GSoC are implemented.

First, a test code completion engine was developed. For that, there are three main classes: the matcher (MatchedNodeProducer), the completer (CompletionEngine) and the sorter (Sorter), as well as the tests. The completion itself worked well (returned the list of possible results considering the cursor position).

After that, to hook the completion into the system, we started reusing some of the functionality from the old completion. For example, CompletionContext is the main hooking point, in particular this is where the model is called. CompletionController helps set up the completion option in the settings. To enable our completion as the main one, you can go to Settings Browser -> Code Browsing -> Code Completion, and then in the Controller section selecting CompletionController (see screenshot; NECController would represent the completion used in Pharo by default):

![alt text](https://github.com/myroslavarm/Experimental-Completion/blob/master/github.png)

TypingVisitor does the AST-based typing for the new completion. MatchedNodeProducer matches the nodes with specific behaviour. CompletionModel class is implemented to serve instead of the three separate NECModel subclasses: typed, untyped, and empty. And CompletionEntry is used instead of the multiple NECEntry classes.

So far this is still a work in progress so when something doesn't work and hasn't yet been mentioned in the "issues" for the project, we welcome the feedback.

### Loading the repository:

When the repository is first loaded and the message says 'uncommitted changes' it might be better to reload the specific packages. All 5 packages should be loaded.

After enabling the completion option in the settings, it can be tested hands-on&mdash;either in the Playground or the (Calypso) Editor. An intermediate version of code completion (which is basically a mix of the old and the new, for prior testing) has been already implemented into Pharo 8 and can be found in the settings as "TestCompletionController". Testing and feedback on that are also welcome.

> Dev note: for now, the classes in the Mock subpackage and CompletionEngine are only used for testing. MatchingRecentlyUsed is not yet fully completed and therefore doesn't work.

### Roadmap for the project:

Can be viewed [here](<https://medium.com/@myroslavarm/improving-code-completion-gsoc-2019-introduction-de36e106a12f>). And [here's](<https://medium.com/@myroslavarm/progress-with-code-completion-june-632e40a54553>) a blog post describing what has been done so far.
