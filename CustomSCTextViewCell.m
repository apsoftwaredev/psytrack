//
//  CustomSCTextViewCell.m
//  psyTrainTrack
//
//  Created by Daniel Boice on 1/6/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "CustomSCTextViewCell.h"

@implementation CustomSCTextViewCell
@synthesize myLabel, myTextView;

-(void)performInitialization{

    [super performInitialization];
    



}

-(void)loadBindingsIntoCustomControls{

    myLabel.text=[self.objectBindings valueForKey:@"label"];
    
    NSString *boundPropertyString=[self.objectBindings valueForKey:@"propertyNameString"];
    myTextView.text=[self.boundObject valueForKey:boundPropertyString];


    SCTextViewCell *textViewCell=[[SCTextViewCell alloc]init];
    
    myTextView.textColor=textViewCell.textView.textColor;
    myTextView.font=textViewCell.textView.font;
    
    myTextView.backgroundColor=textViewCell.backgroundColor;
    
    myTextView.editable=FALSE;
}



@end
