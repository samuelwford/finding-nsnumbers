# Finding Numbers Experiment

This project is basically an experiment to try out a way to find an NSNumber instance that was inadvertantly cast to an NSString and assigned to the text property of a UILabel.

It leverages the Objective-C runtime to add the methods from NSString that UILabel calls to NSNumber to assist in tracking down the instance.
