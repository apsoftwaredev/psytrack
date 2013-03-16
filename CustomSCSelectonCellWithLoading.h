/*
 *  CustomSCSelectonWithLoadingCell.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 1/9/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import <UIKit/UIKit.h>

@interface CustomSCSelectonCellWithLoading : SCSelectionCell {
    IBOutlet UIImageView *imageView;
    IBOutlet NSArray *loadingImagesArray;
    IBOutlet UIImage *image1;
    IBOutlet UIImage *image2;
    IBOutlet UIImage *image3;
    IBOutlet UIImage *image4;
    IBOutlet UIImage *image5;
    IBOutlet UIImage *image6;
    IBOutlet UIImage *image7;
    IBOutlet UIImage *image8;
}

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) NSArray *loadingImagesArray;

@property (nonatomic, strong) UIImage *image1;
@property (nonatomic, strong) UIImage *image2;
@property (nonatomic, strong) UIImage *image3;
@property (nonatomic, strong) UIImage *image4;
@property (nonatomic, strong) UIImage *image5;
@property (nonatomic, strong) UIImage *image6;
@property (nonatomic, strong) UIImage *image7;
@property (nonatomic, strong) UIImage *image8;

@end
