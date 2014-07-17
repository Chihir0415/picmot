//
//  StickerDetailViewController.m
//  picmot
//
//  Created by hayato on 7/15/14.
//  Copyright (c) 2014 Chihiro Murata. All rights reserved.
//

#import "StickerDetailViewController.h"

@interface StickerDetailViewController (){
    UIView *cateView;
    UIButton *dlBtn;
    UIProgressView *dlProg;
    UIImageView *cateImg;
    UIImageView *allImg;
    UIScrollView *imgScrl;
    UILabel *dlLabel;
}

@end

@implementation StickerDetailViewController

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
    [cateView addSubview:dlBtn];
    
    dlLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 100)];
    dlLabel.textColor = [UIColor blackColor];
    [cateView addSubview:dlLabel];
    
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
    
    // ファイルやディレクトリの一覧を表示する
    dlBtn.enabled = NO;
    dlLabel.text = self.pcTitle;
    allImg.image = self.pcallImage;
    cateImg.image = self.pcImage;
    [dlBtn setTitle:@"downloaded" forState:UIControlStateNormal ];
    dlBtn.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.0];
    [dlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dlBtn.alpha = 1.0;
    
            
    
    
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
