//
//  DownloadpageViewController.h
//  picmot
//
//  Created by hayato on 7/15/14.
//  Copyright (c) 2014 Chihiro Murata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZipArchive.h"


@interface DownloadpageViewController : UIViewController<NSURLSessionDownloadDelegate,UIScrollViewDelegate>


@property (nonatomic, assign)NSString * pcTitle;
@property (nonatomic, assign)NSString * pcFile;
@property (nonatomic, assign)NSString * pcImage;
@property (nonatomic, assign)NSString * pcZip;
@property (nonatomic, assign)NSString * pccateImage;

@end
