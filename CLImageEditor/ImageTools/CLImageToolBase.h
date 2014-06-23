//
//  CLImageToolBase.h
//
//  

#import <Foundation/Foundation.h>

#import "_CLImageEditorViewController.h"
#import "CLImageToolSettings.h"


static const CGFloat kCLImageToolAnimationDuration = 0.3;
static const CGFloat kCLImageToolFadeoutDuration   = 0.2;



@interface CLImageToolBase : NSObject<CLImageToolProtocol>
{
    
}
@property (nonatomic, weak) _CLImageEditorViewController *editor;
@property (nonatomic, weak) CLImageToolInfo *toolInfo;

- (id)initWithImageEditor:(_CLImageEditorViewController*)editor withToolInfo:(CLImageToolInfo*)info;

- (void)setup;
- (void)cleanup;
- (void)executeWithCompletionBlock:(void(^)(UIImage *image, NSError *error, NSDictionary *userInfo))completionBlock;

@end
