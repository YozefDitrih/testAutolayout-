//
//  Link.h
//  testAutolayout
//
//  Created by Антон Погремушкин on 10.02.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface Link : NSObject

@property (nonatomic, readwrite) NSInteger *linkId;
@property (nonatomic, strong) NSString *name;
@property (copy, nonatomic) NSURL *URL;

+ (instancetype)linkWithUrlAndName:(NSString *)name andURL:(NSURL *)URL;
- (id)initWithFMDBSet:(FMResultSet *)set;

@end
