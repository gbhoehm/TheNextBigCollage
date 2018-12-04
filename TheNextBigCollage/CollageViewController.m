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
@property (nonatomic, assign) CGPoint startPan;
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
    
    self.scrollView.contentSize = CGSizeMake(100,100);
    
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
- (IBAction)userPinch:(UIPinchGestureRecognizer *)sender {
    if([sender state] == UIGestureRecognizerStateEnded){
        
        CGFloat scale = sender.scale;
        //CGRect oldBounds = self.scrollView.subviews.lastObject.bounds;
        //[self.scrollView.subviews.lastObject setFrame:CGRectMake(oldBounds.size.width + scale,
                                                                // oldBounds.size.height + scale,300,300)];
        UIImageView *image = self.scrollView.subviews.lastObject;
        //CGAffineTransform current = image.transform; use me for undo button
        image.transform = CGAffineTransformScale(image.transform, scale, scale);
        self.scrollView.subviews.lastObject.removeFromSuperview;
        [self.scrollView addSubview: image];
        
        sender.scale = 1;
    }
    
}

- (IBAction)dragImage:(UIPanGestureRecognizer *)sender
{
    if ([sender state] == UIGestureRecognizerStateBegan)
    {
        [self setStartPan:[sender locationInView:[self scrollView]]];
    }
    if ([sender state] == UIGestureRecognizerStateEnded)
    {
        CGPoint end = [sender locationInView:[self scrollView]];
        CGPoint scale = CGPointMake(end.x - self.startPan.x, end.y - self.startPan.y);
        self.scrollView.subviews.lastObject.transform = CGAffineTransformMakeTranslation(scale.x, scale.y);
      
    }
}

- (IBAction)userRotate:(UIRotationGestureRecognizer *)sender {
    self.scrollView.subviews.lastObject.transform = CGAffineTransformMakeRotation(sender.rotation);
}

- (IBAction)selectImage:(UIButton *)sender {
    
    self.scrollView.subviews.lastObject.layer.borderColor = UIColor.blackColor.CGColor;
    self.scrollView.subviews.lastObject.layer.borderWidth = 2;

    
}


// Get rid of the camera roll view after an image has been selected.
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];

    NSData *imageData = UIImagePNGRepresentation(image);
    Image *newImage = [Image insertNewRawImage:imageData inManagedObjectContext:[self managedObjectContext]];
    [[self imagesTemp] addObject:newImage];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    [imageView setFrame:CGRectMake(100, 100, 100, 100)];
    
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
