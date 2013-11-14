//
//  PartnersViewController.m
//  Good Deed Marathon
//
//  Created by Nishant on 15/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "PartnersViewController.h"
#import "SWRevealViewController.h"
@interface PartnersViewController ()

@end

@implementation PartnersViewController

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
    UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 129, 41)];// Here you can set View width and height as per your requirement for displaying titleImageView position in navigationba
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navlogo.png"]];
    titleImageView.frame = CGRectMake(0, 0,129 , 41); // Here I am passing origin as (45,5) but can pass them as your requirement.
    [backView addSubview:titleImageView];
    //titleImageView.contentMode = UIViewContentModeCenter;
    self.navigationItem.titleView = backView;
    
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    //
        _sidebarbutton.tintColor = [UIColor whiteColor];
    //    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarbutton.target = self.revealViewController;
    _sidebarbutton.action = @selector(revealToggle:);
    NSString *fullURL = @"http://flyingcursor.com/gdm/maps.html";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_partnersPage loadRequest:requestObj];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
