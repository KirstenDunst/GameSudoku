//
//  ViewController.m
//  Sudoku
//
//  Created by CSX on 2017/4/11.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import "ViewController.h"
#import "SudoView.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createView];
}
- (void)createView{
    SudoView *sudoView = [[SudoView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width + 150)];
    [self.view addSubview:sudoView];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
