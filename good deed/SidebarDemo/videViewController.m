//
//  videViewController.m
//  SidebarDemo
//
//  Created by Nishant on 28/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//


#import "videViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation videViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [self dismissViewControllerAnimated: YES completion:nil];
}

- (IBAction)RecordAndPlay:(id)sender {
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
//-(IBAction)SelectLib{
//    picker2 = [[UIImagePickerController alloc] init];
//    picker2.delegate = self;
//    [picker2 setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
//    picker2.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage, nil];
//    picker2.videoMaximumDuration = 15.0f;
//    [self presentViewController:picker2 animated:YES completion:NULL];
//    [picker2 release];
//   
//}


// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
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

-(IBAction)Upload{
    NSLog(@"asas");

    NSData *data = [NSData dataWithContentsOfFile:moviePath];
    NSLog(@"URL FOR VIDEO %@",data);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://flyingcursor.com/GoodDeedMarathon/upload.php"]]];
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
    
    NSLog(@"return data %@",returnData);
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"response from server is= %@",returnString);
    
}



@end
