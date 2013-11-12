//
//  cameraViewController.m
//  SidebarDemo
//
//  Created by Nishant on 25/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "cameraViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface cameraViewController ()

@end

@implementation cameraViewController

-(IBAction)TakePhoto{
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker animated:YES completion:NULL];
    [picker release];


    
}

-(IBAction)ChooseExisting{
    picker2 = [[UIImagePickerController alloc] init];
    picker2.delegate = self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    picker2.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage, nil];
    picker2.videoMaximumDuration = 15.0f;
    [self presentViewController:picker2 animated:YES completion:NULL];
    [picker2 release];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(IBAction)uploadImage{
    
    NSData *imageData = UIImageJPEGRepresentation(image, 90);
    
    if(imageData){
        NSLog(@"heyoooo");
    }
    NSString *urlString = @"http://flyingcursor.com/GoodDeedMarathon/upload.php";
    
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
