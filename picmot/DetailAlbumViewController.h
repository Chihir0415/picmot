//
//  DetailAlbumViewController.h
//  picmot
//
//  Created by Chihiro Murata on 2014/07/04.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailAlbumViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (nonatomic,assign)NSInteger i;

@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
- (IBAction)shereBtn:(id)sender;
- (IBAction)deleteBtu:(id)sender;

@end
