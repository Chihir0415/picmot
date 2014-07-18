//
//  InstagramActivity.m
//  picmot
//
//  Created by Chihiro Murata on 2014/07/03.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import "InstagramActivity.h"

@implementation InstagramActivity

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType {
    return @"UIActivityTypePostToInstagram";
}

- (UIImage *)_activityImage {
    return [UIImage imageNamed:@"instagram.jpeg"];
}

- (NSString *)activityTitle {
    return @"Instagram";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[NSString class]]|| [activityItem isKindOfClass:[UIImage class]]) {
            return YES;
        }
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id activityItem in activityItems) {
        if ([self openInstagramWithItem:activityItem]) {
            break;
        }
    }
}

- (BOOL)isUsableINSTAGRAM
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"instagram://"]];
}

- (void)openINSTAGRAMOnITunes
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/instagram/id389801252?mt=8"]];
}


- (BOOL)openInstagramWithItem:(id)item {
    
    if (![self isUsableINSTAGRAM]) {
        [self openINSTAGRAMOnITunes];
        return NO;
    }
    
    NSString *instagramURLString = nil;
    if ([item isKindOfClass:[NSString class]]) {
        NSString *urlEncodeString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( NULL, (CFStringRef)item, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 ));
        instagramURLString = [NSString stringWithFormat:@"instagram://msg/text/%@", urlEncodeString];
    } else if ([item isKindOfClass:[UIImage class]]) {
        UIPasteboard *pasteboard;
        if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
            pasteboard = [UIPasteboard generalPasteboard];
        } else {
            pasteboard = [UIPasteboard pasteboardWithUniqueName];
        }
        [pasteboard setData:UIImagePNGRepresentation(item) forPasteboardType:@"public.png"];
        instagramURLString = [NSString stringWithFormat:@"instagram://msg/image/%@", pasteboard.name];
    } else {
        return NO;
    }
    
    NSURL *INSTAGRAMURL = [NSURL URLWithString:instagramURLString];
    [[UIApplication sharedApplication] openURL:INSTAGRAMURL];
    return YES;

}

@end