//
//  ServerViewController.h
//  picmot
//
//  Created by hayato on 7/1/14.
//  Copyright (c) 2014 Chihiro Murata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StickerDetailViewController.h"
#import "DownloadViewController.h"

@interface ServerViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
