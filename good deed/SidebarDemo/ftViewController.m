//
//  ftViewController.m
//  Good Deed Marathon
//
//  Created by Nishant on 07/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "ftViewController.h"
#import "MainViewController.h"
#import "interViewController.h"
#import "Reachability.h"
@interface ftViewController ()

@end

@implementation ftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.hidesBackButton = YES;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
