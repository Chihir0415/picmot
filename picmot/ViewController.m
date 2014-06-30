//
//  ViewController.m
//  picmot
//
//  Created by Chihiro Murata on 2014/03/11.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import "ViewController.h"
#import "CLImageEditor.h"

@interface ViewController ()
<CLImageEditorDelegate, CLImageEditorThemeDelegate>

@end

@implementation ViewController


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
    
    [self refreshImageView];
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = self.view.bounds;
//    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.41 green:0.94 blue:0.55 alpha:1.0] CGColor], (id)[[UIColor colorWithRed:0.47 green:0.91 blue:0.97 alpha:1.0] CGColor], nil];
//    [self.view.layer insertSublayer:gradient atIndex:0];
    
    //UIImage *newback = [UIImage imageNamed:@"001.png"];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:newback];

    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"001.png"] drawInRect:self.view.bounds];
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    _tabBaritem.backgroundColor = [UIColor clearColor];
    [self defaults];
}

-(void)defaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isBool = [defaults boolForKey:@"KEY_BOOL"];
    if (!isBool) {
        NSString *messageStr =@"This is camera&Mot dictionary application.\nYou can decoration to your photo nicer!\nAnd you can see many Mot.\nPlease enjoy this picmot!";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Welcome to picmot !!!" message:messageStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        //defaultsの値を変更して保持
        [defaults setBool:YES forKey:@"KEY_BOOL"];
        [defaults synchronize];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)pushedMotBtn
{
    UINavigationController *nvc = [self.storyboard instantiateViewControllerWithIdentifier:@"UINavigationController"];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)pushedOldBtn
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *library = [[UIImagePickerController alloc] init];
        library.delegate = self;
        library.allowsEditing = NO;
        library.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:library  animated:YES completion: nil];
    }
}

- (void)pushedNewBtn
{
    
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
        [sheet showInView:self.view.window];
    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        UIImagePickerController *camera = [[UIImagePickerController alloc] init];
//        camera.delegate = self;
//        camera.allowsEditing = NO;
//        camera.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self presentViewController:camera  animated:YES completion: nil];
//    }
}

- (void)pushedEditBtn
{
    if(_imageView.image){
        CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:_imageView.image];
        editor.delegate = self;
        //CLImageEditor *editor = [[CLImageEditor alloc] initWithDelegate:self];
        
        
        CLImageToolInfo *tool = [editor.toolInfo subToolInfoWithToolName:@"CLStickerTool" recursive:NO];
        tool.available = YES;
        tool.dockedNumber = -1;
        
        tool= [editor.toolInfo subToolInfoWithToolName:@"CLResizeTool" recursive:YES];
        tool.available = NO;
        
                
        [self presentViewController:editor animated:YES completion:nil];
        //[editor showInViewController:self withImageView:_imageView];
    }
    else{
        [self pushedNewBtn];
    }
}

- (void)pushedSaveBtn
{
    if(_imageView.image){
        NSArray *excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypeMessage];
        
        UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[_imageView.image] applicationActivities:nil];
        
        activityView.excludedActivityTypes = excludedActivityTypes;
        activityView.completionHandler = ^(NSString *activityType, BOOL completed){
            if(completed && [activityType isEqualToString:UIActivityTypeSaveToCameraRoll]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved successfully" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        };
        
        [self presentViewController:activityView animated:YES completion:nil];
    }
    else{
        [self pushedNewBtn];
    }
}

#pragma mark- ImagePicker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //撮影後すぐに保存する設定
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    
    //カメラ・ライブラリからEditに進んだ時の画面
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:image];
    editor.delegate = self;
    
    CLImageToolInfo *tool = [editor.toolInfo subToolInfoWithToolName:@"CLStickerTool" recursive:NO];
    tool.available = YES;
    tool.dockedNumber = -1;
    
    tool= [editor.toolInfo subToolInfoWithToolName:@"CLResizeTool" recursive:YES];
    tool.available = NO;
    
    //[self presentViewController:editor animated:YES completion:nil];
    //[editor showInViewController:self withImageView:_imageView];

    //editへ進んだときの画面を設定
    [picker presentViewController:editor animated:YES completion:nil];
    [[UINavigationBar appearance] setAlpha:0.5];

}

#pragma mark- CLImageEditor delegate

- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    //Edit後の画面
    _imageView.image = image;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    selfview.backgroundColor = [UIColor clearColor];

    [self refreshImageView];
    
    [editor dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark- Tapbar delegate

- (void)deselectTabBarItem:(UITabBar*)tabBar
{
    tabBar.selectedItem = nil;
    
    }

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [self performSelector:@selector(deselectTabBarItem:) withObject:tabBar afterDelay:0.2];
    
    switch (item.tag) {
        case 0:
            [self pushedMotBtn];
            break;
        case 1:
            [self pushedOldBtn];
            break;
        case 2:
            [self pushedNewBtn];
            break;
        case 3:
            [self pushedEditBtn];
            break;
        case 4:
            [self pushedSaveBtn];
            break;
        default:
            break;
    }
}

#pragma mark- Actionsheet delegate


//アクションシートで分岐するタイプ
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==actionSheet.cancelButtonIndex){
        return;
    }
    
    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if([UIImagePickerController isSourceTypeAvailable:type]){
        if(buttonIndex==0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            type = UIImagePickerControllerSourceTypeCamera;
        }
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = NO;
        picker.delegate   = self;
        picker.sourceType = type;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)library{
    [self dismissViewControllerAnimated:YES completion:nil];
	
}


#pragma mark- ScrollView

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView.superview;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat Ws = _scrollView.frame.size.width - _scrollView.contentInset.left - _scrollView.contentInset.right;
    CGFloat Hs = _scrollView.frame.size.height - _scrollView.contentInset.top - _scrollView.contentInset.bottom;
    CGFloat W = _imageView.superview.frame.size.width;
    CGFloat H = _imageView.superview.frame.size.height;
    
    CGRect rct = _imageView.superview.frame;
    rct.origin.x = MAX((Ws-W)/2, 0);
    rct.origin.y = MAX((Hs-H)/2, 0);
    _imageView.superview.frame = rct;
}

- (void)resetImageViewFrame
{
    CGSize size = (_imageView.image) ? _imageView.image.size : _imageView.frame.size;
    CGFloat ratio = MIN(_scrollView.frame.size.width / size.width, _scrollView.frame.size.height / size.height);
    CGFloat W = ratio * size.width;
    CGFloat H = ratio * size.height;
    _imageView.frame = CGRectMake(0, 0, W, H);
    _imageView.superview.bounds = _imageView.bounds;
}

- (void)resetZoomScaleWithAnimate:(BOOL)animated
{
    CGFloat Rw = _scrollView.frame.size.width / _imageView.frame.size.width;
    CGFloat Rh = _scrollView.frame.size.height / _imageView.frame.size.height;
    
    //CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat scale = 1;
    Rw = MAX(Rw, _imageView.image.size.width / (scale * _scrollView.frame.size.width));
    Rh = MAX(Rh, _imageView.image.size.height / (scale * _scrollView.frame.size.height));
    
    _scrollView.contentSize = _imageView.frame.size;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = MAX(MAX(Rw, Rh), 1);
    
    [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:animated];
    [self scrollViewDidZoom:_scrollView];
}

- (void)refreshImageView
{
    [self resetImageViewFrame];
    [self resetZoomScaleWithAnimate:NO];
}

@end
