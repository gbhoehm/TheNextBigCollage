//
//  Header.h
//  TheNextBigCollage
//
//  Created by Jonathan Grant on 11/7/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-root-class"

NS_ASSUME_NONNULL_BEGIN

@interface UndoRedoStack

@property NSMutableArray *actions;

-(void)pop;
-(void)pushWithAction:(NSString*) action;
-(NSString *)peek;

@end

NS_ASSUME_NONNULL_END
