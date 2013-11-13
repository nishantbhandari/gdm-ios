//
//  galViewC.m
//  Good Deed Marathon
//
//  Created by Nishant on 13/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "galViewC.h"

@interface galViewC ()

@end

@implementation galViewC

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
    
    
    NSString *fullURL = @"http://gooddeedmarathon.com/getGallery.php";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    _gallView.scrollView.scrollEnabled = TRUE;
    [_gallView loadRequest:requestObj];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
