//
//  MotTableViewController.m
//  picmot
//
//  Created by Chihiro Murata on 2014/03/12.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import "MotTableViewController.h"

@interface MotTableViewController (){
    NSArray *_proArray;
    //NSInteger* category_number;
    NSArray* sectionList;
    NSString* sectionName;
}

@property (nonatomic, strong) NSArray *dataSourceFavorite;
@property (nonatomic, strong) NSArray *dataSourceCategory;

@end

@implementation MotTableViewController

@synthesize category_number;

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
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    // テーブルに表示したいデータソースをセット
    self.dataSourceFavorite = @[@"My Fovorite"];
    self.dataSourceCategory = @[@"Life", @"Love", @"Work", @"Funny", @"Dreams", @"friendship", @"Proverbs", @"For Ladies", @"From Disney"];
    
    // SectionNameを生成する
    sectionList = [NSArray arrayWithObjects:@"favoriteList", @"categoryList",nil];
    
    // BackButton
    UIBarButtonItem* menu = [[UIBarButtonItem alloc]
                              initWithTitle:@"Menu"
                              style:UIBarButtonItemStyleBordered
                              target:self
                              action:@selector(barbutton1:)];
    self.navigationItem.leftBarButtonItems = @[menu];
//
//    _tableview.dataSource = self;
//    _tableview.delegate = self;
//    
//    //名前を持った配列を用意する
//    _proArray = @[@"Life",@"Love",@"Work",@"Funny",@"Dreams",@"friendship",@"Proverbs",@"For Ladies",@"From Disney"];
//    //10番目に@"My favorite!"を入れこむ
//    
//    self.tableview.rowHeight = 45;
   
//    UIImage *back = [UIImage imageNamed:@"pic01.jpg"];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:back];
    
    UIImageView *backimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 586)];
    UIImage *image = [UIImage imageNamed:@"pic01.jpg"];
    backimage.contentMode = UIViewContentModeScaleToFill;
    [backimage setImage:image];
    [self.view addSubview:backimage];
    backimage.alpha = 0.35;
    
    _tableview.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    
}

-(void)barbutton1:(UIBarButtonItem *)menu{
    [self dismissViewControllerAnimated:YES completion: NULL];
    
}

// 指定されたセクションのセクション名を返す
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [sectionList objectAtIndex:section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger dataCount = 0;
    
    // テーブルに表示するデータ件数を返す
    switch (section) {
        case 0:
            dataCount = self.dataSourceFavorite.count;
            break;
        case 1:
            dataCount = self.dataSourceCategory.count;
            break;
        default:
            break;
    }
    return dataCount;
    
    //return 9;
    
}

// Sectionの数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"Cell";
    // 再利用できるセルがあれば再利用する
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        // 再利用できない場合は新規で作成
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.textAlignment = UITextBorderStyleLine;
    }
    
    switch (indexPath.section) {
        case 0:
        {
            sectionName = [sectionList objectAtIndex:indexPath.section];
            //NSLog(@"SectionName %@", sectionName);
            cell.textLabel.text = self.dataSourceFavorite[indexPath.row];
            
            // TODO: ここにfavarite中身処理
            
            
            
            break;
        }
        case 1:
            cell.textLabel.text = self.dataSourceCategory[indexPath.row];
            break;
        default:
            break;
    }
    
    return cell;
    
    //定数でCellを用意
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"%@",_proArray[indexPath.row]];
//    cell.textLabel.textColor = [UIColor redColor];
//    cell.textLabel.textAlignment = UITextBorderStyleLine;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.backgroundColor = [UIColor clearColor];
//    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"SectionName %@", sectionName);
    NSLog(@"今のSection %d",indexPath.section);
    //NSLog(@"Category %d",indexPath.row);
    
    // indexPath.sectionが 0 だったらfavoriteListを表示、indexPath.sectionが 1 だったらcaregoryListを表示する
    if (indexPath.section==0) {
        
        // UserDefaulにアクセス
        NSUserDefaults* favDefault = [NSUserDefaults standardUserDefaults];
        // UserDefaultから取ってきたデータをfavListに入れる
        NSArray* favList = [favDefault arrayForKey:@"favorite_key"];
        NSLog(@"%@", favList);
        [favDefault synchronize];
        [_tableview deselectRowAtIndexPath:indexPath animated:YES];
        FavoriteViewController* fdvc = [self.storyboard instantiateViewControllerWithIdentifier:@"FavoriteViewController"];
        fdvc.str = favList[indexPath.row];
        
        fdvc.i = indexPath.row;
        
        fdvc.category_number = self.category_number;
        
        
        
        
        
    } else {
        
    
    
    
    // 押されたCategoryをInteger型変数に代入
    category_number = indexPath.row;
    NSLog(@"カテゴリNo. %d" ,category_number);
    
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
    MotDetailViewController *mdvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MotDetailViewController"];
    
    //strプロパティにデータを渡す
    mdvc.str = _proArray[indexPath.row];
    
    // TODO: indexPath.rowをiに渡す
    mdvc.i = indexPath.row;
    
    mdvc.category_number = self.category_number;
    
    
    //NavigationControllerを使ってpushで遷移
    [[self navigationController] pushViewController:mdvc animated:YES];
    
    
    }
    
 }

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touchBegan = [touches anyObject];
    _tBegan = [touchBegan locationInView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}
@end
