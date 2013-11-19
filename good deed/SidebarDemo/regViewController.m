//
//  regViewController.m
//  SidebarDemo
//
//  Created by Nishant on 25/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//


#import "regViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MainViewController.h"
#import <Parse/Parse.h>
#import "afRegViewController.h"
#import "BSKeyboardControls.h"
#import "Reachability.h"
#import "interViewController.h"
@interface regViewController ()
@property (nonatomic, weak) IBOutlet UITextField *name;
@property (nonatomic, weak) IBOutlet UITextField *email;
@property (nonatomic, weak) IBOutlet UITextField *phone;
@property (nonatomic, weak) IBOutlet UITextField *address;
@property (nonatomic, weak) IBOutlet UITextField *city;
@property (nonatomic, weak) IBOutlet UITextField *pincode;
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;

@end
#define SYSTEM_VERSION_LESS_THAN(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define numTextFields 6

@implementation regViewController

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.contenview.bounds.size;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)changeBorderColor:(UITextField *)changeBorderColorField
{
    changeBorderColorField.layer.borderWidth = 2.0f;
    changeBorderColorField.layer.borderColor=[[UIColor colorWithRed:57.0f/255.0f green:57.0f/255.0f blue:57.0f/255.0f alpha:1.0] CGColor];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.keyboardControls setActiveField:textField];
}

#pragma mark -
#pragma mark Text View Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.keyboardControls setActiveField:textView];
}


#pragma mark -
#pragma mark Keyboard Controls Delegate


- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    [self.view endEditing:YES];
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



- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *fields = @[self.phone,self.address,self.pincode,self.city];
    
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    [self.keyboardControls setDelegate:self];

    FBRequest *request = [FBRequest requestForMe];
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        NSDictionary *userData = (NSDictionary *)result;
        
        NSLog(@"%@",userData[@"id"]);
        
        _name.text = userData[@"name"];
        
        _email.text = userData[@"email"];
        _city.text = @"Mumbai";
        
        
        NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:6];
        
        if (userData[@"id"]) {
            userProfile[@"id"] = userData[@"id"];
        }
        
        if (userData[@"name"]) {
            userProfile[@"name"] = userData[@"name"];
        }
        
        if (userData[@"gender"]) {
            userProfile[@"gender"] = userData[@"gender"];
        }
        
        if (userData[@"birthday"]) {
            userProfile[@"birthday"] = userData[@"birthday"];
        }
        if (userData[@"email"]) {
            userProfile[@"email"] = userData[@"email"];
        }
        NSLog(@"emailll %@",userProfile[@"email"]);
        
        
        [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
        [[PFUser currentUser] saveInBackground];
        _fb_name = [[PFUser currentUser] objectForKey:@"profile"][@"name"];
        _fb_email = [[PFUser currentUser] objectForKey:@"profile"][@"email"];
        _fb_id = [[PFUser currentUser] objectForKey:@"profile"][@"id"];
        _fb_gender = [[PFUser currentUser] objectForKey:@"profile"][@"gender"];
        _fb_dob = [[PFUser currentUser] objectForKey:@"profile"][@"birthday"];

        
    }];
    
    UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 129, 41)];// Here you can set View width and height as per your requirement for displaying titleImageView position in navigationba
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navlogo.png"]];
    titleImageView.frame = CGRectMake(0, 0,129 , 41); // Here I am passing origin as (45,5) but can pass them as your requirement.
    [backView addSubview:titleImageView];
    //titleImageView.contentMode = UIViewContentModeCenter;
    self.navigationItem.titleView = backView;
    //Navigation Logo
    NSLog(@"%@",_fb_name);
    // validation

//    [self changeBorderColor:name];
//    [self changeBorderColor:email];
    
    
    _city.text= @"Mumbai";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)regBut:(id)sender {
    
    
    if([_name.text length] == 0)
    {
        check = @"0";
        //        NSLog(@"%@",name.text);
    }
    else if([_email.text length] == 0)
    {
        check = @"0";
        //        NSLog(@"%@",email.text);
    }
    else if([_phone.text length] == 0)
    {
        check = @"0";
        NSLog(@"%@",_phone.text);
    }
    else if([_address.text length] == 0)
    {
        check = @"0";
    }
    else if([_city.text length] == 0)
    {
        check = @"0";
    }
    else if([_pincode.text length] == 0)
    {
        check = @"0";
    }
    else {
        check = @"1";
    }
    
    
    
    
    if([check isEqualToString:@"1"])
    {
        
        NSLog(@"fb -- --");
        NSString * post = [[NSString alloc] initWithFormat:@"prof_id=%@&name=%@&email=%@&gender=%@&phn=%@&address=%@&dob=%@&city=%@&state=Maharashtra&pin=%@",_fb_id, _fb_name, _fb_email ,_fb_gender ,_phone.text, _address.text,_fb_dob,_city.text, _pincode.text];
        
        NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
        
        NSString * postLength = [NSString stringWithFormat:@"%d",[postData length]];
        NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.gooddeedmarathon.com/submit.php"]]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        //    NSURLConnection * conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",returnString);
        if([returnString isEqualToString:@"1"]){
            
            
            afRegViewController *myOtherViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"afRegViewController"];
            // If you are using navigation controller, you can call
            [self.navigationController pushViewController:myOtherViewController animated:YES];
            
        }
        else if([returnString isEqualToString:@"0"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uh oh! Error occurred try again"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            alert = nil;
            
        }
    }
    else if([check isEqualToString:@"0"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uh oh! Please fill  all the details."
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
        
    }
    

}

@end
