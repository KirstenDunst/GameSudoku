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

+ (void)isSatisfyWithDataArr:(NSMutableArray *)dataArr WithIndex:(int)index AndTitle:(NSString *)title WithBlock:(void(^)(BOOL isSatisfy, NSArray *errIndexArr))block{
    return [[self alloc]isSatisfyWithDataArr:dataArr WithIndex:index AndTitle:title WithBlock:^(BOOL isSatisfy, NSArray *errIndexArr) {
        if (block) {
            block(isSatisfy,errIndexArr);
        }
    }];
}

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
+ (BOOL)isSatisfyWithDataArr:(NSMutableArray *)dataArr WithIndex:(int)index AndTitle:(NSString *)title{
    return [[self alloc]isSatisfyWithDataArr:dataArr WithIndex:index AndTitle:title];
}
- (BOOL)isSatisfyWithDataArr:(NSMutableArray *)dataArr WithIndex:(int)index AndTitle:(NSString *)title{
    static BOOL isSatis;
    NSArray *hoArr = [self arrayWithDataArr:dataArr AndIndexArr:[self arrayWithHorizontalWithIndex:index andDataArr:dataArr]];
    NSArray *veArr = [self arrayWithDataArr:dataArr AndIndexArr:[self arrayWithVerticalWithIndex:index andDataArr:dataArr]];
    NSArray *cellArr = [self arrayWithDataArr:dataArr AndIndexArr:[self arrayWithCellArrWithIndex:index andDataArr:dataArr]];
    if ([hoArr containsObject:title]||[veArr containsObject:title]||[cellArr containsObject:title]) {
        isSatis = NO;
    }else{
        isSatis = YES;
    }
    return isSatis;
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

@end
