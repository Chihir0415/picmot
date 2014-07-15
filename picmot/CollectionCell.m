//
//  CollectionCell.m
//  picmot
//
//  Created by Chihiro Murata on 2014/07/04.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import "CollectionCell.h"
#import "AlbumViewController.h"

@implementation CollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
  
    [imageview setImage:image];
}

@end
