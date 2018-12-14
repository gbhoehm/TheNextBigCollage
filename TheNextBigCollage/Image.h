//
//  Image+CoreDataClass.h
//  TheNextBigCollage
//
//  Created by Jonathan Grant on 10/31/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//
//

#import <CoreData/CoreData.h>

@class Collage, RawImage;

NS_ASSUME_NONNULL_BEGIN

@interface Image : NSManagedObject

@property (strong, nonatomic) NSString *uniqueId;
@property (strong, nonatomic) NSNumber *locationX;
@property (strong, nonatomic) NSNumber *locationY;
@property (strong, nonatomic) NSNumber *rotation;
@property (strong, nonatomic) NSNumber *sizeH;
@property (strong, nonatomic) NSNumber *sizeW;
@property (strong, nonatomic) NSData *rawImage;
@property (strong, nonatomic) Collage *collage;

+(instancetype) insertNewRawImage:(NSData*) rawImage
                    inManagedObjectContext:(NSManagedObjectContext*) managedObjectContext;

@end

NS_ASSUME_NONNULL_END
