//
//  DCKakaoActivity.m
//  picmot
//
//  Created by Chihiro Murata on 2014/07/03.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//


#import "DCKakaoActivity.h"

@implementation DCKakaoActivity

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType {
    return @"MBKakaoActivity";
}

- (UIImage *)_activityImage {
    return [UIImage imageNamed:@"icon_kakao"];
}

- (NSString *)activityTitle {
    return @"KakaoTalk";
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
        if ([self openKakaoWithItem:activityItem]) {
            break;
        }
    }
}

- (BOOL)isUsableKakao
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"kakaolink://"]];
}

- (void)openKakaoOnITunes
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/kakaotalk-messenger/id362057947?mt=8"]];
}


- (BOOL)openKakaoWithItem:(id)item {
    
    if (![self isUsableKakao]) {
        [self openKakaoOnITunes];
        return NO;
    }
    
    NSString *kakaoURLString = nil;
    if ([item isKindOfClass:[NSString class]]) {
        NSString *urlEncodeString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( NULL, (CFStringRef)item, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 ));
        kakaoURLString = [NSString stringWithFormat:@"kakaolink://msg/text/%@", urlEncodeString];
    } else if ([item isKindOfClass:[UIImage class]]) {
        UIPasteboard *pasteboard;
        if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
            pasteboard = [UIPasteboard generalPasteboard];
        } else {
            pasteboard = [UIPasteboard pasteboardWithUniqueName];
        }
        [pasteboard setData:UIImagePNGRepresentation(item) forPasteboardType:@"public.png"];
        kakaoURLString = [NSString stringWithFormat:@"kakaolink://msg/image/%@", pasteboard.name];
    } else {
        return NO;
    }
    
    NSURL *kakaotalk = [NSURL URLWithString:kakaoURLString];
    [[UIApplication sharedApplication] openURL:kakaotalk];
    return YES;
    
    
}

@end