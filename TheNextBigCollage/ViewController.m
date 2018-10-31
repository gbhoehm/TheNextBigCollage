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

@interface ViewController ()
{
    NSArray *titles;
}

@property (nonatomic, strong) NSArray *titles;

@end

@implementation ViewController

@synthesize titles;

// UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.images.image = [UIImage imageNamed:titles[indexPath.row]];
    cell.cellTitle.text = titles[indexPath.row];
    return cell;
}

// UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    titles = @[@"Collage1", @"Collage2", @"Collage3"];
    
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
        id collage = [NSEntityDescription insertNewObjectForEntityForName:@"Collage"
                                                   inManagedObjectContext:self.managedObjectContext];
        //collage.dateCreated = [NSDate date];
        //collage.
        [(CollageViewController*)[segue sourceViewController] setCollage:collage];
    }
}

@end
