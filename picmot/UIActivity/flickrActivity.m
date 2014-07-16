//
//  flickrActivity.m
//  picmot
//
//  Created by Chihiro Murata on 2014/07/03.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import "flickrActivity.h"

@implementation flickrActivity
+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType {
    return @"FlickrActivity";
}

- (UIImage *)_activityImage {
    return [UIImage imageNamed:@"flickr_icon"];
}

- (NSString *)activityTitle {
    return @"Flickr";
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
        if ([self openFlickrWithItem:activityItem]) {
            break;
        }
    }
}

- (BOOL)isUsableFlickr
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"flickr://"]];
}

- (void)openFlickrOnITunes
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/flickr/id328407587?ls=1&mt=8"]];
}


- (BOOL)openFlickrWithItem:(id)item {
    
    if (![self isUsableFlickr]) {
        [self openFlickrOnITunes];
        return NO;
    }
    
    NSString *FlickrURLString = nil;
    if ([item isKindOfClass:[NSString class]]) {
        NSString *urlEncodeString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( NULL, (CFStringRef)item, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 ));
        FlickrURLString = [NSString stringWithFormat:@"flickr://msg/text/%@", urlEncodeString];
    } else if ([item isKindOfClass:[UIImage class]]) {
        UIPasteboard *pasteboard;
        if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
            pasteboard = [UIPasteboard generalPasteboard];
        } else {
            pasteboard = [UIPasteboard pasteboardWithUniqueName];
        }
        [pasteboard setData:UIImagePNGRepresentation(item) forPasteboardType:@"public.png"];
        FlickrURLString = [NSString stringWithFormat:@"flickr://msg/image/%@", pasteboard.name];
    } else {
        return NO;
    }
    
    NSURL *FlickrURL = [NSURL URLWithString:FlickrURLString];
    [[UIApplication sharedApplication] openURL:FlickrURL];
    return YES;
    
}

@end
