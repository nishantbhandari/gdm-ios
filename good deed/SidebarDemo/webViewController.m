//
//  webViewController.m
//  SidebarDemo
//
//  Created by Nishant on 31/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "webViewController.h"
#import "SWRevealViewController.h"
#import "interViewController.h"
#import "Reachability.h"
@interface webViewController ()

@end

@implementation webViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{

        });
    };
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            interViewController *interViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"interViewController"];
            // If you are using navigation controller, you can call
            [self.navigationController pushViewController:interViewController animated:NO];
            
        });
    };
    
    [reach startNotifier];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"%f",self.view.frame.size.height);
    NSLog(@"%f",_webpage.frame.size.height);
    

    
    
//    _sidebarButton.tintColor = [UIColor blackColor];

    //Navigation Logo
    UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 129, 41)];// Here you can set View width and height as per your requirement for displaying titleImageView position in navigationba
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navlogo.png"]];
    titleImageView.frame = CGRectMake(0, 0,129 , 41); // Here I am passing origin as (45,5) but can pass them as your requirement.
    [backView addSubview:titleImageView];
    //titleImageView.contentMode = UIViewContentModeCenter;
    self.navigationItem.titleView = backView;
    
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    //
    //    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
        _sidebarButton.tintColor = [UIColor whiteColor];
    NSString *fullURL = @"http://flyingcursor.com/gdm/maps.html";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
   [_webpage loadRequest:requestObj];

	// Do any additional setup after loading the view.

//    NSString *videoURL = @"http://youtu.be/Wq_CtkKrt1o";
//    
//    _videoView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
//    _videoView.backgroundColor = [UIColor clearColor];
//    _videoView.opaque = NO;
//    _videoView.delegate = self;
//    [self.view addSubview:_videoView];
    
    
//    NSString *videoHTML = [NSString stringWithFormat:@"\
//                           <html>\
//                           <head>\
//                           <style type=\"text/css\">\
//                           iframe {position:absolute; top:50%%; margin-top:-130px;}\
//                           body {background-color:#000; margin:0;}\
//                           </style>\
//                           </head>\
//                           <body>\
//                           <iframe width=\"100%%\" height=\"240px\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe>\
//                           </body>\
//                           </html>", videoURL];
//    
//    [_videoView loadHTMLString:videoHTML baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
