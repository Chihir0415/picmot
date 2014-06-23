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
}

@end

@implementation MotTableViewController

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
    
    _tableview.dataSource = self;
    _tableview.delegate = self;
    
    //名前を持った配列を用意する
    _proArray = @[@"Life",@"Love",@"Work",@"Funny",@"Dreams",@"friendship",@"Proverbs",@"For Ladies",@"From Disney"];
    //10番目に@"My favorite!"を入れこむ
    
    self.tableview.rowHeight = 45;
   
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //定数でCellを用意
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_proArray[indexPath.row]];
    cell.textLabel.textColor = [UIColor redColor];
    cell.textLabel.textAlignment = UITextBorderStyleLine;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"tap %d",indexPath.row);
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
    MotDetailViewController *mdvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MotDetailViewController"];
    
    //strプロパティにデータを渡す
    mdvc.str = _proArray[indexPath.row];
    
    // TODO: indexPath.rowをiに渡す
    mdvc.i = indexPath.row;
    
    
    //NavigationControllerを使ってpushで遷移
    [[self navigationController] pushViewController:mdvc animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touchBegan = [touches anyObject];
    _tBegan = [ touchBegan locationInView: self.view ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}
@end
