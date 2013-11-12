//
//  videViewController.h
//  SidebarDemo
//
//  Created by Nishant on 28/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface videViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

        UIImagePickerController *picker2;
        IBOutlet UIImageView *imageView;
    NSString *moviePath;
}
//   @property (nonatomic, strong) NSString *moviePath;
- (IBAction)RecordAndPlay:(id)sender;
-(IBAction)Upload;
- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate;

@end
