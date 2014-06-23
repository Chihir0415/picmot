//
//  CLImageEditorTheme.m
//
//
//  
//

#import "CLImageEditorTheme.h"

@implementation CLImageEditorTheme

#pragma mark - singleton pattern

static CLImageEditorTheme *_sharedInstance = nil;

+ (CLImageEditorTheme*)theme
{
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[CLImageEditorTheme alloc] init];
    });
    return _sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (_sharedInstance == nil) {
            _sharedInstance = [super allocWithZone:zone];
            return _sharedInstance;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {
        self.bundleName = @"CLImageEditor";
        UIImage *newback = [UIImage imageNamed:@"001.png"];
        self.backgroundColor = [UIColor colorWithPatternImage:newback];
        self.toolbarColor = [UIColor colorWithWhite:1 alpha:0.1];
        self.toolbarTextColor = [UIColor blackColor];
        self.toolbarSelectedButtonColor = [[UIColor cyanColor] colorWithAlphaComponent:0.25];
        self.toolbarTextFont = [UIFont systemFontOfSize:10];
        [[UINavigationBar appearance] setAlpha:0.5];
        }
    return self;
}

@end
