/*
 *  SuicidaltiyCell.m
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
#import "SuicidaltiyCell.h"

@implementation SuicidaltiyCell
@synthesize ideationButton,meansButton,planButton,historyButton,ideationOnButton,meansOnButton,planOnButton,historyOnButton;


- (void)performInitialization 
{
    
    [super performInitialization];
}



// overrides superclass
- (void)loadBindingsIntoCustomControls
{
    [super loadBindingsIntoCustomControls];
    
    
    
       
   suicideHistory = [[self.boundObject valueForKey:@"suicideHistory"]boolValue];
    suicideMeans = [[self.boundObject valueForKey:@"suicideMeans"]boolValue];
    suicideIdeation = [[self.boundObject valueForKey:@"suicideIdeation"]boolValue];
    suicidePlan = [[self.boundObject valueForKey:@"suicidePlan"]boolValue];
    
    ideationOnButton.hidden=!suicideIdeation;
    meansOnButton.hidden=!suicideMeans;
    planOnButton.hidden=!suicidePlan;
    historyOnButton.hidden=!suicideHistory;
    ideationButton.hidden=suicideIdeation;
    meansButton.hidden=suicideMeans;
    planButton.hidden=suicidePlan;
    historyButton.hidden=suicideHistory;
    
    ideationOnButton.highlighted=TRUE;
    meansOnButton.highlighted=TRUE;
    planOnButton.highlighted=TRUE;
    historyOnButton.highlighted=TRUE;
    [self checkSuicideRisk];
    
}

-(void)toggleButtons:(UIButton *)button{
    
    
    
    switch (button.tag) {
        case 30:
        {
            if (ideationOnButton.hidden) {
                ideationOnButton.highlighted=TRUE;
                ideationOnButton.hidden=FALSE;
                suicideIdeation=TRUE;
                ideationButton.hidden=TRUE;
                
            }
            else
            {
                ideationButton.highlighted=FALSE;
                ideationButton.hidden=FALSE;
                ideationOnButton.hidden=TRUE;
                suicideIdeation=FALSE;
            }
            
//            button.hidden=suicideIdeation;
//            ideationOffButton.highlighted=TRUE;
            
        
        }
            break;
        case 31:
        {
            
            if (planOnButton.hidden) {
                planOnButton.highlighted=TRUE;
                planOnButton.hidden=FALSE;
                planButton.hidden=TRUE;
                suicidePlan=TRUE;
                
            }
            else
            {
                planButton.highlighted=FALSE;
                planButton.hidden=FALSE;
                planOnButton.hidden=TRUE;
                suicidePlan=FALSE;
            }

        }
            break;
            
        case 32:
        {
            
            if (meansOnButton.hidden) {
                meansOnButton.highlighted=TRUE;
                meansOnButton.hidden=FALSE;
                meansButton.hidden=TRUE;
                suicideMeans=TRUE;
                
            }
            else
            {
                meansButton.highlighted=FALSE;
                meansButton.hidden=FALSE;
                meansOnButton.hidden=TRUE;
                suicideMeans=FALSE;
            }

        }
            break;
        case 33:
        {
            if (historyOnButton.hidden) {
                historyOnButton.highlighted=TRUE;
                historyOnButton.hidden=FALSE;
                historyButton.hidden=TRUE;
                suicideHistory=TRUE;
                
            }
            else
            {
                historyButton.highlighted=FALSE;
                historyButton.hidden=FALSE;
                historyOnButton.hidden=TRUE;
                suicideHistory=FALSE;
            }

            
        }
            break;
        default:
            break;
    }

    needsCommit=TRUE;
    [self checkSuicideRisk];


}


// overrides superclass
- (void)commitChanges
{
    if(!needsCommit)
		return;
	
	
    NSDictionary *suicideDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithBool:suicidePlan],  [NSNumber numberWithBool:suicideIdeation], [NSNumber numberWithBool:suicideMeans],[NSNumber numberWithBool:suicideHistory], nil] forKeys:[NSArray arrayWithObjects:@"suicidePlan", @"suicideIdeation", @"suicideMeans", @"suicideHistory", nil]];
    
    [self.boundObject setValuesForKeysWithDictionary:suicideDictionary];  
    //    NSDictionary *observerDictionary=[NSDictionary dictionaryWithObject:addStopwatch forKey:@"addStopwatch"];
    //    [self observeValueForKeyPath:@"addStopwatch" ofObject:self change:observerDictionary context:nil];
    [super commitChanges];
    needsCommit = FALSE;
    
    
}


-(IBAction)ideationButtonTapped:(id)sender{

    [self toggleButtons:self.ideationButton];

}
-(IBAction)planButtonTapped:(id)sender{

[self toggleButtons:self.planButton];

}
-(IBAction)meansButtonTapped:(id)sender{

[self toggleButtons:self.meansButton];
}
-(IBAction)historyButtonTapped:(id)sender{

[self toggleButtons:self.historyButton];

}

-(IBAction)ideationOffButtonTapped:(id)sender{

[self toggleButtons:self.ideationOnButton];
}
-(IBAction)planOffButtonTapped:(id)sender{
[self toggleButtons:self.planOnButton];
}
-(IBAction)meansOffButtonTapped:(id)sender{
[self toggleButtons:self.meansOnButton];
}
-(IBAction)historyOffButtonTapped:(id)sender{

[self toggleButtons:self.historyOnButton];
}


-(void)checkSuicideRisk{
[timer invalidate];
        timer=nil;
    if((suicidePlan&&suicideMeans)||(suicideIdeation&&suicideMeans)||(suicideIdeation&&suicideHistory&&suicideMeans)){
        
    
     
        
        
            if (suicideHistory) 
            {
                timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                         target:self
                                                       selector:@selector(flashSuicideWarning)
                                                       userInfo:NULL
                                                        repeats:YES];
            }
            else if (!suicidePlan)
            {
                    timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                             target:self
                                                           selector:@selector(flashSuicideWarning)
                                                           userInfo:NULL
                                                            repeats:YES];
                
            }
                
            else
            {
                timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(flashSuicideWarning)
                                               userInfo:NULL
                                                repeats:YES];
        
             }
       
    
    
    }
    else
    {
        if (suicideIdeation ||suicidePlan||suicideHistory) {
            if ((suicideIdeation&&suicideHistory)||(suicidePlan)) {
                timer = [NSTimer scheduledTimerWithTimeInterval:2.5
                                                         target:self
                                                       selector:@selector(flashSuicideWarning)
                                                       userInfo:NULL
                                                        repeats:YES];
            }else{
            timer = [NSTimer scheduledTimerWithTimeInterval:4.25
                                                     target:self
                                                   selector:@selector(flashSuicideWarning)
                                                   userInfo:NULL
                                                          repeats:YES];
            }}
        else{
        [UIView beginAnimations:nil context: nil];
        [UIView setAnimationDuration:0.5];
        self.backgroundColor=[UIColor whiteColor];
        [UIView commitAnimations];
        [timer invalidate];
        timer=nil;
    
    }
    }


}

-(void)flashSuicideWarning{

    if (suicideMeans||suicideHistory||suicideIdeation||suicidePlan) {
    
   

    if (self.backgroundColor==[UIColor whiteColor]) {
        
        [UIView beginAnimations:nil context: nil];
        [UIView setAnimationDuration:0.5];
         self.backgroundColor=[UIColor redColor];
        [UIView commitAnimations];

        
       
    }
    else
    {
        [UIView beginAnimations:nil context: nil];
        [UIView setAnimationDuration:0.5];
        self.backgroundColor=[UIColor whiteColor];
        [UIView commitAnimations];    
    }
    }
    else
    {
        [UIView beginAnimations:nil context: nil];
        [UIView setAnimationDuration:0.5];
        self.backgroundColor=[UIColor whiteColor];
        [UIView commitAnimations];
        [timer invalidate];
        timer=nil;

    
    
    }
   
}



@end
