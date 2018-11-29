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
#import "Image.h"

@interface CollageViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableOrderedSet *imagesTemp;

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
    self.imagesTemp = [NSMutableOrderedSet new];
    
    if ([self editMode] == YES) {
        //Add images from collage to the temporary array of images and populate them in the scroll view
        self.imagesTemp = self.collage.images;
        for (int i = 0; i < [[self imagesTemp] count]; i++) {
            Image *tempImage = [[self imagesTemp] objectAtIndex:i];
            UIImage *image = [UIImage imageWithData:[tempImage rawImage]];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            [imageView setFrame:CGRectMake(50, 50, 50, 50)];
            [self.scrollView addSubview: imageView];
        }
    }
    
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
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.scrollView setContentSize:CGSizeMake(50, 50)];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    Image *newImage = [Image insertNewRawImage:imageData inManagedObjectContext:[self managedObjectContext]];
    [[self imagesTemp] addObject:newImage];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    [imageView setFrame:CGRectMake(50, 50, 50, 50)];

    
    [self.scrollView addSubview: imageView];
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
            [self.managedObjectContext deleteObject:self.collage];
        }
    }
}

- (void)saveCollage {
    [[self collage] setName:[[self collageName] text]];
    [[self collage] setDateModified:[NSDate date]];
    
    //Saves images of the temporary array to the array of the collage
    [[self collage] setImages:[self imagesTemp]];
}

-(IBAction)unwindToEdit:(UIStoryboardSegue *)segue{}

@end
