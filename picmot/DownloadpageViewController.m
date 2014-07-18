//
//  DownloadpageViewController.m
//  picmot
//
//  Created by hayato on 7/15/14.
//  Copyright (c) 2014 Chihiro Murata. All rights reserved.
//

#import "DownloadpageViewController.h"

@interface DownloadpageViewController (){
    UIView *cateView;
    UIButton *dlBtn;
    UIProgressView *dlProg;
    UIImageView *cateImg;
    UIView *imgView;
    UIImageView *allImg;
    UIScrollView *imgScrl;
    UILabel *dlLabel;
}

@end

@implementation DownloadpageViewController

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
    self.navigationItem.title = [NSString stringWithFormat:@"%@",_pcTitle];
    
    self.view.backgroundColor = [UIColor colorWithRed:1.00 green:0.98 blue:0.98 alpha:1.0];
    
    cateView = [[UIView alloc] initWithFrame:CGRectMake(10, 68, 300, 168)];
    cateView.backgroundColor = [UIColor whiteColor];
    cateView.layer.borderColor = [UIColor colorWithRed:0.97 green:0.97 blue:1.00 alpha:1.0].CGColor;
    cateView.layer.borderWidth = 0.5f;
    [self.view addSubview:cateView];
    
    
    dlBtn = [[UIButton alloc] init];
    dlBtn =  [ UIButton buttonWithType:UIButtonTypeRoundedRect ];
    dlBtn.frame = CGRectMake( 50, 138, 200, 28 );
    dlBtn.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.0];
    [cateView addSubview:dlBtn];
    
    dlLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 100)];
    dlLabel.textColor = [UIColor blackColor];
    [cateView addSubview:dlLabel];
    
    dlProg = [[UIProgressView alloc] init];
    
    cateImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 120, 120)];
    cateImg.layer.borderColor = [UIColor colorWithRed:0.97 green:0.97 blue:1.00 alpha:1.0].CGColor;
    cateImg.layer.borderWidth = 0.5f;
    cateImg.layer.cornerRadius = 2.0f;
    [cateView addSubview:cateImg];
    
    imgScrl = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 240, 300, self.view.bounds.size.height - 295)];
    imgScrl.backgroundColor = [UIColor whiteColor];
    [imgScrl setContentSize:CGSizeMake(300, 750)];
    
    imgScrl.userInteractionEnabled = YES;
    imgScrl.delegate = self;
    
    imgScrl.layer.borderColor = [UIColor colorWithRed:0.97 green:0.97 blue:1.00 alpha:1.0].CGColor;
    imgScrl.layer.borderWidth = 0.5f;
    imgScrl.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:imgScrl];
    
    allImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 , 300, 750)];
    [imgScrl addSubview:allImg];
    
    NSArray * librarystickers = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *stickerPath = [librarystickers lastObject];
    stickerPath = [stickerPath stringByAppendingString:@"/Caches/stickers/"];
    stickerPath = [stickerPath stringByAppendingString:self.pcFile];
    
    NSString *filePathcheck = [NSString stringWithFormat:@"%@/0.png", stickerPath];

    NSData *datacheck = [NSData dataWithContentsOfFile:filePathcheck];
        if (datacheck == nil) {
            
            NSLog(@"no!");
            dlLabel.text = self.pcTitle;
            dlLabel.textAlignment = NSTextAlignmentCenter;
            NSURL *url = [NSURL URLWithString:self.pccateImage];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            allImg.image = image;
            
            
            NSURL *url1 = [NSURL URLWithString:self.pcImage];
            NSData *data1 = [NSData dataWithContentsOfURL:url1];
            UIImage *image1 = [UIImage imageWithData:data1];
            cateImg.image = image1;
            [dlBtn setTitle:@"download" forState:UIControlStateNormal ];
            dlBtn.backgroundColor = [UIColor colorWithRed:0.18 green:0.55 blue:0.34 alpha:1.0];
            [dlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

            [dlBtn addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
            
            dlBtn.alpha = 1.0;
            dlBtn.enabled = YES;

        }else{
            NSLog(@"yes!!");
            dlLabel.text = self.pcTitle;
            dlLabel.textAlignment = NSTextAlignmentCenter;
            NSString *filePath0 = [NSString stringWithFormat:@"%@/0.png", stickerPath];
            NSData *data0 = [NSData dataWithContentsOfFile:filePath0];
            UIImage *image0 = [UIImage imageWithData:data0];
            cateImg.image = image0;
            
            NSString *filePath1 = [NSString stringWithFormat:@"%@/1.png", stickerPath];

            NSData *data1 = [NSData dataWithContentsOfFile:filePath1];
            UIImage *image1 = [UIImage imageWithData:data1];
            allImg.image = image1;
            [dlBtn setTitle:@"downloaded" forState:UIControlStateNormal ];
            dlBtn.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.0];
            [dlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            dlBtn.alpha = 1.0;
            dlBtn.enabled = NO;

            
//        }
    }

}
- (void) download:(UIButton*)sender {
    UIView *tmpBackView = [[UIView alloc] initWithFrame:CGRectZero];
    [tmpBackView setBackgroundColor:[UIColor clearColor]];
    UIBarButtonItem *tmpBackButton = [[UIBarButtonItem alloc] initWithCustomView:tmpBackView];
    [tmpBackButton setEnabled:NO];
    [self.navigationItem setLeftBarButtonItem:tmpBackButton];
    
    dlProg.frame = CGRectMake(60, 198, 200, 3);
    dlProg.trackTintColor = [UIColor colorWithRed:1.0f green:0.9f blue:0.9f alpha:1.0f];
    dlProg.progressTintColor = [UIColor colorWithRed:0.6f green:0.98f blue:0.6f alpha:1.0f];
    [self.view addSubview:dlProg];
    
    NSURL* url = [NSURL URLWithString:_pcZip];
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    
    // データをファイルとしてファウンロード
    NSURLSessionDownloadTask* task = [session downloadTaskWithURL:url];
    
    [task resume];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    dlProg.progress = 0;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    float percent = (float)totalBytesWritten / (float)totalBytesExpectedToWrite;
    dlProg.progress = percent;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    
    
    
    // ファイルを移動
    NSFileManager* manager = [NSFileManager defaultManager];
    NSString* file = [NSString stringWithFormat:@"%@.zip",_pcFile];
    NSString* tmp = NSTemporaryDirectory();
    //    [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSURL* dstURL = [NSURL fileURLWithPath:[tmp stringByAppendingPathComponent:file]];
    NSError* err = nil;
    
    [manager moveItemAtURL:location toURL:dstURL error:&err];
    
    // 解凍するファイル
    NSString *nsStringFullPath = [ NSHomeDirectory() stringByAppendingPathComponent:@"tmp" ];
    nsStringFullPath = [ nsStringFullPath stringByAppendingString:@"/" ];
    nsStringFullPath = [ nsStringFullPath stringByAppendingString:file];
    
    // 解凍先フォルダ
    NSString *nsStringZipFolder = [ @"Library/Caches/" stringByAppendingString:@"stickers" ];
    NSString *outdir = [ NSHomeDirectory() stringByAppendingPathComponent:nsStringZipFolder ];
    
    ZipArchive *zip = [[ZipArchive alloc] init];
    
    // zipを開く
    [ zip UnzipOpenFile:nsStringFullPath ];
    
    // zipをフォルダーに展開する。ファイルが既に存在したら上書きする。
    BOOL result = [ zip UnzipFileTo:outdir overWrite:true ];
    if( result == YES )
    {
        NSLog( @"zip解凍成功");
        NSString *messageStr =@"download complete";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"complete" message:messageStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];

    }
    else
    {
        // エラー時
        NSLog( @"zip解凍エラー");
        NSString *messageStr =@"download error";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"error" message:messageStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];


    }
    [self.navigationItem setLeftBarButtonItem:nil];

    dlProg.progress = 1.0;
    
    
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
