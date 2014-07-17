//
//  AlbumViewController.m
//  picmot
//
//  Created by Chihiro Murata on 2014/07/04.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import "AlbumViewController.h"
#import "AppDelegate.h"
#import "DetailAlbumViewController.h"
#import "CollectionCell.h"
#import "SelfActivity.h"


@interface AlbumViewController (){
    NSMutableArray *_objects;
   // NSArray *_numArr;
    int u;
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

-(void)loadSaveAlbum
{
    
    //SelfActivityで設定したuserDefaultを引っ張ってくる
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger num = [ud integerForKey:@"savepic"];
    
    NSMutableArray *_imgNumArr = [[NSMutableArray alloc]init];
    NSMutableArray *savephotos = [[NSMutableArray alloc]init];
    for (u = 0; u <= num; u++) {
        UIImage *savedimage = [[UIImage alloc]init];
        savedimage = [UIImage imageNamed:[NSString stringWithFormat:@"../Documents/Album/pic%d.jpg",u]];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Album"] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic%ld.jpg",(long)u]];

        if ([fileManager fileExistsAtPath:filePath]) {
            [_imgNumArr addObject:[NSNumber numberWithInt:u]];
            [savephotos addObject:savedimage];
        }
        
//        if (savedimage != nil) {
//            [_imgNumArr addObject:[NSNumber numberWithInt:u]];
//            [savephotos addObject:savedimage];
//        }
    }
    _numArr = _imgNumArr;
    NSLog(@"arr2 = %@",_numArr);
    self.photos = @[savephotos];
    _objects = savephotos;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // BackButton
    UIBarButtonItem* menu = [[UIBarButtonItem alloc]
                             initWithTitle:@"Back"
                             style:UIBarButtonItemStyleBordered
                             target:self
                             action:@selector(barbutton1:)];
    self.navigationItem.leftBarButtonItems = @[menu];
    // ナビゲーションバーの色を変更
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

-(void)barbutton1:(UIBarButtonItem *)menu{
    [self dismissViewControllerAnimated:YES completion: NULL];
    
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
        NSLog(@"indexpath = %ld",(long)indexPath.row);
        [[segue destinationViewController] setDetailItem:img];

        DetailAlbumViewController *davc = [segue destinationViewController];
        NSInteger num = [[_numArr objectAtIndex:indexPath.row] integerValue];
        davc.i = num;
        
//        DetailAlbumViewController *davc = [[DetailAlbumViewController alloc]init];
//        davc.i = [[_numArr objectAtIndex:indexPath.row] intValue];
        
        
        }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self loadSaveAlbum];
    
    [self.collectionView reloadData];
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
