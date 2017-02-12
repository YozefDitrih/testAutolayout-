//
//  Link.m
//  testAutolayout
//
//  Created by Антон Погремушкин on 10.02.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

#import "Link.h"

@implementation Link

+ (instancetype)linkWithUrlAndName:(NSString *)name andURL:(NSURL *)URL
{
    Link *link = [[Link alloc] init];
    link.URL = URL;
    link.name = name;
    link.linkId = (NSInteger *)rand();
    return link;
}

-(id)initWithFMDBSet:(FMResultSet *)set{
    self = [super init];
    if(self){
        _linkId = [set longForColumn:@"id"];
        _name = [set stringForColumn:@"name"];
        _URL = [NSURL URLWithString:[set stringForColumn:@"thumb_url"]];
    }
    return self;
}

@end
