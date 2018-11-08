//
//  CollageViewController.h
//  TheNextBigCollage
//
//  Created by Marcus Gubanyi on 10/11/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Collage.h"
#import "UndoRedoStack.h"
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollageViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstraint;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (strong, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (weak, nonatomic) UndoRedoStack *stack;

@property (strong, nonatomic) Collage *collage;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

NS_ASSUME_NONNULL_END
