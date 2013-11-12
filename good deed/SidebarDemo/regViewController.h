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
}

@property (nonatomic, retain) NSString *fb_name;
@property (nonatomic, retain) NSString *fb_email;
@property (nonatomic, retain) NSString *fb_id;
@property (nonatomic, retain) NSString *fb_gender;
@property (nonatomic, retain) NSString *fb_dob;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contenview;
- (IBAction)register:(id)sender;

@end
