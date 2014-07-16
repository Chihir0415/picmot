//
//  StickerDetailViewController.m
//  picmot
//
//  Created by hayato on 7/15/14.
//  Copyright (c) 2014 Chihiro Murata. All rights reserved.
//

#import "StickerDetailViewController.h"

@interface StickerDetailViewController (){
    UIButton *dlBtn;
    UIProgressView *dlProg;
    UIImageView *cateImg;
    UIView *imgView;
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

    
    dlBtn = [[UIButton alloc] init];
    dlBtn =  [ UIButton buttonWithType:UIButtonTypeRoundedRect ];
    dlBtn.frame = CGRectMake( 60, 255, 200, 60 );
    [self.view addSubview:dlBtn];
    
    dlLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 100, 130, 100)];
    dlLabel.textColor = [UIColor blackColor];
    [self.view addSubview:dlLabel];
    
    cateImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 150, 150)];
    cateImg.layer.borderColor = [UIColor grayColor].CGColor;
    cateImg.layer.borderWidth = 0.5f;
    cateImg.layer.cornerRadius = 2.0f;
    [self.view addSubview:cateImg];
    
    imgScrl = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 300, 300, self.view.bounds.size.height - 350)];
    [imgScrl setContentSize:CGSizeMake(300, 750)];
    
    imgScrl.userInteractionEnabled = YES;
    imgScrl.delegate = self;
    
    imgScrl.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
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
