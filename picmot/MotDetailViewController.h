//
//  MotDetailViewController.h
//  picmot
//
//  Created by Chihiro Murata on 2014/03/12.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MotDetailViewController :UIViewController<UIScrollViewDelegate>
@property (nonatomic,retain)NSString *str;
@property (nonatomic,assign)NSInteger i;
@property (nonatomic,assign)NSInteger category_number;
@property (nonatomic,assign)NSArray *proArray;



//@property (nonatomic) BOOL isFullscreen;

@end
