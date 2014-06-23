//
//  CLImageEditor.m
//
//  
//

#import "CLImageEditor.h"

#import "_CLImageEditorViewController.h"

@interface CLImageEditor ()

@end


@implementation CLImageEditor

- (id)init
{
    return [[_CLImageEditorViewController alloc] init];
}

- (id)initWithImage:(UIImage*)image
{
    return [self initWithImage:image delegate:nil];
}

- (id)initWithImage:(UIImage*)image delegate:(id<CLImageEditorDelegate>)delegate
{
    return [[_CLImageEditorViewController alloc] initWithImage:image delegate:delegate];
}

- (id)initWithDelegate:(id<CLImageEditorDelegate>)delegate
{
    return [[_CLImageEditorViewController alloc] initWithDelegate:delegate];
}

- (void)showInViewController:(UIViewController*)controller withImageView:(UIImageView*)imageView;
{
    
}

- (CLImageEditorTheme*)theme
{
    return [CLImageEditorTheme theme];
}

@end

