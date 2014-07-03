//
//  SaveModalViewController.m
//  picmot
//
//  Created by Chihiro Murata on 2014/07/01.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import "SaveModalViewController.h"

@interface SaveModalViewController ()

@end

@implementation SaveModalViewController

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
    
    // 背景色
    self.view.backgroundColor = [UIColor greenColor];
    
    //FB投稿ボタン
    UIButton *fbbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    fbbtn.frame = CGRectMake(0, 0, 100, 30);
    fbbtn.center = CGPointMake(160, 150);
    [fbbtn setTitle:@"FaceBookに投稿" forState:UIControlStateNormal];
    [fbbtn addTarget:self action:@selector(postToFacebook:)
    forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:fbbtn];

    //twitter投稿ボタン
    UIButton *twbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    twbtn.frame = CGRectMake(0, 0, 100, 30);
    twbtn.center = CGPointMake(160, 200);
    [twbtn setTitle:@"Twitterに投稿" forState:UIControlStateNormal];
    [twbtn addTarget:self action:@selector(postToTwitter:)
    forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:twbtn];
    
    //weibo投稿ボタン
    UIButton *weibtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    weibtn.frame = CGRectMake(0, 0, 100, 30);
    weibtn.center = CGPointMake(160, 250);
    [weibtn setTitle:@"Twitterに投稿" forState:UIControlStateNormal];
    [weibtn addTarget:self action:@selector(postToWeibo:)
    forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:weibtn];

    //LINE投稿ボタン
    
    
    
    // Backボタン
    UIButton *modalBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    modalBtn.frame = CGRectMake(0, 0, 100, 50);
    modalBtn.center = CGPointMake(160, 400);
    //modalBtn.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);  // 画面中央表示
    [modalBtn setTitle:@"閉じる" forState:UIControlStateNormal];
    [modalBtn addTarget:self action:@selector(modalBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modalBtn];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


// Facebookに投稿
- (void)postToFacebook:(UIButton*)sender
{
    SLComposeViewController *vc = [SLComposeViewController
                                   composeViewControllerForServiceType:SLServiceTypeFacebook];
    [vc setInitialText:@"test"];
    //[vc addImage:resultImage];
    [vc addURL:[NSURL URLWithString:@"http://test"]];
    [self presentViewController:vc animated:YES completion:nil];
}

//twitterに投稿
- (void)postToTwitter:(UIButton*)sender
{
    SLComposeViewController *vc = [SLComposeViewController
                                   composeViewControllerForServiceType:SLServiceTypeTwitter];
    [vc setInitialText:@"test test"];
    //[vc addImage:_resultImage];
    [vc addURL:[NSURL URLWithString:@"http://test2"]];
    [self presentViewController:vc animated:YES completion:nil];
}

//Weiboに投稿
- (void)postToWeibo:(UIButton*)sender
{
    SLComposeViewController *vc = [SLComposeViewController
                                   composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    [vc setInitialText:@"test test test"];
    //[vc addImage:_resultImage];
    [vc addURL:[NSURL URLWithString:@"http://test3"]];
    [self presentViewController:vc animated:YES completion:nil];
}

//LINEに投稿


// Backボタンアクション
- (void)modalBtnAction:(UIButton*)sender
{
    // モーダルを非表示
    [self dismissViewControllerAnimated:YES completion:nil];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
