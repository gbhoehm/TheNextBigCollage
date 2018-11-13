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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic) BOOL menuShowing;

@end

@implementation CollageViewController

@synthesize collage;
@synthesize stack;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuShowing = false;
    
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
    
    
    
    [[[self collage] images] addObject:image];
    
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
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] saveContext];
    }
}


-(IBAction)unwindToEdit:(UIStoryboardSegue *)segue{}

@end
