//
//  CLImageEditor.h
//
//
//

#import <UIKit/UIKit.h>

#import "CLImageToolInfo.h"
#import "CLImageEditorTheme.h"

@protocol CLImageEditorDelegate;

@interface CLImageEditor : UIViewController
{
    
}
@property (nonatomic, weak) id<CLImageEditorDelegate> delegate;
@property (nonatomic, readonly) CLImageEditorTheme *theme;
@property (nonatomic, readonly) CLImageToolInfo *toolInfo;

- (id)initWithImage:(UIImage*)image;
- (id)initWithImage:(UIImage*)image delegate:(id<CLImageEditorDelegate>)delegate;
- (id)initWithDelegate:(id<CLImageEditorDelegate>)delegate;

- (void)showInViewController:(UIViewController*)controller withImageView:(UIImageView*)imageView;

@end



@protocol CLImageEditorDelegate <NSObject>
@optional
- (void)imageEditor:(CLImageEditor*)editor didFinishEdittingWithImage:(UIImage*)image;
- (void)imageEditorDidCancel:(CLImageEditor*)editor;

- (void)imageEditor:(CLImageEditor*)editor willRestoreImageView:(UIImageView*)image canceled:(BOOL)canceled;
- (void)imageEditor:(CLImageEditor*)editor didRestoreImageView:(UIImageView*)image canceled:(BOOL)canceled;

@end