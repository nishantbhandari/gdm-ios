//
//  ViewController.m
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import "regViewController.h"
#import "tyViewController.h"
#import "ftViewController.h"

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
    _activityIndicator = nil;

    
    
    [super didReceiveMemoryWarning];
}


- (void)viewDidLoad
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"wasLaunchedBefore"]) {
        NSLog(@"first time");
        
        ftViewController *myOtherViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ftViewController"];
        // If you are using navigation controller, you can call
        [self.navigationController pushViewController:myOtherViewController animated:YES];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"wasLaunchedBefore"];
    }
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //create the scrollview with specific frame
    ALScrollViewPaging *scrollView1 = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 180)];
    //array for views to add to the scrollview
    NSMutableArray *views = [[NSMutableArray alloc] init];
    //array for colors of views
    
    //cycle which creates views for the scrollview
    NSString *str=@"http://gooddeedmarathon.com/getYoutubeVideoIds.php";
    NSURL *url=[NSURL URLWithString:str];
    NSData *data=[NSData dataWithContentsOfURL:url];
    NSError *error=nil;
    NSArray *response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"value = %@", [response objectAtIndex:1] );
    
    
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
                     <iframe width=\"100%%\" height=\"240px\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe>\
                     </body>\
                     </html>", videoURL];
        
        [self.myWebView loadHTMLString:videoHTML baseURL:nil];
        
        
        
        //
        self.myWebView.scrollView.scrollEnabled = NO;
        self.myWebView.scrollView.bounces = NO;
        [self.uTubeView setBackgroundColor:[UIColor blackColor]];
        [views addObject:self.myWebView];
    }
    
    //add pages to scrollview
    [scrollView1 addPages:views];
    
    //add scrollview to the view
    [self.uTubeView addSubview:scrollView1];

    [scrollView1 setHasPageControl:YES];

    
    FBRequest *request = [FBRequest requestForMe];
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        NSDictionary *userData = (NSDictionary *)result; 

        NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:6];
        
        if (userData[@"id"]) {
            userProfile[@"id"] = userData[@"id"];
        }
        
        if (userData[@"name"]) {
            userProfile[@"name"] = userData[@"name"];
        }
        
        if (userData[@"email"]) {
            userProfile[@"email"] = userData[@"email"];
        }
        
        if (userData[@"birthday"]) {
            userProfile[@"birthday"] = userData[@"birthday"];
        }
        
        if (userData[@"gender"]) {
            userProfile[@"gender"] = userData[@"gender"];
        }
        
        
        
        [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
        [[PFUser currentUser] saveInBackground];
        
        fbid = [[PFUser currentUser] objectForKey:@"profile"][@"id"];
        
        fbname = [[PFUser currentUser] objectForKey:@"profile"][@"name"];
        
        fbemail = [[PFUser currentUser] objectForKey:@"profile"][@"email"];
        
        fbdob = [[PFUser currentUser] objectForKey:@"profile"][@"birthday"];
        
        fbgender = [[PFUser currentUser] objectForKey:@"profile"][@"gender"];
        
    }];
    //scroll
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 800);


    
//    // Change button color
    _sidebarButton.tintColor = [UIColor whiteColor];
//
//    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);

    
    //Navigation Logo
    UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 129, 41)];// Here you can set View width and height as per your requirement for displaying titleImageView position in navigationba
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navlogo.png"]];
    titleImageView.frame = CGRectMake(0, 0,129 , 41); // Here I am passing origin as (45,5) but can pass them as your requirement.
    [backView addSubview:titleImageView];
    //titleImageView.contentMode = UIViewContentModeCenter;
    self.navigationItem.titleView = backView;
    
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

}
- (IBAction)loginButton:(id)sender {
    


    /* Login to facebook method */
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location",@"email"];
    
    // Login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
 // Hide loading indicator

        // validation!!
        
        //other validation
        
        if (!user) {
            if (!error) {
                [_activityIndicator stopAnimating];
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                [_activityIndicator stopAnimating];
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else if (user.isNew) {
            [_activityIndicator stopAnimating];
            NSLog(@"User with facebook signed up and logged in!");
            regViewController *myOtherViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"regViewController"];
            // If you are using navigation controller, you can call
              [self.navigationController pushViewController:myOtherViewController animated:YES];
          
            
        } else {

            NSOperationQueue *mainQueue = [[NSOperationQueue alloc] init];
            [mainQueue setMaxConcurrentOperationCount:5];
            
            NSString *gdmurl = [NSString stringWithFormat:@"http://www.gooddeedmarathon.com/check-ios.php?id=%@",fbid];
            NSURL *url = [NSURL URLWithString:gdmurl];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            
            [request setHTTPMethod:@"GET"];
            [request setAllHTTPHeaderFields:@{@"Accepts-Encoding": @"gzip", @"Accept": @"application/json"}];
            
            [NSURLConnection sendAsynchronousRequest:request queue:mainQueue completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {
                NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
                if (!error) {
                    NSLog(@"Status Code: %li %@", (long)urlResponse.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:urlResponse.statusCode]);
                    NSLog(@"Response Body: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
                    NSString *strrrng = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                    if ([strrrng isEqual:@"1"])
                    {
                        NSLog(@"success loggin with validation");
                        [_activityIndicator stopAnimating];
                        //if user is registered!!
                        MainViewController *camViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                        // If you are using navigation controller, you can call
                        [self.navigationController pushViewController:camViewController animated:YES];
                        
                        
                    }
                    else{
                        NSLog(@"user not registered");
                    [_activityIndicator stopAnimating];
                        regViewController *regViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"regViewController"];
                        regViewController.fb_id = fbid;
                        regViewController.fb_name = fbname;
                        regViewController.fb_email = fbemail;
                        regViewController.fb_dob = fbdob;
                        regViewController.fb_gender = fbgender;

                        [self.navigationController pushViewController:regViewController animated:NO];
                    

                    }
                }
                else {
                    [_activityIndicator stopAnimating];
                    NSLog(@"An error occured, Status Code: %i", urlResponse.statusCode);
                    NSLog(@"Description: %@", [error localizedDescription]);
                    NSLog(@"Response Body: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
                }
            }];

            NSLog(@"User with facebook logged in!");
        
        }
    }];
    
    [_activityIndicator startAnimating];// Show loading indicator until login is finished
 
 
}
@end
