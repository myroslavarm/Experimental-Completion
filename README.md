# Experimental-Completion

#### Information about the project:

This is a project I started working on during my internship in the summer of 2018 and continued during GSoC2019. The project's goal it is to improve the code completion in Pharo.

> Important note: most of the recent changes as of late July 2019 are only available in Pharo 8 and this repository is only maintained as a draft dev version.

The architecture is like this: 

- CompletionController for setting the completion engine in the Settings
- CompletionContext for creating the model and parsing the nodes
- CompletionProducer for completing based on node type
- TypingVisitor for assigning types to nodes
- CompletionSorter for establishing various sorting strategies

If you go to Settings Browser -> Code Browsing -> Code Completion you can choose between CompletionController (our completion) and NECController (old completion) for the Controller, and (right now) between AlphabeticalSorter and ReverseAlphabeticalSorter for the Sorter.

![alt-text](https://github.com/myroslavarm/Experimental-Completion/blob/master/gsoc1.PNG)

#### Blog posts about the progress and further plans:

Improving Code Completion @ GSoC 2019: introduction - [link](https://medium.com/@myroslavarm/improving-code-completion-gsoc-2019-introduction-de36e106a12f).

Progress with Code Completion [June] - [link](https://medium.com/@myroslavarm/progress-with-code-completion-june-632e40a54553).

Test Code Completion has been added to Pharo 8! - [link](https://medium.com/@myroslavarm/test-code-completion-has-been-added-to-pharo-8-d89a8eb64d68).

Latest completion update: simpler, better - [link](https://medium.com/@myroslavarm/latest-completion-update-simpler-better-7a941f2bd8d8).

Discovering AST implementation errors in Pharo - [link](https://medium.com/@myroslavarm/discovering-ast-implementation-errors-in-pharo-ceb335b98c68).

Machine Learning for Code Completion - [link](https://medium.com/@myroslavarm/machine-learning-for-code-completion-2583792997e3).

Code Completion in Pharo: GSoC Project Summary - [link](https://medium.com/@myroslavarm/code-completion-in-pharo-gsoc-project-summary-4cfe5c5282dd).

#### More links related to the work:

Video summing up the work done - [link](https://youtu.be/3E81xNUGieA).

List of PRs into the main Pharo repository - [link](https://github.com/pharo-project/pharo/pulls?q=is%3Apr+is%3Aclosed+author%3Amyroslavarm).

Work still left to do (list of issues in the repository) - [link](https://github.com/myroslavarm/Experimental-Completion/issues).

![alt-text](https://github.com/myroslavarm/Experimental-Completion/blob/master/gsoc2.PNG)
