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
   

    
    
    
    if([name.text length] == 0)
    {
        check = @"0";
//        NSLog(@"%@",name.text);
    }
    else if([email.text length] == 0)
    {
        check = @"0";
//        NSLog(@"%@",email.text);
    }
    else if([phone.text length] == 0)
    {
        check = @"0";
                NSLog(@"%@",phone.text);
    }
    else if([address.text length] == 0)
    {
        check = @"0";
    }
    else if([city.text length] == 0)
    {
        check = @"0";
    }
    else if([pincode.text length] == 0)
    {
        check = @"0";
    }
    else {
        check = @"1";
        }


    
    
    if([check isEqualToString:@"1"])
    {

        NSLog(@"1212");
    NSString * post = [[NSString alloc] initWithFormat:@"prof_id=%@&name=%@&email=%@&gender=%@&phn=%@&address=%@&dob=%@&city=Mumbai&state=Maharashtra&pin=%@",_fb_id, _fb_name, _fb_email, _fb_gender, phone.text, address.text, _fb_dob, pincode.text];
    NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString * postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest * request = [[[NSMutableURLRequest alloc] init]autorelease];
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
        [alert release];
    
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
        [alert release];
    
    }
    
//    [check release];
    
    
}



@end
