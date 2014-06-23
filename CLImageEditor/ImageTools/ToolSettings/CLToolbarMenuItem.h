//
//  CLToolbarMenuItem.h
//
//  

#import <UIKit/UIKit.h>

#import "UIView+CLImageToolInfo.h"

@interface CLToolbarMenuItem : UIView
{
    UIImageView *_iconView;
    UILabel *_titleLabel;
}

@property (nonatomic, assign) NSString *title;
@property (nonatomic, assign) UIImage *iconImage;

- (id)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action toolInfo:(CLImageToolInfo*)toolInfo;

@end
