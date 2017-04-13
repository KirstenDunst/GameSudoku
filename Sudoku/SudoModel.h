//
//  SudoModel.h
//  Sudoku
//
//  Created by CSX on 2017/4/11.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SudoModel : NSObject

//+ (void)isSatisfyWithDataArr:(NSMutableArray *)dataArr WithIndex:(int)index AndTitle:(NSString *)title WithBlock:(void(^)(BOOL isSatisfy, NSArray *errIndexArr))block;
- (void)isSatisfyWithDataArr:(NSMutableArray *)dataArr WithIndex:(int)index AndTitle:(NSString *)title WithBlock:(void(^)(BOOL isSatisfy, NSArray *errIndexArr))block;


//生成随机
- (NSMutableArray *)generateRandomSudo;

@end
