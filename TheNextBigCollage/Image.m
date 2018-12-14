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

@dynamic uniqueId;
@dynamic locationX;
@dynamic locationY;
@dynamic rotation;
@dynamic sizeH;
@dynamic sizeW;
@dynamic rawImage;
@dynamic collage;

+(Image*) insertNewRawImage: (NSData*) rawImage
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
