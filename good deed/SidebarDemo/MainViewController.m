//
//  ViewController.m
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "MainViewController.h"
#import "SWRevealViewController.h"
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
    [super didReceiveMemoryWarning];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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
            
            if ([[self validateUser:fbid] isEqualToString:@"1"]) {
                NSLog(@"congo");
                logcheck = @"1";
            }
            else if ([[self validateUser:fbid] isEqualToString:@"0"]) {
                NSLog(@"fb %@",fbid);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"You need to register before you can submit a good deed." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
                alert = nil;
                logcheck = @"0";
                
                
            }
        }];
        
        // Push the next view controller without animation
    }
    
    
    
    if ([logcheck isEqualToString:@"0"]) {
        //logged in
        NSLog(@"already loggedin");
        
        firstLabel1.hidden = YES;
        _uTubeView.hidden = YES;
        fblogin.hidden = YES;
        firstLabel3.hidden = YES;
     
        
        
        
    }
    else if([logcheck isEqualToString:@"1"])
    {
        //login
        _uTubeView2.hidden = YES;
        secondLabel1.hidden = YES;
        secondLabel2.hidden = YES;
        firstLabel2.hidden = YES;
        
        
    }
    


}
//-(void)setView:(UIView *)whichView{
//    ALScrollViewPaging *scrollView1 = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 180)];
//    //array for views to add to the scrollview
//    NSMutableArray *views = [[NSMutableArray alloc] init];
//    //array for colors of views
//    
//    //cycle which creates views for the scrollview
//    NSString *str=@"http://gooddeedmarathon.com/getYoutubeVideoIds.php";
//    NSURL *url=[NSURL URLWithString:str];
//    NSData *data=[NSData dataWithContentsOfURL:url];
//    NSError *error=nil;
//    NSArray *response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//    NSLog(@"value = %@", [response objectAtIndex:1] );
//    
//    
//    for (int i = 0; i < [response count]; i++) {
//        self.myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,180)];
//        //        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
//        NSString *urls = [response objectAtIndex:i];
//        videoURL = [NSString stringWithFormat:@"http://youtube.com/embed/%@",urls] ;
//        NSLog(@"%@",videoURL);
//        videoHTML = [NSString stringWithFormat:@"\
//                     <html>\
//                     <head>\
//                     <style type=\"text/css\">\
//                     iframe {position:absolute; top:50%%; margin-top:-130px;}\
//                     body {background-color:#000; margin:0;}\
//                     </style>\
//                     </head>\
//                     <body>\
//                     <iframe width=\"100%%\" height=\"240px\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe>\
//                     </body>\
//                     </html>", videoURL];
//        
//        [self.myWebView loadHTMLString:videoHTML baseURL:nil];
//        
//        
//        
//        //
//        self.myWebView.scrollView.scrollEnabled = NO;
//        self.myWebView.scrollView.bounces = NO;
//        [self.uTubeView2 setBackgroundColor:[UIColor blackColor]];
//        [views addObject:self.myWebView];
//    }
//    
//    //add pages to scrollview
//    [scrollView1 addPages:views];
//    
//    //add scrollview to the view
//    [self.uTubeView2 addSubview:scrollView1];
//    
//    [scrollView1 setHasPageControl:YES];
//
//
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"wasLaunchedBefore"]) {
        NSLog(@"first time");
        
        ftViewController *myOtherViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ftViewController"];
        // If you are using navigation controller, you can call
        [self.navigationController pushViewController:myOtherViewController animated:YES];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"wasLaunchedBefore"];
    }
    
    
    
    
    
    
    
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

    

    
    
    
//        [PFUser logOut]; // Log out
//    /* Login to facebook method */
//    // Set permissions required from the facebook user account
//    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location",@"email"];
//    
//    // Login PFUser using facebook
//    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
// // Hide loading indicator
//
//        // validation!!
//        
//        //other validation
//        
//        if (!user) {
//            if (!error) {
//                [_activityIndicator stopAnimating];
//                NSLog(@"Uh oh. The user cancelled the Facebook login.");
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
//                [alert show];
//            } else {
//                [_activityIndicator stopAnimating];
//                NSLog(@"Uh oh. An error occurred: %@", error);
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
//                [alert show];
//            }
//        } else if (user.isNew) {
//            [_activityIndicator stopAnimating];
//            NSLog(@"User with facebook signed up and logged in!");
//            regViewController *myOtherViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"regViewController"];
//            // If you are using navigation controller, you can call
//              [self.navigationController pushViewController:myOtherViewController animated:YES];
//
//            
//        } else {
//
//            NSOperationQueue *mainQueue = [[NSOperationQueue alloc] init];
//            [mainQueue setMaxConcurrentOperationCount:5];
//            
//            NSString *gdmurl = [NSString stringWithFormat:@"http://www.gooddeedmarathon.com/check-ios.php?id=%@",fbid];
//            NSURL *url = [NSURL URLWithString:gdmurl];
//            
//            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//            
//            [request setHTTPMethod:@"GET"];
//            [request setAllHTTPHeaderFields:@{@"Accepts-Encoding": @"gzip", @"Accept": @"application/json"}];
//            
//            [NSURLConnection sendAsynchronousRequest:request queue:mainQueue completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {
//                NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
//                if (!error) {
//                    NSLog(@"Status Code: %li %@", (long)urlResponse.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:urlResponse.statusCode]);
//                    NSLog(@"Response Body: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
//                    NSString *strrrng = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//                    if ([strrrng isEqual:@"1"])
//                    {
//                        NSLog(@"success loggin with validation");
//                        [_activityIndicator stopAnimating];
//                        //if user is registered!!
//                        MainViewController *camViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
//                        // If you are using navigation controller, you can call
//                        [self.navigationController pushViewController:camViewController animated:YES];
//                        
//                        
//                    }
//                    else{
//                        NSLog(@"user not registered");
//                    [_activityIndicator stopAnimating];
//                        regViewController *regViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"regViewController"];
//                        regViewController.fb_id = fbid;
//                        regViewController.fb_name = fbname;
//                        regViewController.fb_email = fbemail;
//                        regViewController.fb_dob = fbdob;
//                        regViewController.fb_gender = fbgender;
//                        NSLog(@"reggg %@",fbid);
//                        [self.navigationController pushViewController:regViewController animated:NO];
//
//
//                    }
//                }
//                else {
//                    [_activityIndicator stopAnimating];
//                    NSLog(@"An error occured, Status Code: %i", urlResponse.statusCode);
//                    NSLog(@"Description: %@", [error localizedDescription]);
//                    NSLog(@"Response Body: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
//                }
//            }];
//
//            NSLog(@"User with facebook logged in!");
//        
//        }
//    }];
//

-(NSString *)validateUser:(NSString*)userid {
    
    
    NSString * post = [[NSString alloc] initWithFormat:@"id=%@",userid];
    NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString * postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.gooddeedmarathon.com/check-ios.php?id=%@",userid]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
      NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];

    return returnString;
}
-(void)loginbutton{

    [PFUser logOut];
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
            regViewController *myOtherViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"regViewController"];
            // If you are using navigation controller, you can call
            [self.navigationController pushViewController:myOtherViewController animated:YES];
            
            
        } else {
            NSLog(@"User with facebook logged in!");
            
            
            regViewController *regViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"regViewController"];
            
            [self.navigationController pushViewController:regViewController animated:NO];
            
            
            
        }
    }];
}

- (IBAction)loginn:(id)sender {
    
    NSLog(@"after this");
    NSLog(@"%@",[self validateUser:fbid]);
//        NSLog(@" yo ?%@",logcheck);
    [self loginbutton];
    NSLog(@"before this ");

}
@end
