//
//  ViewController.h
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController{
    NSString *fbid;
    NSString *fbname;
    NSString *fbemail;
    NSString *fbgender;
    NSString *fbdob;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
- (IBAction)loginButton:(id)sender;

@property (strong, nonatomic) NSString *kDCTStateSelectedServiceLineKey;

@end
