//
//  FMDBManager.h
//  MiyaFMDB
//
//  Created by miya on 2019/3/1.
//  Copyright © 2019年 miya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
NS_ASSUME_NONNULL_BEGIN

@interface FMDBManager : NSObject
@property(nonatomic,strong)FMDatabase * database;

+(FMDBManager *)shareFMDBManager;
//建表
+(void)creteTable;
//增
+(void)insertToTable:(NSString *)addName;
+(void)insertAll:(NSArray *)array;
//删
+(void)deleteToTable:(NSString *)key;
//改
+(void)updateToTable:(NSString *)key;
//查
+(NSArray *)selectALL;
+(BOOL)selectData:(NSString *)key;
@end
NS_ASSUME_NONNULL_END
