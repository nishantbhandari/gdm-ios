//
//  ftViewController.m
//  Good Deed Marathon
//
//  Created by Nishant on 07/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "ftViewController.h"
#import "MainViewController.h"
@interface ftViewController ()

@end

@implementation ftViewController
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.ftScrollView layoutIfNeeded];
    self.ftScrollView.contentSize = self.ftView.bounds.size;
}

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

- (IBAction)next:(id)sender {
    MainViewController *myOtherViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    // If you are using navigation controller, you can call
    [self.navigationController pushViewController:myOtherViewController animated:YES];

    
}
@end
