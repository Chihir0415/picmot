//
//  MotDetailViewController.m
//  picmot
//
//  Created by Chihiro Murata on 2014/03/12.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import "MotDetailViewController.h"

@interface MotDetailViewController (){
    int _currentPage;
    // UIButton* favoBtn;
    UIToolbar* motTool;
    BOOL _isFullscreen;
}
@end

@implementation MotDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ページの番号を保持するcurrentPageの初期化
    _currentPage = 1;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    
    //NSArray *myArr10 = [[NSArray alloc]initWithObjects:@"作成中...",nil];  お気に入り画面を作成する

    //Plist読み込み
    NSBundle* bundle =[NSBundle mainBundle];
    NSString* path = [bundle pathForResource:@"motList" ofType:@"plist"];
    NSArray* motList = [NSArray arrayWithContentsOfFile:path];
//    NSLog(@"%@", plist);
//    NSArray* itemes = [NSArray arrayWithArray:[dic objectAtIndex:@"Root"]];
    
//    NSArray* Array = @[myArr2,myArr3,myArr4,myArr5,myArr6,myArr7,myArr8,myArr9];
   // NSLog(@"Array = %@",Array[0][5]);
    
    int n = (int)[motList[_i] count];
    
    // UIScrollViewに表示するコンテンツViewを作成する。
    CGSize s = scrollView.frame.size;
    CGRect contentRect = CGRectMake(0, 0, s.width * n, s.height);
    UIView *contentView = [[UIView alloc] initWithFrame:contentRect];
    
    //背景画像を変える
    UIImageView *backimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 586)];
    UIImage *image = [UIImage imageNamed:@"pic01.jpg"];
    backimage.contentMode = UIViewContentModeScaleToFill;
    [backimage setImage:image];
    [self.view addSubview:backimage];
    backimage.alpha = 0.3;
    
    UIView* view[n];
    UITextView* textView[n];
    for (int i = 0; i < n; i++) {
        view[i] = [[UIView alloc] init];
        view[i].tag = i;
        view[i].frame = CGRectMake(320 * i, 30, s.width, s.height-20);
        
        textView[i] = [[UITextView alloc]init];
        textView[i].tag = i;
        textView[i].frame =CGRectMake(320 * i, 100, s.width, s.height-130);
        textView[i].font = [UIFont systemFontOfSize:14];
        textView[i].text = motList[_i][i];
        textView[i].textAlignment = NSTextAlignmentCenter;
        
       // view[i].backgroundColor = [UIColor clearColor];
        textView[i].editable = NO;
        
        [contentView addSubview:view[i]];
        [contentView addSubview:textView[i]];
    }
    
    // スクロールViewにコンテンツViewを追加する。
    [scrollView addSubview:contentView];
    
    // スクロールView上のコンテンツViewのサイズを指定します。
    scrollView.contentSize = contentView.frame.size;
    
    // 初期表示するコンテンツViewの場所を指定します。
    // ２ページ目から表示したいときはこう↓
    //scrollView.contentOffset = CGPointMake(320, 0);
       scrollView.contentOffset = CGPointMake(0, 0);
    
    
    // FavoriteBtn / ToolBarを生成
    motTool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 44, 320, 44)];
    [self.view addSubview:motTool];
    
    // UIBarButtonItem
    UIBarButtonItem* favoBtn = [[UIBarButtonItem alloc] initWithTitle:@"Favorite" style:UIBarButtonItemStyleBordered target:scrollView action:@selector(onTapFavorite:)];
    UIBarButtonItem* download = [[UIBarButtonItem alloc] initWithTitle:@"DownLoad" style:UIBarButtonItemStyleBordered target:scrollView action:@selector(onTapDownLoad:)];
    motTool.items = [NSArray arrayWithObjects:favoBtn, download, nil];
    
    
    //_isFullscreen = NO;
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.view addGestureRecognizer:tapGesture];
    //[tapGesture release];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 現在の表示位置（左上）のx座標とUIScrollViewの表示幅(320px)を用いて現在のページ番号を計算します。
    CGPoint offset = scrollView.contentOffset;
    int page = (offset.x + 160)/320;
    
    // 現在表示しているページ番号と異なる場合には、
    // ページ切り替わりと判断し、処理を呼び出します。
    // currentPageは、現在ページ数を保持するフィールド変数。
    if (_currentPage != page) {
        _currentPage = page;
       // NSLog(@"%d",_currentPage);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark- TapFavorite
- (void)onTapFavorite:(id)inSender
{
	// ボタンを押された時の処理をここに追加
    
	return;
}

#pragma mark- TapFavorite
- (void)onTapDownLoad:(id)inSender
{
    // ボタンを押された時の処理をここに追加
    return;
}


#pragma mark- Fullscreen

- (void) handleTapGesture:(UITapGestureRecognizer*)sender {
    
    
    //フルスクリーンフラグ切り替え
    _isFullscreen = !_isFullscreen;
    
    //アニメーションの定義開始
    [UIView beginAnimations:nil context:NULL];
    
    //アニメーション秒数の指定
    [UIView setAnimationDuration:0.3f];
    
    //ステータスバーを非表示にする
    [[UIApplication sharedApplication] setStatusBarHidden:_isFullscreen withAnimation:UIStatusBarAnimationFade];
    
    //ナビゲーションバーを非表示にする
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    motTool.alpha = _isFullscreen ? 0.0f : 1.0f;
    
    //ツールバーを非表示にする
    motTool.alpha = _isFullscreen ? 0.0f : 1.0f;
    
    //アニメーション開始
    [UIView commitAnimations];
    
    NSLog(@"tap");
    
    
}
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //フルスクリーンフラグ切り替え
//    _isFullscreen = !_isFullscreen;
//    
//    //アニメーションの定義開始
//    [UIView beginAnimations:nil context:NULL];
//    
//    //アニメーション秒数の指定
//    [UIView setAnimationDuration:0.3f];
//    
//    //ステータスバーを非表示にする
//    [[UIApplication sharedApplication] setStatusBarHidden:_isFullscreen withAnimation:UIStatusBarAnimationFade];
//    
//    //ナビゲーションバーを非表示にする
//    motTool.alpha = _isFullscreen ? 0.0f : 1.0f;
//    
//    //ツールバーを非表示にする
//    motTool.alpha = _isFullscreen ? 0.0f : 1.0f;
//    
//    //アニメーション開始
//    [UIView commitAnimations];
//    
//}
@end