//
//  CustomSCTextViewCell.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 1/6/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "SCTableViewCell.h"

@interface CustomSCTextViewCell : SCControlCell


@property (nonatomic, weak)IBOutlet UITextView *myTextView;
@property (nonatomic, weak)IBOutlet UILabel *myLabel;
@end
