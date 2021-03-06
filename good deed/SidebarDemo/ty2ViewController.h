//
//  ty2ViewController.h
//  Good Deed Marathon
//
//  Created by Tejas Hingu on 12/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ty2ViewController : UIViewController
- (IBAction)sharee:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UIScrollView *ty2ScrollView;
@property (strong, nonatomic) IBOutlet UIView *ty2View;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *largText;

@property (strong, nonatomic) IBOutlet UITextView *msgTextView;
@property (strong, nonatomic) IBOutlet UIImageView *profImg;
@property(nonatomic, retain) NSString *msgTxt;
@property(nonatomic, retain) NSString *Check;
@property(nonatomic, retain) NSString *largeValue;
@property(nonatomic, retain) UIImage *UplImg;

@property(nonatomic, retain) NSString *fb_id;
@property (strong, nonatomic) IBOutlet UILabel *inMsg;
@property(nonatomic, retain) NSString *fb_name;
@property(nonatomic, retain) NSString *idname;
@end
