//
//  SelfActivity.h
//  picmot
//
//  Created by Chihiro Murata on 2014/07/03.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfActivity : UIActivity

@property (nonatomic,retain)NSString *imagestr;
@property (nonatomic,retain)NSData *imagedata;
@property (nonatomic,retain)NSUserDefaults *userD;
@property int namecount;

@end
