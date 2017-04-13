//
//  SudoModel.m
//  Sudoku
//
//  Created by CSX on 2017/4/11.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import "SudoModel.h"
#import <math.h>

@implementation SudoModel

//+ (void)isSatisfyWithDataArr:(NSMutableArray *)dataArr WithIndex:(int)index AndTitle:(NSString *)title WithBlock:(void(^)(BOOL isSatisfy, NSArray *errIndexArr))block{
//    return [[self alloc]isSatisfyWithDataArr:dataArr WithIndex:index AndTitle:title WithBlock:^(BOOL isSatisfy, NSArray *errIndexArr) {
//        if (block) {
//            block(isSatisfy,errIndexArr);
//        }
//    }];
//}

- (void)isSatisfyWithDataArr:(NSMutableArray *)dataArr WithIndex:(int)index AndTitle:(NSString *)title WithBlock:(void(^)(BOOL isSatisfy, NSArray *errIndexArr))block{
    if (!(title.length>0)) {
        return;
    }
    NSMutableArray *tempArr = [NSMutableArray array];
    static BOOL isSatis;
    isSatis = YES;
    NSArray *hoArr = [self arrayWithDataArr:dataArr AndIndexArr:[self arrayWithHorizontalWithIndex:index andDataArr:dataArr]];
    NSArray *veArr = [self arrayWithDataArr:dataArr AndIndexArr:[self arrayWithVerticalWithIndex:index andDataArr:dataArr]];
    NSArray *cellArr = [self arrayWithDataArr:dataArr AndIndexArr:[self arrayWithCellArrWithIndex:index andDataArr:dataArr]];
    
    if ([hoArr containsObject:title]) {
        isSatis = NO;
        [tempArr addObjectsFromArray:[self arrayWithHorizontalWithIndex:index andDataArr:dataArr]];
    }
    if ([veArr containsObject:title]){
        isSatis = NO;
        [tempArr addObjectsFromArray:[self arrayWithVerticalWithIndex:index andDataArr:dataArr]];
    }
    if ([cellArr containsObject:title]){
        isSatis = NO;
        [tempArr addObjectsFromArray:[self arrayWithCellArrWithIndex:index andDataArr:dataArr]];
    }
    if (block) {
        block(isSatis,tempArr);
    }
}

- (NSArray *)arrayWithDataArr:(NSArray *)dataArr AndIndexArr:(NSArray *)indeArr{
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSNumber *index in indeArr) {
        int indexInt = [index intValue];
        [tempArr addObject:dataArr[indexInt]];
    }
    return tempArr;
}

//对应横向数组
- (NSArray *)arrayWithHorizontalWithIndex:(int)index andDataArr:(NSMutableArray *)dataArr{
    NSMutableArray *tempArr = [NSMutableArray array];
    int count = sqrt(dataArr.count);
    int Hocount = index/count;
    for (int i = 0; i<dataArr.count; i++) {
        if (i/count == Hocount) {
            [tempArr addObject:[NSNumber numberWithInt:i]];
        }
    }
    return tempArr;
}

//对应纵向数组
- (NSArray *)arrayWithVerticalWithIndex:(int)index andDataArr:(NSMutableArray *)dataArr{
    NSMutableArray *tempArr = [NSMutableArray array];
    int count = sqrt(dataArr.count);
    int Vecount = index%count;
    for (int i = 0; i<dataArr.count; i++) {
        if (i%count == Vecount) {
            [tempArr addObject:[NSNumber numberWithInt:i]];
        }
    }
    return tempArr;
}

//对应小元素的数组
- (NSArray *)arrayWithCellArrWithIndex:(int)index andDataArr:(NSMutableArray *)dataArr{
    int count = sqrt(dataArr.count);
    int number = sqrt(count);
    int VerticalNumber = index/count/number;
    int HorizontalNumber = index%count/number;
    NSMutableArray *tempArr = [self divideWithDagtaArr:dataArr][VerticalNumber*number+HorizontalNumber];
    return tempArr;
}

//化分对应个数的小数组
- (NSArray *)divideWithDagtaArr:(NSMutableArray *)dataArr{
    NSMutableArray *DTArr = [NSMutableArray array];
    int count = sqrt(dataArr.count);
    int number = sqrt(count);
    for (int i = 0; i< count; i++) {
        NSMutableArray *tempArr = [NSMutableArray array];
        //3次方
        int gradeY = number*number*number*(i/number);
        int gradeX = (i%number)*number;
        for (int j = 0 ; j < number; j++) {
            int sted = number*number;
            for (int k = 0; k < number; k++) {
                [tempArr addObject:[NSNumber numberWithInt:(gradeY+gradeX+j*sted+k)]];
            }
        }
        [DTArr addObject:tempArr];
    }
    return DTArr;
}


- (NSMutableArray *)generateRandomSudo{
    NSMutableArray *sudoDataArr = [NSMutableArray array];
    //母矩阵
    NSArray *sudoArr = @[@"4",@"3",@"2",@"8",@"7",@"9",@"6",@"1",@"5",@"6",@"8",@"7",@"2",@"1",@"5",@"4",@"3",@"9",@"1",@"5",@"9",@"3",@"4",@"6",@"7",@"2",@"8",@"5",@"9",@"1",@"4",@"8",@"7",@"2",@"6",@"3",@"3",@"6",@"8",@"1",@"9",@"2",@"5",@"7",@"4",@"7",@"2",@"4",@"6",@"5",@"3",@"8",@"9",@"1",@"8",@"4",@"3",@"7",@"6",@"1",@"9",@"5",@"2",@"2",@"7",@"5",@"9",@"3",@"8",@"1",@"4",@"6",@"9",@"1",@"6",@"5",@"2",@"4",@"3",@"8",@"7"].copy;
    NSMutableArray *termArr = [NSMutableArray array];
    for (int i = 0; i<9; i++) {
        NSString *til = [self titleWithArrContent:termArr];
        [termArr addObject:til];
    }
    
    //调换序列
    for (int i = 0; i<sudoArr.count; i++) {
        NSString *te_Str = [self changeTitleWithArr:termArr andTitle:sudoArr[i]];
        [sudoDataArr addObject:te_Str];
    }
    return sudoDataArr;
}

//递归生成
- (NSString *)titleWithArrContent:(NSMutableArray *)dataArr{
    static NSString *title;
    title = [NSString stringWithFormat:@"%d",arc4random()%9+1];
    if (![dataArr containsObject:title]) {
        return title;
    }else{
        return [self titleWithArrContent:dataArr];
    }
}
//能够生成362880个不同的随机矩阵 (9的阶乘)
- (NSString *)changeTitleWithArr:(NSMutableArray *)tempArr andTitle:(NSString *)tile{
    NSArray *t_Arr = [NSArray arrayWithArray:tempArr];
    static NSString *title;
    for (int i = 0; i<tempArr.count; i++) {
        if ([tempArr[i] isEqualToString:tile]) {
            if (i == tempArr.count-1) {
                title = t_Arr[0];
            }else{
                title = t_Arr[i+1];
            }
        }else{
            continue;
        }
    }
    return title;
}
@end
