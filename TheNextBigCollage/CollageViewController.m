//
//  CollageViewController.m
//  TheNextBigCollage
//
//  Created by Marcus Gubanyi on 10/11/18.
//  Copyright © 2018 Concordia Software Class. All rights reserved.
//

#import "CollageViewController.h"
#import "UndoRedoStack.h"
#import "AppDelegate.h"

@interface CollageViewController ()

@property (nonatomic) BOOL menuShowing;

@end

@implementation CollageViewController

@synthesize collage;
@synthesize stack;
@synthesize managedObjectContext;
@synthesize editMode;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuShowing = false;
    [[self collageName] setText:[[self collage] name]];
    //_menuView.layer.shadowOpacity = 1;
}

// Bring up the image picker view (built in view of photo gallery from Apple)
- (IBAction)addImageButton:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:NO completion:nil];
}

// Get rid of the camera roll view after an image has been selected.
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];

    self.imageView.image = image;
    
    [[[self collage] images] addObject:image];
    
    // TODO: add image object to collage object here?
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)menuBtn:(id)sender {
    if (self.menuShowing){
        _leadingConstraint.constant = -207;
        
        [UIView animateWithDuration: 0.3 animations: ^{
            [self.editView setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0]];
            [self.view layoutIfNeeded]; } ];
    }
    else {
        _leadingConstraint.constant = 0;
        [UIView animateWithDuration: 0.3 animations: ^{
            [self.editView setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7]];
            [self.view layoutIfNeeded]; } ];
        [self.view bringSubviewToFront:_menuView];
    }
    self.menuShowing = !self.menuShowing;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"save"]){
        [self saveCollage];
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] saveContext];
    }
    else if ([[segue identifier] isEqualToString:@"Cancel"])
    {
        if (self.editMode == NO)
        {
            [self.managedObjectContext deleteObject:collage];
        }
    }
}

- (void)saveCollage {
    [[self collage] setName:[[self collageName] text]];
}

-(IBAction)unwindToEdit:(UIStoryboardSegue *)segue{}

@end
