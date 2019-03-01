//
//  FMDBManager.m
//  MiyaFMDB
//
//  Created by miya on 2019/3/1.
//  Copyright © 2019年 miya. All rights reserved.
//

#import "FMDBManager.h"
@implementation FMDBManager
+(FMDBManager *)shareFMDBManager{
    static FMDBManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class]alloc]init];
        NSString * path = [NSString stringWithFormat:@"%@/Library/Caches/tour.db",NSHomeDirectory()];
        manager.database = [FMDatabase databaseWithPath:path];
        NSLog(@"路径:%@",path);
    });
    if (manager.database.open == NO) {
        [manager.database open];
    }
    
    return manager;
    
}
//建表
+(void)creteTable{
    FMDBManager * manager = [FMDBManager shareFMDBManager];
    NSString * sql = @"create table if not exists okkkk(name text primary key)";
    BOOL result = [manager.database executeUpdate:sql];
    if (result) {
        NSLog(@"建表成功");
        
    }else{
        NSLog(@"建表失败");
    }

}
//增
+(void)insertToTable:(NSString *)addName{
    FMDBManager * manager = [FMDBManager shareFMDBManager];
    
    NSString *sql = @"insert into okkkk(name) values(?)";
    BOOL result = [manager.database executeUpdate:sql,addName];
    if (result) {
        NSLog(@"插入数据成功");
    }else{
        NSLog(@"插入失败");
    }
}
+(void)insertAll:(NSArray *)array{
    for (NSString * name in array) {
        [FMDBManager insertToTable:name];
    }
}
//删
+(void)deleteToTable:(NSString *)key{
    FMDBManager * manager = [FMDBManager shareFMDBManager];
    
    NSString * sql = @"delete from okkkk where name = ?";
    //从某张表中删除记录
    BOOL result = [manager.database executeUpdate:sql,key];
    
    if (result) {
        NSLog(@"删除记录成功");
    }
    else{
        NSLog(@"删除记录失败");
    }
}
//改
+(void)updateToTable:(NSString *)key{
    
}
//查
+(NSArray *)selectALL{
    FMDBManager * manager = [FMDBManager shareFMDBManager];
    
    NSString * sql = @"select * from okkkk";
    NSMutableArray * array = [[NSMutableArray alloc]init];
    
    //执行查询语句
    FMResultSet * set = [manager.database executeQuery:sql];
    while ([set next]) {
        //一条一条的读取数据
        //根据键名取值
        NSString * name = [set stringForColumn:@"name"];
        [array addObject:name];
    }
    return array;

}
+(BOOL)selectData:(NSString *)key{
    FMDBManager * manager = [FMDBManager shareFMDBManager];
    
    NSString * sql = @"select * from okkkk where name = ?";
    
    //执行语句
    FMResultSet * set = [manager.database executeQuery:sql,key];
    while ([set next]) {
        
        return YES;
    }
    return NO;
    

}
@end
