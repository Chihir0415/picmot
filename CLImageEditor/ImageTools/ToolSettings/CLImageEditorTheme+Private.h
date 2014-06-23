//
//  CLImageEditorTheme+Private.h
//
//  

#import "CLImageEditorTheme.h"

#import "CLToolbarMenuItem.h"

@interface CLImageEditorTheme (Private)

+ (NSString*)bundleName;
+ (NSBundle*)bundle;
+ (UIImage*)imageNamed:(NSString*)path;

+ (UIColor*)backgroundColor;
+ (UIColor*)toolbarColor;
+ (UIColor*)toolbarTextColor;
+ (UIColor*)toolbarSelectedButtonColor;

+ (UIFont*)toolbarTextFont;

+ (UIActivityIndicatorView*)indicatorView;
+ (CLToolbarMenuItem*)menuItemWithFrame:(CGRect)frame target:(id)target action:(SEL)action toolInfo:(CLImageToolInfo*)toolInfo;

@end
