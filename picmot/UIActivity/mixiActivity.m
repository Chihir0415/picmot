//
//  mixiActivity.m
//  picmot
//
//  Created by Chihiro Murata on 2014/07/03.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import "mixiActivity.h"

@implementation mixiActivity

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType {
    return @"https://mixi.jp";
}

- (UIImage *)_activityImage {
    return [UIImage imageNamed:@"mixi_icon"];
}

- (NSString *)activityTitle {
    return @"mixi";
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
        if ([self openmixiWithItem:activityItem]) {
            break;
        }
    }
}

- (BOOL)isUsablemixi
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mixi://"]];
}

- (void)openmixiOnITunes
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/jp/app/mixi/id285951864?mt=8"]];
}


- (BOOL)openmixiWithItem:(id)item {
    
    if (![self isUsablemixi]) {
        [self openmixiOnITunes];
        return NO;
    }
    
    NSString *mixiURLString = nil;
    if ([item isKindOfClass:[NSString class]]) {
        NSString *urlEncodeString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( NULL, (CFStringRef)item, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 ));
        mixiURLString = [NSString stringWithFormat:@"mixi://msg/text/%@", urlEncodeString];
    } else if ([item isKindOfClass:[UIImage class]]) {
        UIPasteboard *pasteboard;
        if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
            pasteboard = [UIPasteboard generalPasteboard];
        } else {
            pasteboard = [UIPasteboard pasteboardWithUniqueName];
        }
        [pasteboard setData:UIImagePNGRepresentation(item) forPasteboardType:@"public.png"];
        mixiURLString = [NSString stringWithFormat:@"mixi://msg/image/%@", pasteboard.name];
    } else {
        return NO;
    }
    
    NSURL *mixi = [NSURL URLWithString:mixiURLString];
    [[UIApplication sharedApplication] openURL:mixi];
    return YES;
    
    
}


@end
