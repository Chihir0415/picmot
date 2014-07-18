//
//  FavoriteViewController.h
//  picmot
//
//  Created by Yuki Suzuki on 2014/07/16.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic,retain)NSString *str;
@property (nonatomic,assign)NSInteger i;
@property (nonatomic,assign)NSInteger category_number;
@property (nonatomic,assign)NSArray *proArray;


@end
