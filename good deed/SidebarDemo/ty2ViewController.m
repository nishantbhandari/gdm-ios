//
//  ty2ViewController.m
//  Good Deed Marathon
//
//  Created by Tejas Hingu on 12/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "ty2ViewController.h"
#import "MainViewController.h"
#import "Reachability.h"
#import "interViewController.h"
@interface ty2ViewController ()

@end

@implementation ty2ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.ty2ScrollView layoutIfNeeded];
    self.ty2ScrollView.contentSize = self.ty2View.bounds.size;
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
self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    if ([_Check isEqualToString:@"image"]) {
        _largText.hidden = YES;
        _inMsg.hidden = NO;
        _imgView.hidden = NO;
    }
    else if ([_Check isEqualToString:@"text"]){
    
        _largText.hidden = NO;
        _largText.text = _largeValue;
        _inMsg.hidden = YES;
        _imgView.hidden = YES;
    }
    
    _msgTextView.layer.borderWidth = 2.0f;
    _msgTextView.layer.borderColor=[[UIColor colorWithRed:105.0/255.0 green:190.0/255.0 blue:40.0/255.0 alpha:1.0] CGColor];
    
    _imgView.layer.borderWidth = 2.0f;
    _imgView.layer.borderColor=[[UIColor colorWithRed:105.0/255.0 green:190.0/255.0 blue:40.0/255.0 alpha:1.0] CGColor];
    NSString *mainurl = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture",_fb_id];
    NSURL *url = [NSURL URLWithString:mainurl];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    


    _profImg.image = [[UIImage alloc] initWithData:data];
    _inMsg.text = _msgTxt;
    _imgView.image = _UplImg;
    _lblName.text = _fb_name;
    _profImg.frame = CGRectMake(_profImg.frame.origin.x, _profImg.frame.origin.y,
                                 50, 50);

    NSLog(@"%@ %@ %@",_fb_name,_fb_id, mainurl);
    NSLog(@"%f wid - %f", _profImg.frame.size.height , _profImg.frame.size.width);
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sharee:(id)sender {
    
    NSString *text = [NSString stringWithFormat:@"I'm part of the Good Deed marathon and I just made Mumbai a happier place! Check out what I did. %@",_idname];
    NSString *urlstring = [NSString stringWithFormat:@""];

    
    NSArray * activityItems = @[text, urlstring];
    NSArray * applicationActivities = nil;
    NSArray * excludeActivities = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePostToWeibo, UIActivityTypePrint, UIActivityTypeMessage];
    
    UIActivityViewController * activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
    activityController.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityController animated:YES completion:nil];
    
}
@end
