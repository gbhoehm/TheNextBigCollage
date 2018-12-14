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
@property (nonatomic) int imageNum;
@property (nonatomic) int imageSelected;
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
    
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3,
                                             [UIScreen mainScreen].bounds.size.height * (3/2));
    self.imageSelected = -1;
    self.imageNum = 2;// acounting for two extra unknown imageviews
    
    if ([self editMode] == YES) {
        //Add images from collage to the temporary array of images and populate them in the scroll view
        self.imagesTemp = self.collage.images;
        for (int i = 0; i < [[self imagesTemp] count]; i++) {
            Image *tempImage = [[self imagesTemp] objectAtIndex:i];
            UIImage *image = [UIImage imageWithData:[tempImage rawImage]];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            [imageView setFrame:CGRectMake([tempImage.locationX floatValue], [tempImage.locationY floatValue], [tempImage.sizeW floatValue], [tempImage.sizeH floatValue])];
            [self.scrollView addSubview: imageView];
        }
    }
}

// Bring up the image picker view (built in view of photo gallery from Apple)
- (IBAction)addImageButton:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:NO completion:nil];
}
- (IBAction)userPinch:(UIPinchGestureRecognizer *)sender {
    if(self.imageSelected > 0){
        
        // value to scale image by
        CGFloat scale = sender.scale;
        
        //get the current frame
        CGFloat w = self.scrollView.subviews[self.imageSelected].frame.size.width;
        CGFloat h = self.scrollView.subviews[self.imageSelected].frame.size.height;
        CGFloat x = self.scrollView.subviews[self.imageSelected].frame.origin.x;
        CGFloat y = self.scrollView.subviews[self.imageSelected].frame.origin.y;
        
        // set the frame of the UIImage to its new size
        [self.scrollView.subviews[self.imageSelected] setFrame:CGRectMake(x,y,w + scale,h + scale)];
        
        sender.scale = 1;
    }
    
}

/* switched to tap
- (IBAction)dragImage:(UIPanGestureRecognizer *)sender
{
    //get the current frame location
    CGFloat w = self.scrollView.subviews[self.imageSelected].frame.size.width;
    CGFloat h = self.scrollView.subviews[self.imageSelected].frame.size.height;
    
    //where the user pans to.
    CGPoint end = [sender locationInView:[self scrollView]];
    
    [self.scrollView.subviews[self.imageSelected] setFrame:CGRectMake(end.x,end.y,w,h)];
}
 */

- (IBAction)moveImage:(UITapGestureRecognizer *)sender {
    if(self.imageSelected > 0){
    
    //get the current frame location
    CGFloat w = self.scrollView.subviews[self.imageSelected].frame.size.width;
    CGFloat h = self.scrollView.subviews[self.imageSelected].frame.size.height;
    
    //where the user taps
    CGPoint end = [sender locationInView:[self scrollView]];
    
    //set with offset so image pops in at where the cursor/tap is
    [self.scrollView.subviews[self.imageSelected] setFrame:CGRectMake(end.x - (w/2),end.y - (h/2),w,h)];
    }
}

- (IBAction)userRotate:(UIRotationGestureRecognizer *)sender {
    if(self.imageSelected > 0){
        self.scrollView.subviews[self.imageSelected].transform = CGAffineTransformMakeRotation(sender.rotation);
    }
}

- (IBAction)selectImage:(UIButton *)sender {
    if(self.imageSelected == -1)
    {
        self.imageSelected = 2;
        self.scrollView.subviews[self.imageSelected].layer.borderColor = UIColor.cyanColor.CGColor;
        self.scrollView.subviews[self.imageSelected].layer.borderWidth = 2;
    }// check if there was an image selected
    else {// remove border on prior selected image and add border on next image
        self.scrollView.subviews[self.imageSelected].layer.borderColor = UIColor.clearColor.CGColor;
        self.imageSelected++;
        if(self.imageSelected > self.imageNum-1)
        {
            self.imageSelected = -1;
        }// last image then remove border and reset imageSelected
        else {
            self.scrollView.subviews[self.imageSelected].layer.borderColor = UIColor.cyanColor.CGColor;
            self.scrollView.subviews[self.imageSelected].layer.borderWidth = 2;
        }// not last image, add border on next image in array
    }

    
}// select image


// Get rid of the camera roll view after an image has been selected.
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];

    NSData *imageData = UIImagePNGRepresentation(image);
    Image *newImage = [Image insertNewRawImage:imageData inManagedObjectContext:[self managedObjectContext]];
  
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    [imageView setFrame:CGRectMake(150, 200, 100, 100)];
    
    newImage.locationX = @(imageView.frame.origin.x);
    newImage.locationY = @(imageView.frame.origin.y);
    newImage.sizeH = @(imageView.frame.size.height);
    newImage.sizeW = @(imageView.frame.size.width);
    
    [[self imagesTemp] addObject:newImage];
    
    [self.scrollView addSubview: imageView];
    
    
    self.imageNum++;
    if(self.imageSelected == -1)
    {
        self.imageSelected = self.imageNum-1;
        self.scrollView.subviews[self.imageSelected].layer.borderColor = UIColor.cyanColor.CGColor;
        self.scrollView.subviews[self.imageSelected].layer.borderWidth = 2;
    }// check if there was an image selected
    else {// remove border on prior selected image and add border on next image
        self.scrollView.subviews[self.imageSelected].layer.borderColor = UIColor.clearColor.CGColor;
        self.imageSelected = self.imageNum-1;
        if(self.imageSelected > self.imageNum-1)
        {
            self.imageSelected = -1;
        }// last image then remove border and reset imageSelected
        else {
            self.scrollView.subviews[self.imageSelected].layer.borderColor = UIColor.cyanColor.CGColor;
            self.scrollView.subviews[self.imageSelected].layer.borderWidth = 2;
        }// not last image, add border on next image in array
    }
}

- (IBAction)menuBtn:(id)sender {
    if (self.menuShowing){
        self.leadingConstraint.constant = -207;
        
        [UIView animateWithDuration: 0.3 animations: ^{
            [self.editView setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0]];
            [self.view layoutIfNeeded]; } ];
    }
    else {
        self.leadingConstraint.constant = 0;
        [UIView animateWithDuration: 0.3 animations: ^{
            [self.editView setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7]];
            [self.view layoutIfNeeded]; } ];
        [self.view bringSubviewToFront:self.menuView];
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
