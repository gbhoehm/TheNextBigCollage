//
//  Header.h
//  TheNextBigCollage
//
//  Created by Jonathan Grant on 11/7/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Action.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-root-class"

NS_ASSUME_NONNULL_BEGIN

@interface UndoRedoStack

@property NSMutableArray *actions;

-(void)pop;
-(void)pushWithAction:(Action*) action;
-(Action *)peek;
-(void)clear;

@end

NS_ASSUME_NONNULL_END
