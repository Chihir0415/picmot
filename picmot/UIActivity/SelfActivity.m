//
//  SelfActivity.m
//  picmot
//
//  Created by Chihiro Murata on 2014/07/03.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import "SelfActivity.h"
#import "_CLImageEditorViewController.h"

@implementation SelfActivity

- (id)init
{
    if (self = [super init]) {
        // 初期処理
    }
    return self;
}

- (NSString *)activityType {
    return @"Album";
}

- (UIImage *)_activityImage {
    return [UIImage imageNamed:@"self_ icon"];
}

- (NSString *)activityTitle {
    return @"Album";
}


- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[NSString class]] || [activityItem isKindOfClass:[UIImage class]]) {
            return YES;
        }
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id activityItem in activityItems) {
        if ([self openSELFWithItem:activityItem])
            break;
    }
}

- (BOOL)openSELFWithItem:(id)item
{
    
    // NSFileManagerを取得 (非スレッドセーフ)
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // パス
    NSString *directoryPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Album"];
    // ディレクトリを作成
    [fileManager createDirectoryAtPath: directoryPath // (NSString*) 作成したいディレクトリパス
           withIntermediateDirectories: YES           // (BOOL) 中間ディレクトリが存在しないときに作成するか否か
                            attributes: nil           // (NSDictionary*) ディレクトリの属性
                                 error: NULL];        // (NSError**) エラー
    
    // JPEGのデータとしてNSDataを作成します
    // ここのUIImageJPEGRepresentationがミソ
    _imagedata = UIImageJPEGRepresentation(item, 0.8f);
    
    _userD = [NSUserDefaults standardUserDefaults];
    //[userD setInteger:i++ forKey:@"savepic"];
    [_userD setInteger:([_userD integerForKey:@"savepic"]+1) forKey:@"savepic"];

    _namecount = (int)[_userD integerForKey:@"savepic"];
    [_userD synchronize];

    _imagestr = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Album"] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic%d.jpg",_namecount]];
    
    //NSLog(@"%d",_namecount);
    
    if([_imagedata writeToFile:_imagestr atomically: YES]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved successfully" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        NSLog(@"save NG");
    }
    return YES;
}



@end
