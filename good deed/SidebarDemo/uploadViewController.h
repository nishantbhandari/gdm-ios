//
//  uploadViewController.h
//  SidebarDemo
//
//  Created by Nishant on 25/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface uploadViewController : UIViewController
<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
     NSString *moviePath;
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
    IBOutlet UIImageView *imageView;
    NSString *checkMedia;
    IBOutlet UITextField *mediaDesc;
    NSString *fbid;
    NSString *msg;
}
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityInd;
- (IBAction)upload;
- (IBAction)textVD;
- (IBAction)imageVD;
- (IBAction)videoVD;
- (IBAction)galleryVD;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIButton *textVD2;

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@end
