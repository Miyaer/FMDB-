//
//  ViewController.m
//  MiyaFMDB
//
//  Created by miya on 2019/3/1.
//  Copyright © 2019年 miya. All rights reserved.
//

#import "ViewController.h"
#import "FMDBManager.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * TableView;
@property(nonatomic,strong)NSMutableArray * array;
@property(nonatomic,strong)UITextField * textField;
@property(nonatomic,strong)UIButton * btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [FMDBManager shareFMDBManager];
    [FMDBManager creteTable];
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.TableView];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.textField];
    // Do any additional setup after loading the view, typically from a nib.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, cell.layer.frame.size.width-40, cell.layer.frame.size.height)];
    label.text = self.array[indexPath.row];
    [cell addSubview:label];
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
                    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [FMDBManager deleteToTable:self.array[indexPath.row]];
        [self.array removeObjectAtIndex:indexPath.row];
        [self.TableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}
-(void)click:(UIButton *)btn{
    [FMDBManager insertToTable:self.textField.text];
    [self.array removeAllObjects];
    self.array = [[NSMutableArray alloc]initWithArray:[FMDBManager selectALL]];
    [self.TableView reloadData];
}
-(UITableView *)TableView{
    if (!_TableView) {
        _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, self.view.frame.size.height-320) style:UITableViewStylePlain];
        _TableView.delegate = self;
        _TableView.dataSource = self;
    }
    return _TableView;
}
-(NSMutableArray *)array{
    if (!_array) {
        _array = [[NSMutableArray alloc]init];
        _array = [[NSMutableArray alloc]initWithArray:[FMDBManager selectALL]];
    }
    return _array;
}
-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(25, 100, self.view.frame.size.width-50, 30)];;
        _textField.placeholder = @"请输入数据";
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.clearsOnBeginEditing = YES;
        _textField.backgroundColor = [UIColor whiteColor];
    }
    return _textField;
}
-(UIButton *)btn{
    if (!_btn) {
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30, 120, 60, 120)];
        [_btn setTitle:@"提交" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
@end
