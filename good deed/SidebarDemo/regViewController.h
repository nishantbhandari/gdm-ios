//
//  regViewController.h
//  SidebarDemo
//
//  Created by Nishant on 25/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface regViewController : UIViewController{
    IBOutlet UITextField *name;
    IBOutlet UITextField *email;
    IBOutlet UITextField *phone;
    IBOutlet UITextField *address;
    IBOutlet UITextField *city;
    IBOutlet UITextField *pincode;
    NSString *check;
    NSString *fb_name;
    NSString *fb_email;
    NSString *fb_id;
    NSString *fb_gender;
    NSString *fb_dob;
    

}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contenview;
- (IBAction)register:(id)sender;

@end
