//
//  Image+CoreDataClass.m
//  TheNextBigCollage
//
//  Created by Jonathan Grant on 10/31/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//
//

#import "Image.h"

@implementation Image

@synthesize uniqueId;
@synthesize locationX;
@synthesize locationY;
@synthesize rotation;
@synthesize size;
@synthesize rawImage;
@dynamic collage;

+(Image*) makeNewPictureWithUniqueId:(NSNumber*) uniqueId
                            rawImage: (NSData*) rawImage
                    inManagedObjectContext:(NSManagedObjectContext*) managedObjectContext;
{
    Image *image = [NSEntityDescription insertNewObjectForEntityForName:@"Image"
                                                 inManagedObjectContext:managedObjectContext];
    
    image.rawImage = rawImage;
    
    // Generates a random unique ID.
    // ex. "E621E1F8-C36C-495A-93FC-0C247A3E6E5F"
    image.uniqueId = [[NSUUID UUID] UUIDString];
    
    return image;
}

@end
