//
//  uploadViewController.h
//  SidebarDemo
//
//  Created by Nishant on 25/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface uploadViewController : UIViewController
<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
     NSString *moviePath;
    IBOutlet UIButton *galleryvvd;
    IBOutlet UIButton *videovvd;
    IBOutlet UIButton *textvvd;
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
    IBOutlet UIImageView *imageView;
    NSString *checkMedia;
FBRequest *fbrequest;
    NSString *fbid;
    NSString *fbname;
    NSString *msg;
    IBOutlet UITextView *largeText;
    IBOutlet UITextView *smallText;
    IBOutlet UIButton *imagevvd;
    UIImage *thumbnail;
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
-(IBAction)textFieldReturn:(id)sender;
- (IBAction)backgroundTouched:(id)sender;
@end
