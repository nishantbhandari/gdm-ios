//
//  ViewController.h
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ALScrollViewPaging.h"
@interface MainViewController : UIViewController{
    NSString *fbid;
    NSString *fbname;
    NSString *fbemail;
    NSString *fbgender;
    NSString *fbdob;
    NSString *videoURL;
    NSString *videoHTML;
    IBOutlet UILabel *firstLabel1;
    IBOutlet UILabel *secondLabel1;
    IBOutlet UILabel *secondLabel2;
    IBOutlet UILabel *firstLabel2;
    IBOutlet UIButton *fblogin;
    IBOutlet UILabel *firstLabel3;
    FBRequest *fbrequest;
    NSString *logcheck;
}
@property (strong, nonatomic) IBOutlet UIView *MainView;
@property (strong, nonatomic) IBOutlet UIView *uTubeView2;
@property (strong, nonatomic) IBOutlet UIView *uTubeView;
@property (nonatomic, retain) UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UIButton *submitBut;
@property (strong, nonatomic) IBOutlet UIButton *justBut;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UIButton *galleryBut;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
- (IBAction)loginn:(id)sender;


@property (strong, nonatomic) NSString *kDCTStateSelectedServiceLineKey;

@end
