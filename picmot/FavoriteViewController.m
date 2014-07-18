//
//  FavoriteViewController.m
//  picmot
//
//  Created by Yuki Suzuki on 2014/07/16.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import "FavoriteViewController.h"
#import "GBFlatButton.h"
#import "UIColor+GBFlatButton.h"


@interface FavoriteViewController () {
    NSUserDefaults* favDefault;
    NSArray* favList;
    int _currentPage;
    NSBundle* bundle;
    NSString* path;
    NSArray* motList;
    UIToolbar* motTool;
    NSMutableArray* favText;
    BOOL _isFullscreen;
    GBFlatButton* favButton;
    GBFlatButton* dlButton;
    NSUserDefaults* defalt;
}

@end

@implementation FavoriteViewController

@synthesize category_number;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    favDefault = [NSUserDefaults standardUserDefaults];
    favList = [favDefault arrayForKey:@"favorite_key"];
    NSLog(@"favList %@", favList);
    
    [favDefault synchronize];
    
    //Plist読み込み
    bundle = [NSBundle mainBundle];
    path = [bundle pathForResource:@"motList" ofType:@"plist"];
    motList = [NSArray arrayWithContentsOfFile:path];
    
    // DOTO: favListでmotListから配列を引っ張ってくる
    favText = [[NSMutableArray alloc] init];
    int i;
    for (i = 0; i < [favList count]; i++) {
        NSArray* favs = [favList objectAtIndex:i];
        NSInteger favCategory = [[favs objectAtIndex:0] integerValue];
        NSInteger favPage = [[favs objectAtIndex:1] integerValue];
        [favText addObject:motList[favCategory][favPage]];
    }
    NSLog(@"favText %@", favText);
    
    //    if (favText == nil) {
    //        favText = [NSMutableArray array];
    //    }
    
    _currentPage = 0;
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    
    int n = (int)[favText count];
    
    CGSize s = scrollView.frame.size;
    CGRect contentRect = CGRectMake(0, 0, s.width * n, s.height);
    UIView* contentView = [[UIView alloc] initWithFrame:contentRect];
    
    
    UIImageView *backimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 586)];
    UIImage *image = [UIImage imageNamed:@"pic01.jpg"];
    backimage.contentMode = UIViewContentModeScaleToFill;
    [backimage setImage:image];
    [self.view addSubview:backimage];
    backimage.alpha = 0.3;
    
    
    UIView* view[n];
    UITextView* textView[n];
    for (int i = 0; i < n; i++) {
        //        view[i] = [[UIView alloc] init];
        //        view[i].tag = i;
        //        view[i].frame = CGRectMake(320 * i, 30, s.width, s.height-20);
        textView[i] = [[UITextView alloc] init];
        textView[i].tag = i;
        textView[i].frame =CGRectMake(320 * i, 100, s.width, s.height-130);
        textView[i].font = [UIFont systemFontOfSize:14];
        textView[i].text = favText[i];
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
    
    
    motTool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 44, 320, 44)];
    
    [self.view addSubview:motTool];
    
    // favoriteButtonを追加する
    favButton = [[GBFlatButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    favButton.tintColor = [UIColor gb_blueColor];
    [favButton addTarget:self action:@selector(onTapFavorite:) forControlEvents:UIControlEventTouchUpInside];
    [favButton setTitle:@"☆" forState:UIControlStateNormal];
    UIBarButtonItem* favoBtn = [[UIBarButtonItem alloc] initWithCustomView:favButton];
    
    // DownLoadButtonを追加
    dlButton = [[GBFlatButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    dlButton.tintColor = [UIColor orangeColor];
    [dlButton addTarget:self action:@selector(onTapDownLoad:) forControlEvents:UIControlEventTouchUpInside];
    [dlButton setTitle:@"DL" forState:UIControlStateNormal];
    UIBarButtonItem* dlBtn = [[UIBarButtonItem alloc] initWithCustomView:dlButton];
    dlButton.selected = NO;
    //    UIBarButtonItem* dlBtn = [[UIBarButtonItem alloc] initWithTitle:@"DownLoad" style:UIBarButtonItemStyleBordered target:self action:@selector(onTapDownLoad:)];
    
    motTool.items = [NSArray arrayWithObjects:favoBtn, dlBtn, nil];
    
    //_isFullscreen = NO;
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.view addGestureRecognizer:tapGesture];
    
    
    NSUserDefaults* favDefault = [NSUserDefaults standardUserDefaults];
    NSArray* favList = [favDefault arrayForKey:@"favorite_key"];
    
    favButton.selected = NO;
    
    for (int i = 0; i < [favList count]; i++) {
        NSArray* favs = [favList objectAtIndex:i];
        NSInteger favCategory = [[favs objectAtIndex:0] integerValue];
        NSInteger favPage = [[favs objectAtIndex:1] integerValue];
        
        if (category_number == favCategory && _currentPage == favPage) {
            NSLog(@"一致");
            favButton.selected = YES;
            break;
        }
    }
    
    //    if (favList[category_number][_currentPage] == nil) {
    //        flatButton.selected = NO;
    //    } else {
    //        flatButton.selected = YES;
    //    }
    
    [favDefault synchronize];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    int page = (offset.x + 160)/320;
    if (_currentPage != page) {
        _currentPage = page;
        NSLog(@"%d", _currentPage);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- TapFavorite
- (void)onTapFavorite:(id)inSender {
    
    defalt = [NSUserDefaults standardUserDefaults];
    
    if (favButton.selected == YES) {
        favButton.selected = NO;
    } else {
        favButton.selected = YES;
    }
    
    // お気に入りを削除する場合YES, 追加する場合NO
    BOOL isRemove = NO;
    
    // favs = UserDefaultsに保存されているお気に入り一覧
    NSArray* favs = [defalt arrayForKey:@"favorite_key"];
    if (favs == nil) {
        favs = [NSArray array];
    }
    
    NSLog(@"before\n//////////////////////////////\n%@",favs);
    
    int i;
    // for文 = お気に入り一覧からお気に入りを列挙する
    for (i = 0; i < [favs count]; i++) {
        // fav = お気に入り一覧にある、お気に入り
        NSArray* fav = [favs objectAtIndex:i];
        // favCategory = お気に入りのカテゴリ
        NSInteger favCategory = [[fav objectAtIndex:0] integerValue];
        // favPage = お気に入りのページ
        NSInteger favPage = [[fav objectAtIndex:1] integerValue];
        // currentCategory = 今見てるカテゴリ
        NSInteger currentCategory = category_number;
        // currentPage = 今見てるページ
        NSInteger currentPage = _currentPage;
        
        //NSLog(@"all_number %@, %@, %@, %@", favCategory, favPage, currentCategory, currentPage);
        
        // お気に入りにあるカテゴリとページが今見てるカテゴリとページが、同じだったらすでにお気に入りに登録されているので、次favoriteを押した時に削除
        if (favCategory == currentCategory && favPage == currentPage) {
            isRemove = YES;
            break;
        }
    }
    
    // お気に入り一覧からお気に入りを削除して上書き保存する場合
    if (isRemove) {
        defalt = [NSUserDefaults standardUserDefaults];
        
        NSMutableArray* mutableFavs = [favs mutableCopy];
        NSArray* removingFav = mutableFavs[i];
        
        [mutableFavs removeObject:removingFav];
        
        // NSLog(@"addFav %@", fav);
        
        NSArray* savingFavs = [mutableFavs copy];
        [defalt setObject:savingFavs forKey:@"favorite_key"];
        //        [defalt removeObjectForKey:@"favorite_key"];
        [defalt synchronize];
        
        NSLog(@"afterRemove\n//////////////////////////////\n%@",[defalt arrayForKey:@"favorite_key"]);
    }
    // お気に入りを追加する場合
    else {
        defalt = [NSUserDefaults standardUserDefaults];
        NSMutableArray* mutableFavs = [favs mutableCopy];
        NSMutableArray* fav = [[NSMutableArray alloc] init];
        
        [fav addObject:[NSNumber numberWithInt:category_number]];
        [fav addObject:[NSNumber numberWithInt:_currentPage]];
        
        [mutableFavs addObject:fav];
        
        // NSLog(@"addFav %@", fav);
        
        NSArray* savingFavs = [mutableFavs copy];
        [defalt setObject:savingFavs forKey:@"favorite_key"];
        [defalt synchronize];
        NSLog(@"afterSave\n//////////////////////////////\n%@",savingFavs);
    }
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
    [self.navigationController setNavigationBarHidden:_isFullscreen animated:NO];
    //motTool.alpha = _isFullscreen ? 0.0f : 1.0f;
    
    //ツールバーを非表示にする
    motTool.alpha = _isFullscreen ? 0.0f : 1.0f;
    
    //アニメーション開始
    [UIView commitAnimations];
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
