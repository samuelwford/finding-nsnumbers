//
//  ViewController.m
//  SWFFindingNumbers
//
//  Created by Samuel Ford on 12/13/14.
//  Copyright (c) 2014 Samuel Ford. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // make a number and use it like a string
    id notAString = @123;
    self.label.text = notAString;
}

@end
