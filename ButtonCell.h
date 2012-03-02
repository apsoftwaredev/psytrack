/*
 *  ButtonCell.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 9/5/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "SCTableViewCell.h"


@interface ButtonCell : SCControlCell
{
    UIButton *button_;
    NSString *buttonText;
}


@property (nonatomic,strong) NSString *buttonText;
@property (nonatomic,strong)IBOutlet UIButton *button;

- (id)initWithText:(NSString *)text;




@end

