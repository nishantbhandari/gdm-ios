//
//  uploadViewController.m
//  SidebarDemo
//
//  Created by Nishant on 25/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "uploadViewController.h"
#import "MainViewController.h"
#import "SWRevealViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <Parse/Parse.h>
@interface uploadViewController ()

@end

@implementation uploadViewController
@synthesize scrollView;
@synthesize textVD2;

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.contentView.bounds.size;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Navigation Logo
    UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 129, 41)];// Here you can set View width and height as per your requirement for displaying titleImageView position in navigationba
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navlogo.png"]];
    titleImageView.frame = CGRectMake(0, 0,129 , 41); // Here I am passing origin as (45,5) but can pass them as your requirement.
    [backView addSubview:titleImageView];
    //titleImageView.contentMode = UIViewContentModeCenter;
    self.navigationItem.titleView = backView;
    
    [textVD2 setBackgroundImage:[UIImage imageNamed:@"sub-text_green.png"] forState:UIControlStateSelected];
    
    msg = mediaDesc.text;
    FBRequest *request = [FBRequest requestForMe];
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        NSDictionary *userData = (NSDictionary *)result;
        
        NSLog(@"%@",userData[@"id"]);
        
        
        
        
        NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:6];
        
        if (userData[@"id"]) {
            userProfile[@"id"] = userData[@"id"];
        }
        
        
        [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
        [[PFUser currentUser] saveInBackground];
        
        fbid = [[PFUser currentUser] objectForKey:@"profile"][@"id"];
    }];

    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)upload {

    if ([checkMedia isEqual:@"image"]) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
        
        if(imageData){
            NSLog(@"heyoooo");
                   [_activityInd startAnimating];
        }


        
        NSString *urlString = [NSString stringWithFormat:@"http://gooddeedmarathon.com/gdm_ios/upload.php?msg=%@&prof_id=%@",msg,fbid];
//        NSString *urlString = @"http://flyingcursor.com/GoodDeedMarathon/upload.php";
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        
        NSString *boundary = @"---------------------------14737809831466499882746641449"
        ;
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"ipodfile.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:body];
        
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",returnString);
        if ([returnString isEqualToString:@"1"]){
            // - code after image is uploaded
            NSLog(@"success yooo");
            [_activityInd stopAnimating];
            
        }        else if ([returnString isEqualToString:@"0"]){
            // error handling
            
        }

        
    }
    else if ([checkMedia isEqual:@"video"]){
        NSLog(@"asas");
        
        NSData *data = [NSData dataWithContentsOfFile:moviePath];
        NSLog(@"URL FOR VIDEO %@",data);
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        NSString *urlString = [NSString stringWithFormat:@"http://gooddeedmarathon.com/gdm_ios/upload.php?msg=%@&prof_id=%@",msg,fbid];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        NSLog(@"test");
        
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        
        //video
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"yo.mov\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:data]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        //set the body to the request
        [request setHTTPBody:body];
        
        // send the request
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        

        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        
        if ([returnString isEqualToString:@"1"]){
            // - code after image is uploaded
            NSLog(@"sucess uploading!!");
        }
        else if ([returnString isEqualToString:@"0"]){
            // error handling
        
        }
    
    }

}

- (IBAction)textVD {

}

- (IBAction)imageVD {
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker animated:YES completion:NULL];
    picker = nil;
}
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    if (UTTypeEqual(kUTTypeMovie,
                    (__bridge CFStringRef)[info objectForKey:UIImagePickerControllerMediaType]))
    {
        checkMedia = @"video";
        NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
        
        [self dismissViewControllerAnimated:NO completion:nil];
        // Handle a movie capture
        if (CFStringCompare (( CFStringRef) mediaType, kUTTypeMovie, 0)
            == kCFCompareEqualTo) {
            
            moviePath = [[info objectForKey:
                          UIImagePickerControllerMediaURL] path];
            
            
        }
        NSURL *videoURL = [NSURL fileURLWithPath:moviePath];
        
        MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
        
        UIImage *thumbnail = [player thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
        [imageView setImage:thumbnail];
        NSLog(@"%@",thumbnail);
       
        //Player autoplays audio on init
        [player stop];
        player = nil;
        
        
    }
    else{
checkMedia = @"image";
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self dismissViewControllerAnimated:YES completion:NULL];
                [imageView setImage:image];
}

    
}

- (IBAction)videoVD {
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose movie capture
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = YES;
    
    cameraUI.delegate = delegate;
    cameraUI.videoMaximumDuration = 15.0f;
    
    [controller presentViewController: cameraUI animated: YES completion:nil];
    return YES;
}

- (IBAction)galleryVD {
    picker2 = [[UIImagePickerController alloc] init];
    picker2.delegate = self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    picker2.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage, nil];
    picker2.videoMaximumDuration = 15.0f;
    [self presentViewController:picker2 animated:YES completion:NULL];
    picker2 = nil;
    
}


@end