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
@interface regViewController ()

@end

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Navigation Logo
    UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 129, 41)];// Here you can set View width and height as per your requirement for displaying titleImageView position in navigationba
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navlogo.png"]];
    titleImageView.frame = CGRectMake(0, 0,129 , 41); // Here I am passing origin as (45,5) but can pass them as your requirement.
    [backView addSubview:titleImageView];
    //titleImageView.contentMode = UIViewContentModeCenter;
    self.navigationItem.titleView = backView;
    
    NSLog(@"%@",_fb_name);
    
    // validation

//    [self changeBorderColor:name];
//    [self changeBorderColor:email];
    
    name.text= _fb_name;
    email.text = _fb_email;
    
    city.text= @"Mumbai";
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)register:(id)sender {
    NSLog(@"%@", phone.text);
    
    NSString * post = [[NSString alloc] initWithFormat:@"prof_id=%@&name=%@&email=%@&gender=%@&phn=%@&address=%@&dob=%@&city=Mumbai&state=Maharashtra&pin=%@",_fb_id, _fb_name, _fb_email, _fb_gender, phone.text, address.text, _fb_dob, pincode.text];
    NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString * postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest * request = [[[NSMutableURLRequest alloc] init]autorelease];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://flyingcursor.com/GoodDeedMarathon/submit.php"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection * conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (conn) NSLog(@"Connection Successful");
    
    
    
}



@end
