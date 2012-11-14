/*
 *  SuicidaltiyCell.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 11/8/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import <UIKit/UIKit.h>

@interface SuicidaltiyCell : SCCustomCell {
    BOOL suicidePlan;
    BOOL suicideIdeation;
    BOOL suicideMeans;
    BOOL suicideHistory;
    NSTimer *timer;
    
    
    NSString *historyKeyString;
    NSString *ideationKeyString;
    NSString *planKeyString;
    NSString *meansKeyString;
    
    
}



@property (weak, nonatomic) IBOutlet UIButton *ideationButton;
@property (weak, nonatomic) IBOutlet UIButton *planButton;
@property (weak, nonatomic) IBOutlet UIButton *meansButton;
@property (weak, nonatomic) IBOutlet UIButton *historyButton;
@property (weak, nonatomic) IBOutlet UIButton *ideationOnButton;
@property (weak, nonatomic) IBOutlet UIButton *planOnButton;
@property (weak, nonatomic) IBOutlet UIButton *meansOnButton;
@property (weak, nonatomic) IBOutlet UIButton *historyOnButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

-(IBAction)ideationButtonTapped:(id)sender;
-(IBAction)planButtonTapped:(id)sender;
-(IBAction)meansButtonTapped:(id)sender;
-(IBAction)historyButtonTapped:(id)sender;



-(void)toggleButtons:(UIButton *)button;
-(void)checkSuicideRisk;
-(void)flashSuicideWarning;
-(NSString *)getSelectedVariables;
@end
