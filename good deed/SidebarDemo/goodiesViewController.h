//
//  goodiesViewController.h
//  Good Deed Marathon
//
//  Created by Tejas Hingu on 12/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface goodiesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *goodieScrollView;
@property (weak, nonatomic) IBOutlet UIView *goodiesView;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
