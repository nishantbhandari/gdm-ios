//
//  regViewController.h
//  SidebarDemo
//
//  Created by Nishant on 25/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "BSKeyboardControls.h"

@interface regViewController : UIViewController <BSKeyboardControlsDelegate>{

    NSString *check;

    

}

- (IBAction)regBut:(id)sender;


@property (nonatomic,retain) NSString *fb_name;
@property (nonatomic,retain) NSString *fb_email;
@property (nonatomic,retain) NSString *fb_id;
@property (nonatomic,retain) NSString *fb_gender;
@property (nonatomic,retain) NSString *fb_dob;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contenview;



@end
