//
//  ViewController.m
//  TheNextBigCollage
//
//  Created by Gage Boehm_lab on 10/11/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import <CoreData/CoreData.h>
#import "CollageViewController.h"
#import "Collage.h"
#import "Settings.h"

@interface ViewController ()
{
    NSArray *titles;
}

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *cachedCollages;
@property (nonatomic) BOOL needToFetchCollages;

@end

@implementation ViewController

@synthesize titles;
@synthesize managedObjectContext;

// UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    Collage* collageForCell = [[self collages] objectAtIndex:[indexPath indexAtPosition:1]];
    
    [cell.cellTitle setText:[collageForCell name]];
    //[cell.images image:[collageForCell ]]
    //cell.images.image = [UIImage imageNamed:titles[indexPath.row]];
    //cell.cellTitle.text = titles[indexPath.row];
    return cell;
}

// UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSArray*)collages {
    
    if (![self needToFetchCollages])
    {
        return [self cachedCollages];
    } else {
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Collage"];
    
    NSSortDescriptor *collageSortDescriptor = [Settings collageSortDescriptor];
    
        NSArray* collages = [[self.managedObjectContext executeFetchRequest:request error:NULL] sortedArrayUsingDescriptors:@[collageSortDescriptor]];
    
    [self setCachedCollages:collages];
    [self setNeedToFetchCollages:NO];
    
    return collages;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self collages] count];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //titles = @[@"Collage1", @"Collage2", @"Collage3"];
    [self setNeedToFetchCollages:YES];
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwind:(UIStoryboardSegue *)segue{}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"AddCollage"])
    {
        CollageViewController *collageViewController = [segue destinationViewController];
        
        collageViewController.collage = [Collage insertCollageWithName:@"MyCollageName"
                                                inManagedObjectContext:[self managedObjectContext]];
    }
    else if ([[segue identifier] isEqualToString:@"EditCollage"])
    {
        // Get the selected collage, and set it as the collageViewController's collage.
    }
}

@end
