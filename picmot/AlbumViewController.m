//
//  AlbumViewController.m
//  picmot
//
//  Created by Chihiro Murata on 2014/07/04.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import "AlbumViewController.h"
#import "DetailAlbumViewController.h"
#import "CollectionCell.h"
#import "SelfActivity.h"


@interface AlbumViewController (){
    NSMutableArray *_objects;
}

@property (nonatomic, strong) NSArray *photos;
@end

@implementation AlbumViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SelfActivity *selfact = [[SelfActivity alloc]init];
    selfact.imagedata = [NSData dataWithContentsOfFile:selfact.imagestr];
    NSString *homeDir =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Album"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *list = [fileManager contentsOfDirectoryAtPath:homeDir
                                                     error:&error];
    
    int n = (int)[list count];
    NSLog(@"%d",n);
    
//    selfact.namecount = (int)[selfact.userD integerForKey:@"savepic"];
//    [selfact.userD synchronize];
    
//    NSLog(@"%d",selfact.namecount);
    
    NSMutableArray *savephotos = [NSMutableArray array];
    for (int i = 0; i <= 20; i++) {
            UIImage *savedimage = [UIImage imageNamed:[NSString stringWithFormat:@"../Documents/Album/pic%d.jpg",i]];
            if (savedimage != nil) {
                [savephotos addObject:savedimage];
            }
    }
    self.photos = @[savephotos];
    _objects = savephotos;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    
    // ナビゲーションバーの色を変更
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.photos count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // セクション内のアイテム数をカウント
    return [[self.photos objectAtIndex:section] count];
    
    
    //return _objects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
//    
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:[[self.photos objectAtIndex:indexPath.section] objectAtIndex:indexPath.item]];
//    imgView.frame = CGRectMake(3.0, 3.0, 100.0, 100.0);
//    
//    // cellにimgViewをセット
//    [cell addSubview:imgView];
    
    CollectionCell *cell = (CollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    [cell setImage:[_objects objectAtIndex:indexPath.item]];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"goDetail"]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        UIImage *img = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:img];
        
    }
}
@end
