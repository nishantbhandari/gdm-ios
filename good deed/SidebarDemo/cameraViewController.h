//
//  cameraViewController.h
//  SidebarDemo
//
//  Created by Nishant on 25/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cameraViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
    IBOutlet UIImageView *imageView;
    
}

-(IBAction)TakePhoto;
-(IBAction)ChooseExisting;

@end
