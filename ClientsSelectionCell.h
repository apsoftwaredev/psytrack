//
//  ClientsSelectionCell.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 11/18/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import "SCTableViewCell.h"

@interface ClientsSelectionCell : SCObjectSelectionCell {


    __weak NSManagedObject *clientObject;
    BOOL hasChangedClients;
    NSDate *testDate;
}


@property (nonatomic, strong) IBOutlet NSMutableSet *alreadySelectedClients;
@property (nonatomic, readwrite)  BOOL hasChangedClients;
@property (nonatomic, strong) NSDate *testDate;


@property (nonatomic,weak)IBOutlet  NSManagedObject *clientObject;

-(void)doneButtonTappedInDetailView:(NSObject *)selectedObject  withValue:(BOOL)hasValue;

//-(NSString *)clientIDCodeString;
@end
