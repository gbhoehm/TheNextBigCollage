//
//  Header.h
//  TheNextBigCollage
//
//  Created by Jonathan Grant on 11/8/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-root-class"

NS_ASSUME_NONNULL_BEGIN

@interface Action

// "Translate", "scale," "rotate," etc.
@property (weak, nonatomic) NSString *action;

@property (weak, nonatomic) NSData *associatedImage;

// The value of change. If the image is rotated, then moveX, moveY, and scale = 0
// These values are kept so "undo" and "redo" buttons can undo/redo the correct amount.
@property (weak, nonatomic) NSNumber *moveX;
@property (weak, nonatomic) NSNumber *moveY;
@property (weak, nonatomic) NSNumber *scale;
@property (weak, nonatomic) NSNumber *rotate;

@end

NS_ASSUME_NONNULL_END
