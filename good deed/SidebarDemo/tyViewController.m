//
//  tyViewController.m
//  Good Deed Marathon
//
//  Created by Nishant on 06/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "tyViewController.h"

@interface tyViewController ()

@end

@implementation tyViewController

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.tyscroll layoutIfNeeded];
    self.tyscroll.contentSize = self.tyview.bounds.size;
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)share:(id)sender {
    NSString* someText = @"heyy";
    NSArray* dataToShare = @[someText];  // ...or whatever pieces of data you want to share.
    
    UIActivityViewController* activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:dataToShare
                                      applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:^{}];
}
@end
