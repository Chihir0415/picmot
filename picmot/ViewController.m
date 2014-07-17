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
<CLImageEditorDelegate, CLImageEditorThemeDelegate> {
    UIImageView* _myImageView;
}

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
    _tabBaritem.backgroundColor = [UIColor clearColor];
    [self defaults];
}

-(void)viewWillAppear:(BOOL)animated
{
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[UIImage imageNamed:@"001.png"] drawInRect:self.view.bounds];
        
        //SelfActivityで設定したuserDefaultを引っ張ってくる
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSInteger num = [ud integerForKey:@"savepic"];
    
    
    int i;
    BOOL nonFlug = NO;
        NSMutableArray *savephotos = [NSMutableArray array];
        for (i = 0; i <= num; i++) {
            UIImage *savedimage = [UIImage imageNamed:[NSString stringWithFormat:@"../Documents/Album/pic%d.jpg",i]];
            NSFileManager *fileManager01 = [NSFileManager defaultManager];
            NSString *filePath01 = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Album"] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic%ld.jpg",(long)i]];
            if ([fileManager01 fileExistsAtPath:filePath01]) {
                [savephotos addObject:savedimage];
                nonFlug = YES;
            }
        }
    
        if (nonFlug == YES) {
        //    if([fileManager01 fileExistsAtPath:filePath01]){
                _imageView.animationImages = savephotos;
                _imageView.animationDuration = 15.0;
                _imageView.animationRepeatCount = 0;
                [_imageView startAnimating];
          //  }
        }else{
            if(_imageView.isAnimating == YES)
                {
                    [_imageView stopAnimating];
                }
            _imageView.image = [UIImage imageNamed:@"pic01.jpg"];
        }
        
        UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
        [super viewWillAppear:animated];
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
    BOOL isstickerBool = [defaults boolForKey:@"STICKER_BOOL"];
    if (!isstickerBool) {
        
        //ファイルを作成
        // NSFileManagerを取得 (非スレッドセーフ)
        // 0001pcen
        NSFileManager *fileManager1pcen = [NSFileManager defaultManager];
        // パス
        NSString *directoryPath1pcen = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/stickers/0001pcen"];
        
        // ディレクトリを作成
        [fileManager1pcen createDirectoryAtPath: directoryPath1pcen // (NSString*) 作成したいディレクトリパス
                    withIntermediateDirectories: YES           // (BOOL) 中間ディレクトリが存在しないときに作成するか否か
                                     attributes: nil           // (NSDictionary*) ディレクトリの属性
                                          error: NULL];        // (NSError**) エラー
        // 0001pcjp
        NSFileManager *fileManager1pcjp = [NSFileManager defaultManager];
        // パス
        NSString *directoryPath1pcjp = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/stickers/0001pcjp"];
        
        // ディレクトリを作成
        [fileManager1pcjp createDirectoryAtPath: directoryPath1pcjp // (NSString*) 作成したいディレクトリパス
                    withIntermediateDirectories: YES           // (BOOL) 中間ディレクトリが存在しないときに作成するか否か
                                     attributes: nil           // (NSDictionary*) ディレクトリの属性
                                          error: NULL];        // (NSError**) エラー
        // 0002pcen
        NSFileManager *fileManager2pcen = [NSFileManager defaultManager];
        // パス
        NSString *directoryPath2pcen = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/stickers/0002pcen"];
        
        // ディレクトリを作成
        [fileManager2pcen createDirectoryAtPath: directoryPath2pcen // (NSString*) 作成したいディレクトリパス
                    withIntermediateDirectories: YES           // (BOOL) 中間ディレクトリが存在しないときに作成するか否か
                                     attributes: nil           // (NSDictionary*) ディレクトリの属性
                                          error: NULL];        // (NSError**) エラー
        // 0001pcjp
        NSFileManager *fileManager2pcjp = [NSFileManager defaultManager];
        // パス
        NSString *directoryPath2pcjp = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/stickers/0002pcjp"];
        
        // ディレクトリを作成
        [fileManager2pcjp createDirectoryAtPath: directoryPath2pcjp // (NSString*) 作成したいディレクトリパス
                    withIntermediateDirectories: YES           // (BOOL) 中間ディレクトリが存在しないときに作成するか否か
                                     attributes: nil           // (NSDictionary*) ディレクトリの属性
                                          error: NULL];        // (NSError**) エラー
        
        //ファイルを移動させる
        //0001pcen
        for (int i = 0; i < 12; i++) {
            
            NSString *imagePath = [NSString stringWithFormat:@"%d.png", i + 1];
            UIImage *image = [[UIImage alloc] init];
            image = [UIImage imageNamed:imagePath];
//            NSString* imagePath = [NSString stringWithFormat:@"%@/CLStickerTool/stickers/%d.png",
//                                   [[NSBundle mainBundle] pathForResource:@"CLImageEditor" ofType:@"bundle"], i + 1 ];
//            NSLog(@"imagePath=%@", imagePath);
//            UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
//            NSLog(@"imageimageimage=%@",image);
            NSData* pngData = [[NSData alloc] initWithData:UIImagePNGRepresentation(image)];
            NSLog(@"%@",pngData);
            // 今回は、Cacheディレクトリのstickersフォルダに、0.pngから順のファイル名で保存します。
            NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *cacheDirPath = [array objectAtIndex:0];
            cacheDirPath = [cacheDirPath stringByAppendingString:@"/stickers/0001pcen"];
            NSString* sticker = [NSString stringWithFormat:@"%d.png",i];
            NSString *filePath = [cacheDirPath stringByAppendingPathComponent:sticker];
            NSLog(@"filePath=%@",filePath);
            
            // 保存処理を呼び出し、0.pngから1足してとして保存します。
            if ([pngData writeToFile:filePath atomically:YES]) {
                NSLog(@"OK");
            } else {
                NSLog(@"Error");
            }
            
        }
        NSString *titlePath1 = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"txt"];
        
        NSData* Data1 = [[NSData alloc] init];
        Data1 = [NSData dataWithContentsOfFile:titlePath1];
        NSArray *array1 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cacheDirPath1 = [array1 objectAtIndex:0];
        cacheDirPath1 = [cacheDirPath1 stringByAppendingString:@"/stickers/0001pcen"];
        NSString *filePath1 = [cacheDirPath1 stringByAppendingPathComponent:@"1.txt"];
        NSLog(@"%@",filePath1);
        
        // 保存処理を呼び出し、sample.pngとして保存します。
        if ([Data1 writeToFile:filePath1 atomically:YES]) {
            NSLog(@"OK");
        } else {
            NSLog(@"Error");
        }
        
        //0001pcjp
        for (int i = 0; i < 12; i++) {
            NSString *imagePath = [NSString stringWithFormat:@"%d.png", i + 13];
            UIImage *image = [[UIImage alloc] init];
            image = [UIImage imageNamed:imagePath];
//            NSString* imagePath = [NSString stringWithFormat:@"%@/CLStickerTool/stickers/%d.png",
//                                   [[NSBundle mainBundle] pathForResource:@"CLImageEditor" ofType:@"bundle"], i + 13 ];
//            NSLog(@"imagePath=%@", imagePath);
//            UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
            NSData* pngData = [[NSData alloc] initWithData:UIImagePNGRepresentation(image)];
            NSLog(@"%@",pngData);
            // 今回は、Cacheディレクトリのstickersフォルダに、0.pngから順のファイル名で保存します。
            NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *cacheDirPath = [array objectAtIndex:0];
            cacheDirPath = [cacheDirPath stringByAppendingString:@"/stickers/0001pcjp"];
            NSString* sticker = [NSString stringWithFormat:@"%d.png",i];
            NSString *filePath = [cacheDirPath stringByAppendingPathComponent:sticker];
            NSLog(@"filePath=%@",filePath);
            
            // 保存処理を呼び出し、0.pngから1足してとして保存します。
            if ([pngData writeToFile:filePath atomically:YES]) {
                NSLog(@"OK");
            } else {
                NSLog(@"Error");
            }
            
        }
        NSString *titlePath2 = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"txt"];
        
        NSData* Data2 = [[NSData alloc] init];
        Data2 = [NSData dataWithContentsOfFile:titlePath2];
        NSArray *array2 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cacheDirPath2 = [array2 objectAtIndex:0];
        cacheDirPath2 = [cacheDirPath2 stringByAppendingString:@"/stickers/0001pcjp"];
        NSString *filePath2 = [cacheDirPath2 stringByAppendingPathComponent:@"1.txt"];
        NSLog(@"%@",filePath2);
        
        // 保存処理を呼び出し、sample.pngとして保存します。
        if ([Data2 writeToFile:filePath2 atomically:YES]) {
            NSLog(@"OK");
        } else {
            NSLog(@"Error");
        }
        //0002pcen
        for (int i = 0; i < 12; i++) {
            
            NSString *imagePath = [NSString stringWithFormat:@"%d.png", i + 25];
            UIImage *image = [[UIImage alloc] init];
            image = [UIImage imageNamed:imagePath];
//            NSString* imagePath = [NSString stringWithFormat:@"%@/CLStickerTool/stickers/%d.png",
//                                   [[NSBundle mainBundle] pathForResource:@"CLImageEditor" ofType:@"bundle"], i + 25 ];
//            NSLog(@"imagePath=%@", imagePath);
//            UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
            NSData* pngData = [[NSData alloc] initWithData:UIImagePNGRepresentation(image)];
            NSLog(@"%@",pngData);
            // 今回は、Cacheディレクトリのstickersフォルダに、0.pngから順のファイル名で保存します。
            NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *cacheDirPath = [array objectAtIndex:0];
            cacheDirPath = [cacheDirPath stringByAppendingString:@"/stickers/0002pcen"];
            NSString* sticker = [NSString stringWithFormat:@"%d.png",i];
            NSString *filePath = [cacheDirPath stringByAppendingPathComponent:sticker];
            NSLog(@"filePath=%@",filePath);
            
            // 保存処理を呼び出し、0.pngから1足してとして保存します。
            if ([pngData writeToFile:filePath atomically:YES]) {
                NSLog(@"OK");
            } else {
                NSLog(@"Error");
            }
            
        }
        NSString *titlePath3 = [[NSBundle mainBundle] pathForResource:@"3" ofType:@"txt"];
        
        NSData* Data3 = [[NSData alloc] init];
        Data3 = [NSData dataWithContentsOfFile:titlePath3];
        NSArray *array3 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cacheDirPath3 = [array3 objectAtIndex:0];
        cacheDirPath3 = [cacheDirPath3 stringByAppendingString:@"/stickers/0002pcen"];
        NSString *filePath3 = [cacheDirPath3 stringByAppendingPathComponent:@"1.txt"];
        NSLog(@"%@",filePath3);
        
        // 保存処理を呼び出し、sample.pngとして保存します。
        if ([Data3 writeToFile:filePath3 atomically:YES]) {
            NSLog(@"OK");
        } else {
            NSLog(@"Error");
        }
        
        //0002pcjp
        for (int i = 0; i < 12; i++) {
            
            NSString *imagePath = [NSString stringWithFormat:@"%d.png", i + 37];
            UIImage *image = [[UIImage alloc] init];
            image = [UIImage imageNamed:imagePath];
//            NSString* imagePath = [NSString stringWithFormat:@"%@/CLStickerTool/stickers/%d.png",
//                                   [[NSBundle mainBundle] pathForResource:@"CLImageEditor" ofType:@"bundle"], i + 37 ];
//            NSLog(@"imagePath=%@", imagePath);
//            UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
            NSData* pngData = [[NSData alloc] initWithData:UIImagePNGRepresentation(image)];
            NSLog(@"%@",pngData);
            // 今回は、Cacheディレクトリのstickersフォルダに、0.pngから順のファイル名で保存します。
            NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *cacheDirPath = [array objectAtIndex:0];
            cacheDirPath = [cacheDirPath stringByAppendingString:@"/stickers/0002pcjp"];
            NSString* sticker = [NSString stringWithFormat:@"%d.png",i];
            NSString *filePath = [cacheDirPath stringByAppendingPathComponent:sticker];
            NSLog(@"filePath=%@",filePath);
            
            // 保存処理を呼び出し、0.pngから1足してとして保存します。
            if ([pngData writeToFile:filePath atomically:YES]) {
                NSLog(@"OK");
            } else {
                NSLog(@"Error");
            }
            
        }
        NSString *titlePath4 = [[NSBundle mainBundle] pathForResource:@"4" ofType:@"txt"];
        
        NSData* Data4 = [[NSData alloc] init];
        Data4 = [NSData dataWithContentsOfFile:titlePath4];
        NSArray *array4 = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cacheDirPath4 = [array4 objectAtIndex:0];
        cacheDirPath4 = [cacheDirPath4 stringByAppendingString:@"/stickers/0002pcjp"];
        NSString *filePath4 = [cacheDirPath4 stringByAppendingPathComponent:@"1.txt"];
        NSLog(@"%@",filePath4);
        
        // 保存処理を呼び出し、sample.pngとして保存します。
        if ([Data4 writeToFile:filePath4 atomically:YES]) {
            NSLog(@"OK");
        } else {
            NSLog(@"Error");
        }
        
        //defaultsの値を変更して保持
        [defaults setBool:YES forKey:@"STICKER_BOOL"];
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
    UINavigationController *nvc = [self.storyboard instantiateViewControllerWithIdentifier:@"UINavigationController1"];
    [self presentViewController:nvc animated:YES completion:nil];
}


- (void)pushedNewBtn
{
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
        [sheet showInView:self.view.window];
}

//- (void)pushedEditBtn
//{
//    if(_imageView.image){
//        CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:_imageView.image];
//        editor.delegate = self;
//        //CLImageEditor *editor = [[CLImageEditor alloc] initWithDelegate:self];
//        
//        
//        CLImageToolInfo *tool = [editor.toolInfo subToolInfoWithToolName:@"CLStickerTool" recursive:NO];
//        tool.available = YES;
//        tool.dockedNumber = -1;
//        
//        tool= [editor.toolInfo subToolInfoWithToolName:@"CLResizeTool" recursive:YES];
//        tool.available = NO;
//        
//        
//        [self presentViewController:editor animated:YES completion:nil];
//        //[editor showInViewController:self withImageView:_imageView];
//    }
//    else{
//        [self pushedNewBtn];
//    }
//}
- (void)pushedMenuBtn
{
    UITabBarController *nvc = [self.storyboard instantiateViewControllerWithIdentifier:@"UITabBarController"];
    [self presentViewController:nvc animated:YES completion:nil];}

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

   // [self refreshImageView];
    
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
        case 2:
            [self pushedNewBtn];
            break;
        case 3:
            [self pushedMenuBtn];
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

//- (void)resetImageViewFrame
//{
//    CGSize size = (_imageView.image) ? _imageView.image.size : _imageView.frame.size;
//    CGFloat ratio = MIN(_scrollView.frame.size.width / size.width, _scrollView.frame.size.height / size.height);
//    CGFloat W = ratio * size.width;
//    CGFloat H = ratio * size.height;
//    _imageView.frame = CGRectMake(0, 0, W, H);
//    _imageView.superview.bounds = _imageView.bounds;
//}
//
//- (void)resetZoomScaleWithAnimate:(BOOL)animated
//{
//    CGFloat Rw = _scrollView.frame.size.width / _imageView.frame.size.width;
//    CGFloat Rh = _scrollView.frame.size.height / _imageView.frame.size.height;
//    
//    //CGFloat scale = [[UIScreen mainScreen] scale];
//    CGFloat scale = 1;
//    Rw = MAX(Rw, _imageView.image.size.width / (scale * _scrollView.frame.size.width));
//    Rh = MAX(Rh, _imageView.image.size.height / (scale * _scrollView.frame.size.height));
//    
//    _scrollView.contentSize = _imageView.frame.size;
//    _scrollView.minimumZoomScale = 1;
//    _scrollView.maximumZoomScale = MAX(MAX(Rw, Rh), 1);
//    
//    [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:animated];
//    [self scrollViewDidZoom:_scrollView];
//}
//
//- (void)refreshImageView
//{
//    [self resetImageViewFrame];
//    [self resetZoomScaleWithAnimate:NO];
//}

@end
