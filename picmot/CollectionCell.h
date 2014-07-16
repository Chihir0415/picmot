//
//  CollectionCell.h
//  picmot
//
//  Created by Chihiro Murata on 2014/07/04.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UICollectionViewCell
{
    IBOutlet UIImageView *imageview;
}

- (void)setImage:(UIImage *)image;
@end
