//
//  MotTableViewController.h
//  picmot
//
//  Created by Chihiro Murata on 2014/03/12.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MotDetailViewController.h"


@interface MotTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    CGPoint _tBegan, _tEnded;
    NSArray *mydata;
}
@property (weak, nonatomic) IBOutlet UIButton *backbutton;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,assign)NSInteger category_number;
@end
