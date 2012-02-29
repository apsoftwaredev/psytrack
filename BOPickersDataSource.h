//
//  BOPickersDataSource.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 10/23/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//


@interface BOPickersDataSource : NSObject <UIPickerViewDataSource, UIPickerViewDelegate>
{
	NSArray	*customPickerArray;
}



@property (nonatomic, strong) NSArray *customPickerArray;





-(void)setupCustomPickerArrayWithPropertyName:(NSString *)propertyNameValue;


@end
