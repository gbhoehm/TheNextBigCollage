//
//  TextBox+CoreDataClass.h
//  TheNextBigCollage
//
//  Created by Jonathan Grant on 11/7/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Collage;

NS_ASSUME_NONNULL_BEGIN

@interface TextBox : NSManagedObject

@property (strong, nonatomic) NSNumber *fontSize;
@property (strong, nonatomic) NSNumber *locationX;
@property (strong, nonatomic) NSNumber *locationY;
@property (strong, nonatomic) NSNumber *rotation;
@property (strong, nonatomic) NSNumber *size;
@property (strong, nonatomic) NSString *text;
@property (nullable, nonatomic, retain) Collage *collage;

@end

NS_ASSUME_NONNULL_END
