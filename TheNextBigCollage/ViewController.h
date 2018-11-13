//
//  ViewController.h
//  TheNextBigCollage
//
//  Created by Gage Boehm_lab on 10/11/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) BOOL needToFetchCollages;
@property (weak, nonatomic) IBOutlet UICollectionView *collageCollectionView;
@property (nonatomic) BOOL editMode;

- (NSArray*)collages;

@end
