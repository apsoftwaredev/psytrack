/*
 *  BOPickersDataSource.h
 *  psyTrack Clinician Tools
 *  Version: 1.5.4
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 10/23/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

@interface BOPickersDataSource : NSObject /*<UIPickerViewDataSource, UIPickerViewDelegate>*/
{
    NSArray *customPickerArray;
}

@property (nonatomic, strong) NSArray *customPickerArray;

//-(NSArray *)stringArrayForPropertyName:(NSString *)propertyNameValue;
- (NSArray *) presentationDataWithPropertyName:(NSString *)propertyNameValue;

@end
