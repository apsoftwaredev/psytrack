/*
 *  DrugRegActionOverviewCell.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 1/5/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "SCTableViewCell.h"

@interface DrugDocOverviewCell : SCControlCell <SCTableViewCellDelegate> {

    __weak UITextField *docTypeField;
    __weak UITextField *dateField;

    NSString *openNibNameString;


}


@property (nonatomic, weak )IBOutlet UITextField *docTypeField;
@property (nonatomic, weak) IBOutlet UITextField *dateField;



@end
