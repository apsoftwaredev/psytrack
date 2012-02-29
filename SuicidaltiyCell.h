//
//  SuicidaltiyCell.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 11/8/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import "SCTableViewCell.h"

@interface SuicidaltiyCell : SCControlCell <SCTableViewCellDelegate>{
    BOOL suicidePlan;
    BOOL suicideIdeation;
    BOOL suicideMeans;
    BOOL suicideHistory;
    NSTimer *timer;
}



@property (weak, nonatomic) IBOutlet UIButton *ideationButton;
@property (weak, nonatomic) IBOutlet UIButton *planButton;
@property (weak, nonatomic) IBOutlet UIButton *meansButton;
@property (weak, nonatomic) IBOutlet UIButton *historyButton;
@property (weak, nonatomic) IBOutlet UIButton *ideationOnButton;
@property (weak, nonatomic) IBOutlet UIButton *planOnButton;
@property (weak, nonatomic) IBOutlet UIButton *meansOnButton;
@property (weak, nonatomic) IBOutlet UIButton *historyOnButton;
-(IBAction)ideationButtonTapped:(id)sender;
-(IBAction)planButtonTapped:(id)sender;
-(IBAction)meansButtonTapped:(id)sender;
-(IBAction)historyButtonTapped:(id)sender;

-(IBAction)ideationOnButtonTapped:(id)sender;
-(IBAction)planOnButtonTapped:(id)sender;
-(IBAction)meansOnButtonTapped:(id)sender;
-(IBAction)historyOnButtonTapped:(id)sender;

-(void)toggleButtons:(UIButton *)button;
-(void)checkSuicideRisk;
-(void)flashSuicideWarning;
@end
