//
//  SelectedCollageViewController.m
//  TheNextBigCollage
//
//  Created by Marlene Maier on 11/12/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//

#import "SelectedCollageViewController.h"
#import "CollageViewController.h"
#import <CoreData/CoreData.h>
#import "Collage.h"

@interface SelectedCollageViewController ()

@end

@implementation SelectedCollageViewController

@synthesize collage;
@synthesize managedObjectContext;
@synthesize editMode;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CollageViewController *destinationVC = [segue destinationViewController];
    
    if ([[segue identifier] isEqualToString:@"EditCollage"])
    {
        // Get the selected collage, and set it as the collageViewController's collage.
        [destinationVC setCollage:collage];
        [destinationVC setManagedObjectContext:self.managedObjectContext];
        [destinationVC setEditMode:YES];
        
    }
    else if ([[segue identifier] isEqualToString:@"DeleteSegue"])
    {
        [self.managedObjectContext deleteObject:self.collage];
    }
}

@end
