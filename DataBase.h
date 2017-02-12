//
//  DataBase.h
//  testAutolayout
//
//  Created by Антон Погремушкин on 11.02.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Link.h"

@interface DataBase : NSObject

+(instancetype)shared;
-(void)migrateDataBase;
-(NSMutableArray *)getLinksArray;
- (void)addInDataBase:(Link *)link;
- (void)deleteInDataBase:(Link *)link;

@end
