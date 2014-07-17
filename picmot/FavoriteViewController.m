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
