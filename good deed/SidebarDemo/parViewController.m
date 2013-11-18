//
//  parViewController.m
//  Good Deed Marathon
//
//  Created by Nishant on 13/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "parViewController.h"
#import "interViewController.h"
#import "Reachability.h"
#import "MainViewController.h"
#import <Parse/Parse.h>
#import "regViewController.h"
@interface parViewController ()

@end

@implementation parViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([_incoming isEqualToString:@"login"]){
        
        if ([PFUser currentUser] && // Check if a user is cached
            [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) // Check if user is linked to Facebook
        {
            FBRequest *fbrequest = [FBRequest requestForMe];
            
            [fbrequest startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                //        if (!error) {
                // result is a dictionary with the user's Facebook data
                NSDictionary *userData = (NSDictionary *)result;
                
                fbid = userData[@"id"];
                NSLog(@"fb? %@",fbid);
                if([[self validateUser:fbid] isEqualToString:@"1"]){
                    NSLog(@"work");
                    [self performSegueWithIdentifier:@"openMain2" sender:self];
                    
                    
                }
                else if([[self validateUser:fbid] isEqualToString:@"0"]){
                    NSLog(@"called");
                    [self performSegueWithIdentifier:@"openReg" sender:self];
                }
                
                
            }];
            
        }
        else
        {
            NSLog(@"called2 ");
            [self performSegueWithIdentifier:@"openMain2" sender:self];
            
        }
        
    }
    


}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
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
   }
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    

}

    

	// Do any additional setup after loading the view.


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
