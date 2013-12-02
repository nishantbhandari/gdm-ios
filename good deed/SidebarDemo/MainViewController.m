//
//  ViewController.m
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//
#import "Reachability.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "regViewController.h"
#import "tyViewController.h"
#import "ftViewController.h"
#import "interViewController.h"
#import "parViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize scrollView;


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.contentView.bounds.size;

}


- (void)didReceiveMemoryWarning
{
    _uTubeView = nil;
    _uTubeView2 = nil;
    [super didReceiveMemoryWarning];
}
-(void)utubeView:(UIView *)utubeMainView{

    ALScrollViewPaging *uTubeScroll = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 180)];
    //array for views to add to the scrollview
    NSMutableArray *views = [[NSMutableArray alloc] init];
    //array for colors of views
    
    //cycle which creates views for the scrollview
    NSString *str=@"https://gooddeedmarathon.com/getYoutubeVideoIds.php";
    NSURL *url=[NSURL URLWithString:str];
    NSData *data=[NSData dataWithContentsOfURL:url];
    NSError *error=nil;
    NSArray *response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"value = %@", [response objectAtIndex:0] );
    
    
    for (int i = 0; i < [response count]; i++) {
        self.myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,180)];
        //        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        NSString *urls = [response objectAtIndex:i];
        videoURL = [NSString stringWithFormat:@"http://youtube.com/embed/%@",urls] ;
        NSLog(@"%@",videoURL);
        videoHTML = [NSString stringWithFormat:@"\
                     <html>\
                     <head>\
                     <style type=\"text/css\">\
                     iframe {position:absolute; top:50%%; margin-top:-130px;}\
                     body {background-color:#000; margin:0;}\
                     </style>\
                     </head>\
                     <body>\
                     <iframe width=\"100%%\" height=\"240px\" src=\"%@\" frameborder=\"0\"></iframe>\
                     </body>\
                     </html>", videoURL];
        
        [self.myWebView loadHTMLString:videoHTML baseURL:nil];
        [self.view addSubview:_myWebView];
        
        
        //
        self.myWebView.scrollView.scrollEnabled = NO;
        self.myWebView.scrollView.bounces = NO;
        [utubeMainView setBackgroundColor:[UIColor blackColor]];
        [views addObject:self.myWebView];
    }
    
    //add pages to scrollview
    [uTubeScroll addPages:views];
    
    //add scrollview to the view
    [utubeMainView addSubview:uTubeScroll];
    
    [uTubeScroll setHasPageControl:YES];
}


-(void)homeViewChange:(NSString *)logcheck1{

    if ([logcheck1 isEqualToString:@"1"]) {
        NSLog(@"congo");
        _uTubeView2.hidden = NO;
        secondLabel1.hidden = NO;
        secondLabel2.hidden = NO;
        firstLabel2.hidden = NO;
        subBut.hidden = NO;
        galBut.hidden = NO;
        justBut.hidden = NO;
        justLab.hidden = NO;
        subLabel.hidden = NO;
        galLabel.hidden = NO;
        _uTubeView2.hidden = NO;
         [self utubeView:_uTubeView2];
         ///
        scrollView.scrollEnabled = YES;
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(logout)];
        [self.navigationItem setRightBarButtonItem:item];
        item.tintColor = [UIColor whiteColor];
    
        
        NSLog(@"%f",_contentView.frame.size.height);
        
        firstLabel1.hidden = YES;
        _uTubeView.hidden = YES;
        fblogin.hidden = YES;
        firstLabel3.hidden = YES;
        _uTubeView.hidden = YES;
        [_activityIndicator stopAnimating];
        

    }
    else if ([logcheck1 isEqualToString:@"0"]) {
    

        firstLabel1.hidden = NO;
        _uTubeView.hidden = NO;
        fblogin.hidden = NO;
        firstLabel3.hidden = NO;
        _uTubeView.hidden = NO;
        //
           scrollView.scrollEnabled = NO;
        _uTubeView2.hidden = YES;
        secondLabel1.hidden = YES;
        secondLabel2.hidden = YES;
        firstLabel2.hidden = YES;
        subBut.hidden = YES;
        galBut.hidden = YES;
        justBut.hidden = YES;
        justLab.hidden = YES;
        subLabel.hidden = YES;
        galLabel.hidden = YES;
        _uTubeView2.hidden = YES;
        [self utubeView:_uTubeView];
        self.navigationItem.rightBarButtonItem = nil;
        _activityIndicator.center = self.MainView.center;
        [_activityIndicator stopAnimating];

        
}


}
- (void)movieIsPlaying:(NSNotification *)notification
{
    NSLog(@"yooo23");
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationLandscapeLeft animated:NO];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uTubef:) name:@"UIMoviePlayerControllerDidEnterFullscreenNotification" object:nil];

    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{

        });
    };
    
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            interViewController *interViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"interViewController"];
            // If you are using navigation controller, you can call
            [self.navigationController pushViewController:interViewController animated:NO];
            
        });
    };
    
    [reach startNotifier];
    if ([PFUser currentUser] && // Check if a user is cached
        [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) // Check if user is linked to Facebook
    {
        fbrequest = [FBRequest requestForMe];
        
        [fbrequest startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            //        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            fbid = userData[@"id"];
            NSLog(@"fb? %@",fbid);
            [self homeViewChange:[self validateUser:fbid]];
            
            
        }];
        
    }
    else
    {
        
        
        [self homeViewChange:@"0"];
    }
    
    
    

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"asdassssss");
    if ([segue.identifier isEqualToString:@"up2home"])
    {
        NSLog(@"asdasd");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Please login to submit a good deed." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
        [alert show];
        
    }
}
-(NSUInteger)uTubef:(NSNotification *) notif{
    return UIInterfaceOrientationMaskAllButUpsideDown;

    NSLog(@"12333");
}

-(void) youTubeFinished:(NSNotification*) notif {

}
//-(BOOL) shouldAutorotate {
//    return NO;
//}
//-(NSUInteger)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait;
//}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationPortrait;
//}

- (void)viewDidLoad
{
    [_activityIndicator startAnimating];
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uTubef:) name:@"UIMoviePlayerControllerDidEnterFullscreenNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(youTubeFinished:) name:@"UIMoviePlayerControllerWillExitFullscreenNotification" object:nil];
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"wasLaunchedBefore"]) {
        NSLog(@"first time");
        
        ftViewController *myOtherViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ftViewController"];
        // If you are using navigation controller, you can call
        [self.navigationController pushViewController:myOtherViewController animated:YES];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"wasLaunchedBefore"];
    }
    


    UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 129, 41)];    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navlogo.png"]];
    titleImageView.frame = CGRectMake(0, 0,129 , 41);
    [backView addSubview:titleImageView];
    self.navigationItem.titleView = backView;
    _sidebarButton.tintColor = [UIColor whiteColor];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);

    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

}


-(NSString *)validateUser:(NSString*)userid {
    
    
    NSString * post = [[NSString alloc] initWithFormat:@"id=%@",userid];
    NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString * postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.gooddeedmarathon.com/check-ios.php?id=%@",userid]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
      NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];

    return returnString;
}
-(void)loginbutton{
    [_activityIndicator startAnimating];
    // The permissions requested from the user
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
                
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            regViewController *regViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"regViewController"];
            
            // If you are using navigation controller, you can call
            [self.navigationController pushViewController:regViewController animated:YES];
            
            
        } else {
            NSLog(@"User with facebook logged in!");
            
            
            FBRequest *request = [FBRequest requestForMe];
            
            [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                
                NSDictionary *userData = (NSDictionary *)result;
                
                NSString *id = userData[@"id"];
                NSLog(@"iddd   %@",id);
                if ([[self validateUser:id] isEqualToString:@"1"]) {
                    
                    NSLog(@"1  sadasda ");
                    [self viewDidAppear:NO];

                }
                else if ([[self validateUser:id] isEqualToString:@"0"]){
                    regViewController *regViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"regViewController"];
                    
                    // If you are using navigation controller, you can call
                    [self.navigationController pushViewController:regViewController animated:YES];

                
                }
    
            }];
            
            
            
            
            
            
        }
    }];
}

- (IBAction)loginn:(id)sender {
    

    [self loginbutton];


}
-(void)logout{
    [PFUser logOut];

    NSLog(@"loggedout");
    [self viewDidAppear:YES];

}



@end
