//
//  DrugRegActionOverviewCell.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 1/5/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "SCTableViewCell.h"

@interface DrugDocOverviewCell : SCControlCell <SCTableViewCellDelegate> {

    __weak UITextField *docTypeField;
    __weak UITextField *dateField;

    NSString *openNibNameString;


}


@property (nonatomic, weak )IBOutlet UITextField *docTypeField;
@property (nonatomic, weak) IBOutlet UITextField *dateField;



@end
