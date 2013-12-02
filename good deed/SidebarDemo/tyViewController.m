//
//  tyViewController.m
//  Good Deed Marathon
//
//  Created by Nishant on 06/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "tyViewController.h"
#import "SWRevealViewController.h"
#import "interViewController.h"
#import "Reachability.h"
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
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    };
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"checkkkk!!!!!!!!!");
            interViewController *interViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"interViewController"];
            // If you are using navigation controller, you can call
            [self.navigationController pushViewController:interViewController animated:NO];
            
        });
    };
    
    [reach startNotifier];

    UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 129, 41)];// Here you can set View width and height as per your requirement for displaying titleImageView position in navigationba
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navlogo.png"]];
    titleImageView.frame = CGRectMake(0, 0,129 , 41); // Here I am passing origin as (45,5) but can pass them as your requirement.
    [backView addSubview:titleImageView];
        self.navigationItem.titleView = backView;
        self.navigationItem.hidesBackButton = YES;
	// Do any additional setup after loading the view.
    _sidebarButton.tintColor = [UIColor whiteColor];
    //
       [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    //    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)share:(id)sender {
    NSArray * activityItems = @[[NSString stringWithFormat:@"I’m all set to make Mumbai a shiny happy place. Want to join in? Register for the Good Deed Marathon here! http://bit.ly/1bqAJBL"]];
    NSArray * applicationActivities = nil;
    NSArray * excludeActivities = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePostToWeibo, UIActivityTypePrint, UIActivityTypeMessage];
    
    UIActivityViewController * activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
    activityController.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityController animated:YES completion:nil];
}
@end
