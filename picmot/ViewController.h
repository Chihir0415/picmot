//
//  ViewController.h
//  picmot
//
//  Created by Chihiro Murata on 2014/03/11.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITabBarDelegate, UIActionSheetDelegate, UIScrollViewDelegate>
{
    IBOutlet __weak UIScrollView *_scrollView;
    IBOutlet __weak UIImageView *_imageView;
    __weak IBOutlet UIView *selfview;
}
@property (weak, nonatomic) IBOutlet UITabBar *tabBaritem;
@end