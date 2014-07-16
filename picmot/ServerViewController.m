//
//  ServerViewController.m
//  picmot
//
//  Created by hayato on 7/1/14.
//  Copyright (c) 2014 Chihiro Murata. All rights reserved.
//

#import "ServerViewController.h"

@interface ServerViewController () {
    NSMutableArray *_proArray;
    NSMutableArray *_imgArray;
    NSMutableArray *_allimgArray;

}

@end

@implementation ServerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem* menu = [[UIBarButtonItem alloc]
                             initWithTitle:@"Menu"
                             style:UIBarButtonItemStyleBordered
                             target:self
                             action:@selector(barbutton1:)];
    self.navigationItem.leftBarButtonItems = @[menu];
    
    UIBarButtonItem* download = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                             target:self
                             action:@selector(barbutton2:)];
    self.navigationItem.rightBarButtonItems = @[download];
    _tableView.dataSource = self;
    _tableView.delegate = self;

    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }

    self.tableView.rowHeight = 80;
//    self.tableView.backgroundColor = [UIColor blackColor];
    
    
}
-(void)barbutton1:(UIBarButtonItem *)menu{
    [self dismissViewControllerAnimated:YES completion: NULL];
    
    
}
-(void)barbutton2:(UIBarButtonItem *)menu{
    DownloadViewController *download = [self.storyboard instantiateViewControllerWithIdentifier:@"DownloadViewController"];
    [[self navigationController]pushViewController:download animated:YES];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_proArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 定数でCellを用意
    static NSString *CellIndetifier = @"Cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"a"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndetifier];
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_proArray[indexPath.row]];
    NSLog(@"shitumondesu%@",_proArray[indexPath.row]);
    
        cell.imageView.image = _imgArray[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
//    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StickerDetailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"StickerDetailViewController"];

    dvc.pcTitle = _proArray[indexPath.row];
    dvc.pcImage = _imgArray[indexPath.row];
    dvc.pcallImage = _allimgArray[indexPath.row];
    
    // NavigationControllerを使ってpushで遷移
    [[self navigationController]pushViewController:dvc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    _proArray = [[NSMutableArray alloc] init];
    
    NSArray * librarystickers = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *stickerPath = [librarystickers lastObject];
    stickerPath = [stickerPath stringByAppendingString:@"/Caches/stickers/"];
    NSLog(@"nannyato=%@",stickerPath);
    
    NSString *itemPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/stickers"];
    
    // ファイルマネージャを作成
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    NSArray *list = [fileManager contentsOfDirectoryAtPath:itemPath
                                                     error:&error];
    _proArray = [NSMutableArray array];
    _imgArray = [NSMutableArray array];
    _allimgArray = [NSMutableArray array];
    
    
    for(NSString *path in list){
        NSString *filePath = [NSString stringWithFormat:@"%@%@/1.txt", stickerPath, path];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        NSLog(@"tateteteetetet%@",data);
        
        if (data == NULL) {
            NSLog(@"empty");
        }else{
            
            
            NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //        NSLog(@"unnkotoittamododa=%@",newStr);//このstringをアレイに入れる
            [_proArray addObject:newStr];
            NSLog(@"sannkounishimasuka%@",_proArray);
            
            NSString *filePath1 = [NSString stringWithFormat:@"%@%@/1.png", stickerPath, path];
            NSData *data1 = [NSData dataWithContentsOfFile:filePath1];
            UIImage *image1 = [UIImage imageWithData:data1];
            [_imgArray addObject:image1];
            
            NSString *filePath2 = [NSString stringWithFormat:@"%@%@/0.png", stickerPath, path];
            NSData *data2 = [NSData dataWithContentsOfFile:filePath2];
            UIImage *image2 = [UIImage imageWithData:data2];
            [_allimgArray addObject:image2];
        }
        
    }
       [_tableView reloadData];
    NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
}


@end
