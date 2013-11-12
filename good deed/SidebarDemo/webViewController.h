//
//  webViewController.h
//  SidebarDemo
//
//  Created by Nishant on 31/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webViewController : UIViewController {
    IBOutlet UIImageView *imageView;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UIWebView *webpage;

@end
