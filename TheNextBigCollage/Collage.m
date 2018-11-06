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
@dynamic images;
@dynamic textBoxes;

+ (Collage*)insertCollageWithName:(NSString*)name
            inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;
{
    Collage* collage = [NSEntityDescription insertNewObjectForEntityForName:@"Collage"
                                                     inManagedObjectContext:managedObjectContext];
    
    collage.dateCreated = [NSDate date];
    collage.dateModified = [NSDate date];
    
    // TODO: Set empty arrays for images and textboxes, textbox objects may not need to be persisted, but just included in a collage object that IS persisted.
    //collage.images = [NSMutableArray new];
    //collage.textBoxes = [NSMutableArray new];
    
    
    collage.favorite = FALSE;
    collage.name = name;
    
    return collage;
}

@end
