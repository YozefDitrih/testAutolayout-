//
//  DataBase.m
//  testAutolayout
//
//  Created by Антон Погремушкин on 11.02.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

#import "DataBase.h"
#import <FMDB.h>


@implementation DataBase
{
    FMDatabase *db;
}

+(instancetype)shared{
    static id _singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[self alloc] init];
    });
    return _singleton;
}

- (id)init{
    self = [super init];
    if (self){
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [docDir stringByAppendingPathComponent:@"db.sqlite"];
        db = [[FMDatabase alloc] initWithPath:path];
        NSLog(@"%@", path); // -----------------------------------------------
        [db open];
    }
    return self;
}

-(void)dealloc{
    [db close];
}

#pragma mark - set

- (void)deleteInDataBase:(Link *)link{
    [db executeUpdate:@"DELETE FROM Zakladki WHERE name = (?)", link.name];
}

- (void)addInDataBase:(Link *)link{
    [db executeUpdate:@"insert into Zakladki (name, thumb_url) values (?, ?)", link.name, link.URL];
}

#pragma mark - get
-(NSArray *)getLinksArray{
    
    FMResultSet *set = [db executeQuery:@"select * from Zakladki"];
    NSMutableArray *arr = [NSMutableArray new];
    while (set.next){
        [arr addObject:[[Link alloc] initWithFMDBSet:set]];
    }
         return arr;
}


#pragma mark - Migrations
-(void)migrateDataBase{
    
    NSInteger version = 0;
    FMResultSet *versionSet = [db executeQuery:@"PRAGMA user_version;"];
    if (versionSet.next){
        version = [versionSet longForColumnIndex:0];
    }
    // сохраняем текущую версию базы данных
    
    if (version == 0){
    NSString *sql = @"create table IF NOT EXISTS Zakladki (id integer primary key autoincrement, name text, thumb_url text);";
    if([db executeUpdate:sql]){
        NSLog(@"%@", @"success");
    }else{
            NSLog(@"%@", @"fail");
        }
    
    NSArray *objectsArray = [self initialData];
    for (NSDictionary *dic in objectsArray){
        [db executeUpdate:@"insert into Zakladki (name, thumb_url) values (:title, :thumb);" withParameterDictionary:dic];
    }
}
    
    NSInteger newVersion = 1;
    NSString *sql = [NSString stringWithFormat:@"PRAGMA user_version=%d;", newVersion];
    [db executeUpdate:sql];
    
}

-(NSArray *)initialData{
    NSString *jsonStr = @"[{\"title\":\"google\",\"thumb\":\"https://google.com\"}, {\"title\":\"yandex\",\"thumb\":\"https://yandex.ru\"}, {\"title\":\"apple\",\"thumb\":\"https://apple.com/ru\"}, {\"title\":\"vk\",\"thumb\":\"https://vk.com\"}]";
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]
                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers
                                                     error:nil];
    return arr;
    
}

@end
