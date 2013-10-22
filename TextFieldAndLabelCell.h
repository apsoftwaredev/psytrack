//
//  TextFieldAndLabelCell.h
//  PsyTrack
//
//  Created by Daniel Boice on 10/20/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <SensibleTableView/SensibleTableView.h>

@interface TextFieldAndLabelCell : SCCustomCell
{

    __weak UITextField *textField_;
    __weak UILabel *label_;
   
}

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UILabel *label;



@end
