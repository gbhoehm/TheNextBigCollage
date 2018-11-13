//
//  SelectedCollageViewController.h
//  TheNextBigCollage
//
//  Created by Marlene Maier on 11/12/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Collage.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectedCollageViewController : UIViewController

@property (strong, nonatomic) Collage *collage;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) BOOL editMode;

@end

NS_ASSUME_NONNULL_END
