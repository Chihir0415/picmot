//
//  StickerDetailViewController.h
//  picmot
//
//  Created by hayato on 7/15/14.
//  Copyright (c) 2014 Chihiro Murata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerViewController.h"

@interface StickerDetailViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, assign)NSString * pcTitle;
@property (nonatomic, assign)UIImage * pcallImage;
@property (nonatomic, assign)UIImage * pcImage;


@end
