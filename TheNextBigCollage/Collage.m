//
//  Collage.m
//  TheNextBigCollage
//
//  Created by Jonathan Grant on 10/31/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//
//

#import "Collage.h"

@implementation Collage

@synthesize dateCreated;
@synthesize dateModified;
@synthesize favorite;
@synthesize name;

+ (Collage*)insertCollageWithName:(NSString*)name
            inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;
{
    Collage* collage = [NSEntityDescription insertNewObjectForEntityForName:@"Collage"
                                                     inManagedObjectContext:managedObjectContext];
    
    collage.dateCreated = [NSDate date];
    collage.dateModified = [NSDate date];
    collage.favorite = FALSE;
    collage.name = name;
    
    return collage;
}

@end
