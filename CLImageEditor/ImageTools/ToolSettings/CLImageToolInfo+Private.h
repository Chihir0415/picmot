//
//  CLImageToolInfo+Private.h
//
//
//  Created by sho yakushiji on 2013/11/05.
//  Copyright (c) 2013年 CALACULU. All rights reserved.


#import "CLImageToolInfo.h"

@protocol CLImageToolProtocol;

@interface CLImageToolInfo (Private)

+ (CLImageToolInfo*)toolInfoForToolClass:(Class<CLImageToolProtocol>)toolClass;
+ (NSArray*)toolsWithToolClass:(Class<CLImageToolProtocol>)toolClass;

@end
