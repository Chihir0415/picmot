//
//  DownloadViewController.h
//  picmot
//
//  Created by hayato on 7/15/14.
//  Copyright (c) 2014 Chihiro Murata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadpageViewController.h"

@interface DownloadViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate,
NSXMLParserDelegate,
NSURLSessionTaskDelegate>
{
    
    //xml解析を使用
    NSString *nowTagStr;
    NSString *txtBuffer;
    
    //ユーザー名を格納する配列
@private NSMutableArray *stArr;
@private NSMutableArray *stFile;
@private NSMutableArray *stZip;
@private NSMutableArray *stImage;
@private NSMutableArray *stcateImage;
    
    //xmlの数を入れる配列
    NSInteger xml_index;
    NSInteger xml_indexfile;
    NSInteger xml_indexzip;
    NSInteger xml_indeximage;
    NSInteger xml_indexcateimage;
    
    //受信データ
@private    NSMutableData *stData;
    NSURLSessionDataTask *dataTask;
    
    //loadingView(通信中にぐるぐる回るやつ
    UIView *uv_load;
    UIActivityIndicatorView *aci_loading;
}

@end
