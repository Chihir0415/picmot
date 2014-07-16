//
//  DownloadViewController.m
//  picmot
//
//  Created by hayato on 7/15/14.
//  Copyright (c) 2014 Chihiro Murata. All rights reserved.
//

#import "DownloadViewController.h"

@interface DownloadViewController (){
    UITableView* _tableView;
    
}

@end

@implementation DownloadViewController

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
    self.navigationItem.title = [NSString stringWithFormat:@"スタンプ一覧"];

    
    //ユーザ名格納配列　初期化
    stArr = [[NSMutableArray alloc] init];
    stFile = [[NSMutableArray alloc] init];
    stZip = [[NSMutableArray alloc] init];
    stImage = [[NSMutableArray alloc] init];
    stcateImage = [[NSMutableArray alloc] init];
    
    //配列番号
    xml_index = 0;
    xml_indexzip = 0;
    xml_indexfile = 0;
    xml_indeximage = 0;
    xml_indexcateimage = 0;
    
    //NSURLSessionをインスタンス化
    NSURLSessionConfiguration *configration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // NSURLSessionConfigurationを指定して NSURLSession作成
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configration delegate:self delegateQueue:nil];
    
    //リクエスト作成
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://geechscamp.lovepop.jp/picmot/Stamps/feed.rss"]];
    
    // 先に作成したNSURLSessionに対して dataTaskWithRequest:メソッドを呼び出す
    dataTask = [session dataTaskWithRequest:request];
    
    // resumeで処理開始
    [dataTask resume];
    
    //loadingを表示するView(通信中にぐるぐる回るやつ)設定
    UIScreen *sc = [UIScreen mainScreen];
    uv_load = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sc.applicationFrame.size.width,
                                                       sc.applicationFrame.size.height)];
    uv_load.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1];
    
    //ぐるぐる回る
    aci_loading = [[UIActivityIndicatorView alloc] init];
    aci_loading.frame = CGRectMake(0, 0, sc.applicationFrame.size.width, sc.applicationFrame.size.height);
    aci_loading.center = uv_load.center;
    aci_loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    //loading表示
    [uv_load addSubview:aci_loading];
    [self.view addSubview:uv_load];
    [aci_loading startAnimating];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-74)];
    
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    [self.view addSubview:_tableView];
    
    _tableView.rowHeight = 80;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:uv_load];

}

// XMLの解析
-(void)parserDidStartDocument:(NSXMLParser *)parser {
    //解析中タグの初期化
    nowTagStr = @"";
    NSLog(@"start=%@",nowTagStr);
    
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    //開始タグがtitleの場合
    if ([elementName isEqualToString:@"stampname"]) {
        //解析中タグの設定
        nowTagStr = [NSString stringWithString:elementName];
        NSLog(@"md=%@",nowTagStr);
        
        //テキストバッファの初期化
        txtBuffer = @"";
        NSLog(@"txtstart=%@",txtBuffer);
        
    } else if ([elementName isEqualToString:@"zip"]){
        nowTagStr = [NSString stringWithString:elementName];
        NSLog(@"md=%@",nowTagStr);
        
        //テキストバッファの初期化
        txtBuffer = @"";
    } else if ([elementName isEqualToString:@"image"]){
        nowTagStr = [NSString stringWithString:elementName];
        NSLog(@"md=%@",nowTagStr);
        
        //テキストバッファの初期化
        txtBuffer = @"";
    } else if ([elementName isEqualToString:@"filename"]){
        nowTagStr = [NSString stringWithString:elementName];
        NSLog(@"md=%@",nowTagStr);
        
        //テキストバッファの初期化
        txtBuffer = @"";
    } else if ([elementName isEqualToString:@"imagecate"]){
        nowTagStr = [NSString stringWithString:elementName];
        NSLog(@"md=%@",nowTagStr);
        
        //テキストバッファの初期化
        txtBuffer = @"";
    }
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    //解析中のタグがtitleの場合
    if ([nowTagStr isEqualToString:@"stampname"]) {
        //テキストバッファに文字を追加する
        txtBuffer = [txtBuffer stringByAppendingString:string];
        NSLog(@"txtmd=%@",nowTagStr);
        
    } else if ([nowTagStr isEqualToString:@"zip"]){
        txtBuffer = [txtBuffer stringByAppendingString:string];
    } else if ([nowTagStr isEqualToString:@"image"]){
        txtBuffer = [txtBuffer stringByAppendingString:string];
    } else if ([nowTagStr isEqualToString:@"filename"]){
        txtBuffer = [txtBuffer stringByAppendingString:string];
    }else if ([nowTagStr isEqualToString:@"imagecate"]){
        txtBuffer = [txtBuffer stringByAppendingString:string];
    }
    NSLog(@"4");
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    //終了タグがtitleの場合
    if ([elementName isEqualToString:@"stampname"]) {
        NSString *xml_name = txtBuffer;
        NSLog(@"efgh%@",xml_name);
        
        //userArrにユーザー名を格納
        [stArr insertObject:xml_name atIndex:xml_index];
        
        xml_index++;
        NSLog(@"5");
        
    } else if ([elementName isEqualToString:@"zip"]) {
        NSString *xml_name = txtBuffer;
        NSLog(@"efgh%@",xml_name);
        
        //userArrにユーザー名を格納
        [stZip insertObject:xml_name atIndex:xml_indexzip];
        
        xml_indexzip++;
    } else if ([elementName isEqualToString:@"image"]){
        NSString *xml_name = txtBuffer;
        NSLog(@"efgh%@",xml_name);
        
        //userArrにユーザー名を格納
        [stImage insertObject:xml_name atIndex:xml_indeximage];
        
        xml_indeximage++;
    } else if ([elementName isEqualToString:@"filename"]){
        NSString *xml_name = txtBuffer;
        NSLog(@"efgh%@",xml_name);
        
        //userArrにユーザー名を格納
        [stFile insertObject:xml_name atIndex:xml_indexfile];
        
        xml_indexfile++;
    } else if ([elementName isEqualToString:@"imagecate"]){
        NSString *xml_name = txtBuffer;
        NSLog(@"efgh%@",xml_name);
        
        //userArrにユーザー名を格納
        [stcateImage insertObject:xml_name atIndex:xml_indexcateimage];
        
        xml_indexcateimage++;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //section数
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // cell数
    return [stArr count];
    NSLog(@"start=%lu",(unsigned long)stArr.count);
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    return @"List";
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIndetifier = @"Cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"a"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndetifier];
        
    }
    
    // indexPathよりrowを取得し、rowをもとにuserArr配列から該当するユーザー名を取得
    cell.textLabel.text = [stArr objectAtIndex:indexPath.row];
    NSLog(@"test=%@",cell.textLabel.text);
    
    NSString* cate = [stcateImage objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:cate];
    NSData *data1 = [NSData dataWithContentsOfURL:url];
    NSLog(@"uooooooo=%@",data1);
    UIImage *image1 = [UIImage imageWithData:data1];
    cell.imageView.image = image1;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"tap = %ld",(long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除をします。
    DownloadpageViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DownloadpageViewController"];
    
    dvc.pcTitle = [stArr objectAtIndex:indexPath.row];
    dvc.pcFile = [stFile objectAtIndex:indexPath.row];
    dvc.pcZip = [stZip objectAtIndex:indexPath.row];
    dvc.pcImage = [stImage objectAtIndex:indexPath.row];
    dvc.pccateImage = [stcateImage objectAtIndex:indexPath.row];

    
    [[self navigationController]pushViewController:dvc animated:YES];
}

// データ受信時
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    stData = [[NSMutableData alloc]init];
    [stData appendData:data];
    NSLog(@"stData=%@",stData);
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        NSString *messageStr =@"internet error";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"error" message:messageStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];

    }else{
        NSString *str = [[NSString alloc]initWithData:stData encoding:NSShiftJISStringEncoding];
        NSLog(@"abc%@",str);
        //③データ受信が完了した時
        
        //受信データを文字列として確認
        
        //xmlパーサー生成
        NSXMLParser *myParser = [[NSXMLParser alloc] initWithData:stData];
        myParser.delegate = self;
        
        //xml解析開始
        [myParser parse];
        
        //tableviewを再描画
        //ここが重要！(tableを再描画しないとxmlのデータが反映されない)
        [_tableView reloadData];
        uv_load.hidden = YES;
        [aci_loading stopAnimating];
        
        //Loading非表示
        NSLog(@"hidden");
    }
    
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
