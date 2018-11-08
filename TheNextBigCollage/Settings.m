//
//  Settings.m
//  TheNextBigCollage
//
//  Created by Marlene Maier on 11/8/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//

#import "Settings.h"

@implementation Settings

+ (NSSortDescriptor*)collageSortDescriptor
{
    NSString *key = [[NSUserDefaults standardUserDefaults] stringForKey:@"collageSortDescriptor"];
    if (![[Settings collageSortDescriptorOptions] containsObject:key])
    {
        // Set default to createdDate
        key = @"dateCreated";
        [Settings setCollageSortDescriptorWithKey:@"dateCreated"];
    }
    
    // Title is ascending order - the created and revised dates are descending order.
    BOOL ascending = !([key isEqualToString:@"name"]);
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
    
    return descriptor;
}

+ (void)setCollageSortDescriptorWithKey:(NSString*)key
{
    if ([[Settings collageSortDescriptorOptions] containsObject:key])
    {
        [[NSUserDefaults standardUserDefaults] setObject:key forKey:@"collageSortDescriptor"];
    }
    return;
}

+ (NSArray*)collageSortDescriptorOptions
{
    return @[@"dateCreated", @"dateModified", @"name"];
    //[NSDictionary dictionaryWithObjects:@[@"Last Revised First", @"Last Created First", @"Alphabetical by Title"]
    //                                   forKeys:@[@"revisedDate", @"createdDate", @"title"]];
}


@end
