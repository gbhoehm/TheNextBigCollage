//
//  Collage.h
//  TheNextBigCollage
//
//  Created by Jonathan Grant on 10/31/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//
//

#import <CoreData/CoreData.h>

@class Image, TextBox;

NS_ASSUME_NONNULL_BEGIN

@interface Collage : NSManagedObject

@property (strong, nonatomic) NSDate *dateCreated;
@property (strong, nonatomic) NSDate *dateModified;
@property (nonatomic) bool favorite;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableOrderedSet *images;
@property (strong, nonatomic) NSMutableOrderedSet *textBoxes;

+(instancetype)insertCollageWithName:(NSString*) name
               inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;

@end

NS_ASSUME_NONNULL_END
