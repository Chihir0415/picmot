//
//  DetailAlbumViewController.m
//  picmot
//
//  Created by Chihiro Murata on 2014/07/04.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import "DetailAlbumViewController.h"
#import "_CLImageEditorViewController.h"
#import "LINEActivity.h"
#import "DCKakaoActivity.h"
#import "InstagramActivity.h"
#import "mixiActivity.h"
#import "flickrActivity.h"


@interface DetailAlbumViewController ()
- (void)configureView;
@end

@implementation DetailAlbumViewController

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}
/*
-(void)setI:(NSInteger)i
{
    _i = i;
}
*/
- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        _detailImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.detailImageView.contentMode = UIViewContentModeScaleAspectFit;
//        self.detailImageView.userInteractionEnabled = YES;
//        //タグを設定する。
//        self.detailImageView.tag = _i;
//        NSLog(@"imgview = %ld",(long)_i);
        self.detailImageView.image = (UIImage*)_detailItem;
               
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    NSLog(@"tap = %ld",(long)_i);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shereBtn:(id)sender {
    
    //LINE、kakao talk、instagram、mixi、flickr用
    NSArray *applicationActivities = @[[[LINEActivity alloc] init],[[InstagramActivity alloc] init],[[DCKakaoActivity alloc] init],[[mixiActivity alloc] init],[[flickrActivity alloc] init]];
    
    //除外するもの(今は下の段全て)
    NSArray *excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypeMessage,UIActivityTypePrint,UIActivityTypeSaveToCameraRoll];
    
    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[_detailImageView.image,] applicationActivities:applicationActivities];
    
    activityView.excludedActivityTypes = excludedActivityTypes;
    activityView.completionHandler = ^(NSString *activityType, BOOL completed){
        if(completed && [activityType isEqualToString:UIActivityTypeSaveToCameraRoll]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved successfully" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    };
    
    [self presentViewController:activityView animated:YES completion:nil];
    
}

- (IBAction)deleteBtu:(id)sender {
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *imagePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Album"] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic%ld.jpg",(long)_i]];
    
    // ファイルやディレクトリの削除
    [fileManager removeItemAtPath: imagePath // (NSString*) 削除したいアイテムのパス
                            error: NULL];   // (NSError**) エラー
    
   
   
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete successfully" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    
}
@end
