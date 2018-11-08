//
//  UndoRedoStack.m
//  TheNextBigCollage
//
//  Created by Jonathan Grant on 11/7/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//

#import "UndoRedoStack.h"

@implementation UndoRedoStack

@synthesize actions;

-(void)pop;
{
    [[self actions] removeLastObject];
}

-(void)pushWithAction:(NSString *)action;
{
    [[self actions] addObject:action];
}

-(NSString *)peek;
{
    return [[self actions] lastObject];
}

@end
