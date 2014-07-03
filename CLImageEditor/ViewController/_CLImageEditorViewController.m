//
//  _CLImageEditorViewController.m
//
//  Created by sho yakushiji on 2013/11/05.
//  Copyright (c) 2013年 CALACULU. All rights reserved.
//

#import "_CLImageEditorViewController.h"
#import "LINEActivity.h"
#import "DCKakaoActivity.h"
#import "CLImageToolBase.h"


#pragma mark- _CLViewState

@interface _CLImageViewState : NSObject

@property (nonatomic, strong) UIView *superview;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) BOOL userInteratctionEnabled;
@property (nonatomic, assign) CGAffineTransform transform;
@property (nonatomic, assign) UIImage *image;

@end


@implementation _CLImageViewState

- (id)initWithImageView:(UIImageView*)view
{
    self = [super init];
    if(self){
        [self setStateWithImageView:view];
    }
    return self;
}

- (void)setStateWithImageView:(UIImageView*)view
{
    CGAffineTransform trans = view.transform;
    view.transform = CGAffineTransformIdentity;
    
    self.superview = view.superview;
    self.frame     = view.frame;
    self.transform = trans;
    self.userInteratctionEnabled = view.userInteractionEnabled;
    self.image = view.image;
    
    view.transform = trans;
}

@end


#pragma mark- _CLImageEditorViewController
@interface _CLImageEditorViewController()
<CLImageToolProtocol>
@property (nonatomic, strong) CLImageToolBase *currentTool;
@property (nonatomic, strong, readwrite) CLImageToolInfo *toolInfo;
@property (nonatomic, strong) _CLImageViewState *initialImageViewState;
@end

@implementation _CLImageEditorViewController
{
    UIImage *_originalImage;
    UIView *_bgView;
}
@synthesize toolInfo = _toolInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [self initWithNibName:@"_CLImageEditorViewController" bundle:nil];
    if (self){
        self.toolInfo = [CLImageToolInfo toolInfoForToolClass:[self class]];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    return [self initWithImage:image delegate:nil];
}

- (id)initWithImage:(UIImage*)image delegate:(id<CLImageEditorDelegate>)delegate
{
    self = [self init];
    if (self){
        _originalImage = [image deepCopy];
        self.delegate = delegate;
    }
    return self;
}

- (id)initWithDelegate:(id<CLImageEditorDelegate>)delegate
{
    self = [self init];
    if (self){
        self.delegate = delegate;
    }
    return self;
}

- (void)showInViewController:(UIViewController*)controller withImageView:(UIImageView*)imageView;
{
    [_imageView removeFromSuperview];
    _imageView = nil;
    
    _originalImage = imageView.image;
    
    _imageView = imageView;
    self.initialImageViewState = [[_CLImageViewState alloc] initWithImageView:imageView];
    
    [controller addChildViewController:self];
    [self didMoveToParentViewController:controller];
    
    self.view.frame = controller.view.bounds;
    [controller.view addSubview:self.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.toolInfo.title;
    self.view.backgroundColor = self.theme.backgroundColor;
    
    if([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //ナビゲーションバーの感度を調整
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    
    //ナビゲーションコントロールを表示する
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //タイトルをつける
    __naviitem.title = @"Edit";
    //左側ボタン２つ
    UIBarButtonItem *leftBtn1 = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                 target:self action:@selector(pushedCloseBtn:)];
    //二つ目のボタン
    UIBarButtonItem *leftBtn2 = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                  target:self action:@selector(pushedBackBtn:)];
    //BarButtonItemsにセット
    __naviitem.leftBarButtonItems = [NSArray arrayWithObjects:leftBtn1, leftBtn2, nil];
    //右側ボタン
    __naviitem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(pushedFinishBtn:)];
    
    
//    if(self.navigationController!=nil){
//             
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pushedFinishBtn:)];
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        
//        _navigationBar.hidden = YES;
//        [_navigationBar popNavigationItemAnimated:NO];
//    }
//    else{
//        _navigationBar.topItem.title = self.title;
//    }
//    
    
    //下記、エフェクトバーの色
    _menuView.backgroundColor = [CLImageEditorTheme toolbarColor];
    
    //下側、エフェクトのメニューバー
    if([UIDevice iosVersion] < 7){
        _navigationBar.barStyle = UIBarStyleBlackTranslucent;
    }
    
    [self setMenuView];
    
    //エディット画面の画像表示
    if(_imageView==nil){
        _imageView = [UIImageView new];
        [_scrollView addSubview:_imageView];
        [self refreshImageView];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    if(self.initialImageViewState){
        [self expropriateImageView];
    }
    else{
        [self refreshImageView];
    }
}

#pragma mark- View transition

- (void)expropriateImageView
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    _imageView.frame = [window convertRect:_imageView.frame fromView:_imageView.superview];
    [window addSubview:_imageView];
    
    _bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:_bgView atIndex:0];
    
    _bgView.backgroundColor = self.view.backgroundColor;
    self.view.backgroundColor = [self.view.backgroundColor colorWithAlphaComponent:0];
    
    _bgView.alpha = 0;
    _navigationBar.transform = CGAffineTransformMakeTranslation(0, -_navigationBar.height);
    _menuView.transform = CGAffineTransformMakeTranslation(0, self.view.height-_menuView.top);
    
    [UIView animateWithDuration:kCLImageToolAnimationDuration
                     animations:^{
                         _imageView.transform = CGAffineTransformIdentity;
                         
                         CGFloat dy = ([UIDevice iosVersion]<7) ? [UIApplication sharedApplication].statusBarFrame.size.height : 0;
                         
                         CGSize size = (_imageView.image) ? _imageView.image.size : _imageView.frame.size;
                         CGFloat ratio = MIN(_scrollView.width / size.width, _scrollView.height / size.height);
                         CGFloat W = ratio * size.width;
                         CGFloat H = ratio * size.height;
                         _imageView.frame = CGRectMake((_scrollView.width-W)/2 + _scrollView.left, (_scrollView.height-H)/2 + _scrollView.top + dy, W, H);
                         
                         _bgView.alpha = 1;
                         _navigationBar.transform = CGAffineTransformIdentity;
                         _menuView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         [_scrollView addSubview:_imageView];
                         [self refreshImageView];
                     }
     ];
}

- (void)restoreImageView:(BOOL)canceled
{
    if([self.delegate respondsToSelector:@selector(imageEditor:willRestoreImageView:canceled:)]){
        [self.delegate imageEditor:self willRestoreImageView:_imageView canceled:canceled];
    }
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    CGRect rct = _imageView.frame;
    _imageView.transform = CGAffineTransformIdentity;
    _imageView.frame = [window convertRect:rct fromView:_imageView.superview];
    [window addSubview:_imageView];
    
    _menuView.frame = [window convertRect:_menuView.frame fromView:_menuView.superview];
    _navigationBar.frame = [window convertRect:_navigationBar.frame fromView:_navigationBar.superview];
    
    [window addSubview:_menuView];
    [window addSubview:_navigationBar];
    
    self.view.userInteractionEnabled = NO;
    _menuView.userInteractionEnabled = NO;
    _navigationBar.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         _bgView.alpha = 0;
                         _menuView.alpha = 0;
                         _navigationBar.alpha = 0;
                         
                         _menuView.transform = CGAffineTransformMakeTranslation(0, self.view.height-_menuView.top);
                         _navigationBar.transform = CGAffineTransformMakeTranslation(0, -_navigationBar.height);
                         
                         _imageView.frame = [window convertRect:self.initialImageViewState.frame fromView:self.initialImageViewState.superview];
                         _imageView.transform = self.initialImageViewState.transform;
                     }
                     completion:^(BOOL finished) {
                         _imageView.transform = CGAffineTransformIdentity;
                         _imageView.frame = self.initialImageViewState.frame;
                         _imageView.transform = self.initialImageViewState.transform;
                         [self.initialImageViewState.superview addSubview:_imageView];
                         
                         [_menuView removeFromSuperview];
                         [_navigationBar removeFromSuperview];
                         
                         [self willMoveToParentViewController:nil];
                         [self.view removeFromSuperview];
                         [self removeFromParentViewController];
                         
                         if([self.delegate respondsToSelector:@selector(imageEditor:didRestoreImageView:canceled:)]){
                             [self.delegate imageEditor:self didRestoreImageView:_imageView canceled:canceled];
                         }
                     }
     ];
}

#pragma mark- Properties

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    self.toolInfo.title = title;
}

#pragma mark- ImageTool setting

+ (NSString*)defaultIconImagePath
{
    return nil;
}

+ (CGFloat)defaultDockedNumber
{
    return 0;
}

+ (NSString*)defaultTitle
{
    return NSLocalizedStringWithDefaultValue(@"CLImageEditor_DefaultTitle", nil, [CLImageEditorTheme bundle], @"Edit", @"");
}

+ (BOOL)isAvailable
{
    return YES;
}

+ (NSArray*)subtools
{
    return [CLImageToolInfo toolsWithToolClass:[CLImageToolBase class]];
}

+ (NSDictionary*)optionalInfo
{
    return nil;
}

#pragma mark- 

- (void)setMenuView
{
    CGFloat x = 0;
    CGFloat W = 70;
    CGFloat H = _menuView.height;
    
    for(CLImageToolInfo *info in self.toolInfo.sortedSubtools){
        if(!info.available){
            continue;
        }
        
        CLToolbarMenuItem *view = [CLImageEditorTheme menuItemWithFrame:CGRectMake(x, 0, W, H) target:self action:@selector(tappedMenuView:) toolInfo:info];
        [_menuView addSubview:view];
        x += W;
    }
    _menuView.contentSize = CGSizeMake(MAX(x, _menuView.frame.size.width+1), 0);
}

- (void)resetImageViewFrame
{
    CGSize size = (_imageView.image) ? _imageView.image.size : _imageView.frame.size;
    CGFloat ratio = MIN(_scrollView.frame.size.width / size.width, _scrollView.frame.size.height / size.height);
    CGFloat W = ratio * size.width * _scrollView.zoomScale;
    CGFloat H = ratio * size.height * _scrollView.zoomScale;
    _imageView.frame = CGRectMake((_scrollView.width-W)/2, (_scrollView.height-H)/2, W, H);
}

- (void)fixZoomScaleWithAnimated:(BOOL)animated
{
    CGFloat minZoomScale = _scrollView.minimumZoomScale;
    _scrollView.maximumZoomScale = 0.95*minZoomScale;
    _scrollView.minimumZoomScale = 0.95*minZoomScale;
    [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:animated];
}

- (void)resetZoomScaleWithAnimated:(BOOL)animated
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
}

- (void)refreshImageView
{
    _imageView.image = _originalImage;
    
    [self resetImageViewFrame];
    [self resetZoomScaleWithAnimated:NO];
}

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark- Tool actions

- (void)setCurrentTool:(CLImageToolBase *)currentTool
{
    if(currentTool != _currentTool){
        [_currentTool cleanup];
        _currentTool = currentTool;
        [_currentTool setup];
        
        [self swapToolBarWithEditting:(_currentTool!=nil)];
        
    }
}

#pragma mark- Menu actions

- (void)swapMenuViewWithEditting:(BOOL)editting
{
    [UIView animateWithDuration:kCLImageToolAnimationDuration
                     animations:^{
                         if(editting){
                             _menuView.transform = CGAffineTransformMakeTranslation(0, self.view.height-_menuView.top);
                         }
                         else{
                             _menuView.transform = CGAffineTransformIdentity;
                         }
                     }
     ];
}

- (void)swapNavigationBarWithEditting:(BOOL)editting
{
    if(self.navigationController==nil){
        return;
    }
    
    [self.navigationController setNavigationBarHidden:editting animated:YES];
    
    if(editting){
        _navigationBar.hidden = NO;
        _navigationBar.transform = CGAffineTransformMakeTranslation(0, -_navigationBar.height);
        
        [UIView animateWithDuration:kCLImageToolAnimationDuration
                         animations:^{
                             _navigationBar.transform = CGAffineTransformIdentity;
                         }
         ];
    }
    else{
        [UIView animateWithDuration:kCLImageToolAnimationDuration
                         animations:^{
                             _navigationBar.transform = CGAffineTransformMakeTranslation(0, -_navigationBar.height);
                         }
                         completion:^(BOOL finished) {
                             _navigationBar.hidden = YES;
                             _navigationBar.transform = CGAffineTransformIdentity;
                         }
         ];
    }
}

- (void)swapToolBarWithEditting:(BOOL)editting
{
    [self swapMenuViewWithEditting:editting];
    [self swapNavigationBarWithEditting:editting];
    
    if(self.currentTool){
        UINavigationItem *item  = [[UINavigationItem alloc] initWithTitle:self.currentTool.toolInfo.title];
        item.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringWithDefaultValue(@"CLImageEditor_OKBtnTitle", nil, [CLImageEditorTheme bundle], @"OK", @"") style:UIBarButtonItemStyleDone target:self action:@selector(pushedOkBtn:)];
        item.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringWithDefaultValue(@"CLImageEditor_BackBtnTitle", nil, [CLImageEditorTheme bundle], @"Back", @"") style:UIBarButtonItemStylePlain target:self action:@selector(pushedCancelBtn:)];
        
        [_navigationBar pushNavigationItem:item animated:(self.navigationController==nil)];
    }
    else{
        [_navigationBar popNavigationItemAnimated:(self.navigationController==nil)];
    }
}

- (void)setupToolWithToolInfo:(CLImageToolInfo*)info
{
    if(self.currentTool){ return; }
    
    Class toolClass = NSClassFromString(info.toolName);
    
    if(toolClass){
        id instance = [toolClass alloc];
        if(instance!=nil && [instance isKindOfClass:[CLImageToolBase class]]){
            instance = [instance initWithImageEditor:self withToolInfo:info];
            self.currentTool = instance;
        }
    }
}

- (void)tappedMenuView:(UITapGestureRecognizer*)sender
{
    UIView *view = sender.view;
    
    view.alpha = 0.2;
    [UIView animateWithDuration:kCLImageToolAnimationDuration
                     animations:^{
                         view.alpha = 1;
                     }
     ];
    
    [self setupToolWithToolInfo:view.toolInfo];
}

- (IBAction)pushedCancelBtn:(id)sender
{
    _imageView.image = _originalImage;
    [self resetImageViewFrame];
    
    self.currentTool = nil;
}

- (IBAction)pushedOkBtn:(id)sender
{
    self.view.userInteractionEnabled = NO;
    
    [self.currentTool executeWithCompletionBlock:^(UIImage *image, NSError *error, NSDictionary *userInfo) {
        if(error){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if(image){
            //_originalImage = image;
            _imageView.image = image;
            
            [self resetImageViewFrame];
            self.currentTool = nil;
        }
        self.view.userInteractionEnabled = YES;
    }];
}

- (void)pushedCloseBtn:(id)sender
{
    if(self.initialImageViewState==nil){
        if([self.delegate respondsToSelector:@selector(imageEditorDidCancel:)]){
            [self.delegate imageEditorDidCancel:self];
        }
        else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    else{
        _imageView.image = self.initialImageViewState.image;
        [self restoreImageView:YES];
    }
}


- (void)pushedBackBtn:(id)sender
{
    //エディット画面の最初の画像表示に戻る
    if(_imageView.image != _originalImage){
        [_scrollView addSubview:_imageView];
        [self refreshImageView];
        
    }
    
}

- (void)pushedFinishBtn:(id)sender
{
 
//    // ModalViewController生成
//    SaveModalViewController *savemodalViewController;
//    savemodalViewController = [[SaveModalViewController alloc]
//                               initWithNibName:@"SaveModalViewController" bundle:nil];
//
//    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
////    SaveModalViewController *savemodalViewController = [storyboard instantiateViewControllerWithIdentifier:@"SaveModalViewController"];
//   
//    savemodalViewController.modalPresentationStyle = UIModalPresentationFormSheet;
//    // 浮かびあがってくるスタイル
//    savemodalViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    // モーダルを表示
//    [self presentViewController:savemodalViewController animated:YES completion:nil];
//    //モーダルビューのサイズ変更
//    savemodalViewController.view.superview.frame = CGRectMake(70, 90, 180, 330);
    
    
    
    //edit後のsaveを押した画面
    if(_imageView.image){
        
        //LINE用
        //NSArray *activityItems = @[item];
        NSArray *applicationActivities = @[[[LINEActivity alloc] init],[[DCKakaoActivity alloc] init]];
        
        //kakao talk用
        //NSArray *kakao = @[[[DCKakaoActivity alloc] init]];
        
        
        
        NSArray *excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypeMessage,UIActivityTypePostToTencentWeibo,UIActivityTypePostToFlickr];
        
        UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[_imageView.image,] applicationActivities:applicationActivities];
        
        activityView.excludedActivityTypes = excludedActivityTypes;
        activityView.completionHandler = ^(NSString *activityType, BOOL completed){
            if(completed && [activityType isEqualToString:UIActivityTypeSaveToCameraRoll]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved successfully" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        };
        
        [self presentViewController:activityView animated:YES completion:nil];
    }
//    else{
//        [self pushedNewBtn];
//    }
//
//
//    if(self.initialImageViewState==nil){
//        if([self.delegate respondsToSelector:@selector(imageEditor:didFinishEdittingWithImage:)]){
//            [self.delegate imageEditor:self didFinishEdittingWithImage:_originalImage];
//        }
//        else{
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }
//    }
//    else{
//        _imageView.image = _originalImage;
//        [self restoreImageView:NO];
//    }
}

#pragma mark- ScrollView delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat Ws = _scrollView.frame.size.width - _scrollView.contentInset.left - _scrollView.contentInset.right;
    CGFloat Hs = _scrollView.frame.size.height - _scrollView.contentInset.top - _scrollView.contentInset.bottom;
    CGFloat W = _imageView.frame.size.width;
    CGFloat H = _imageView.frame.size.height;
    
    CGRect rct = _imageView.frame;
    rct.origin.x = MAX((Ws-W)/2, 0);
    rct.origin.y = MAX((Hs-H)/2, 0);
    _imageView.frame = rct;
}

@end
