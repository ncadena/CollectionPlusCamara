//
//  ViewController.h
//  CollectionPlusCamara
//
//  Created by Nicolas Cadena on 17/06/14.
//  Copyright (c) 2014 Nicolas Cadena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UICollectionView *collection;

- (IBAction)takePhoto;
- (IBAction)selectPhoto;

@end
