//
//  ButtonCell.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 9/5/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

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

