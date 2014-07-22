//
//  ViewController.m
//  CollectionPlusCamara
//
//  Created by Nicolas Cadena on 17/06/14.
//  Copyright (c) 2014 Nicolas Cadena. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableArray* array;
}
@synthesize collection;
- (void)viewDidLoad
{
    [super viewDidLoad];
    array = [[NSMutableArray alloc]init];
    
//    [array addObject:[UIImage imageNamed:@"Barca.jpg"]];
//    [array addObject:[UIImage imageNamed:@"Puyi.jpg"]];
//    [array addObject:[UIImage imageNamed:@"Puyi.jpg"]];
//    [array addObject:[UIImage imageNamed:@"Messi.jpg"]];
//    [array addObject:[UIImage imageNamed:@"Barca.jpg"]];
    [array addObject:[UIImage imageNamed:@"Messi.jpg"]];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [array count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    UIImageView* view = (UIImageView *) [cell viewWithTag:100];
    view.image = [array objectAtIndex:indexPath.row];
    
    [cell.layer setBorderWidth:2.0f];
    [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    return cell;
    
}

-(void)addObjectAndUpdateCells:(UIImage*)image
{
    [array insertObject:image atIndex:0];
    [collection reloadData];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detailPush"])
    {
        NSArray *indexPaths = [self.collection indexPathsForSelectedItems];
        DetailViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        destViewController.theImage = [array objectAtIndex:indexPath.row];
        [self.collection deselectItemAtIndexPath:indexPath animated:NO];
        if ([array objectAtIndex:indexPath.row] == [UIImage imageNamed:@"Messi.jpg"])
        {
            [self takePhoto];
        }
    }
}


//CAMARA

- (IBAction)takePhoto{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)selectPhoto{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [self addObjectAndUpdateCells:chosenImage];
    
    // Save image
    UIImageWriteToSavedPhotosAlbum(chosenImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alert;
    
    // Unable to save the image
    if (error)
        alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                           message:@"Unable to save image to Photo Album."
                                          delegate:self cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
    else // All is well
//        alert = [[UIAlertView alloc] initWithTitle:@"Success"
//                                           message:@"Image saved to Photo Album."
//                                          delegate:self cancelButtonTitle:@"Ok"
//                                 otherButtonTitles:nil];
    [alert show];
    
}



@end
