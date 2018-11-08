//
//  Settings.h
//  TheNextBigCollage
//
//  Created by Marlene Maier on 11/8/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Settings : NSObject

+ (NSSortDescriptor*)collageSortDescriptor;
+ (void)setCollageSortDescriptorWithKey:(NSString*) key;
+ (NSArray*)collageSortDescriptorOptions;

@end

NS_ASSUME_NONNULL_END
