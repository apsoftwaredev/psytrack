//
//  PrepopulateAndRemoveDuplicates.h
//  PsyTrack
//
//  Created by Daniel Boice on 10/20/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrepopulateAndRemoveDuplicates : NSObject {

    NSArray *assessmentTypeArray_;

    NSArray *interventionTypeArray_;
NSArray *interventionTypeSubtypeArray_;
    NSArray *supervisionTypeArray_;
    NSArray *supervisionTypeSubtypeArray_;
    NSArray *supportActivityTypeArray_;
    NSArray *genderArray_;
    NSArray *languageArray_;
    NSArray *educationLevelArray_;
    NSArray *employmentStatusArray_;
    NSArray *relationshipArray_;
    NSArray *clinicianTypeArray_;

}

-(void)prepopulate;
-(void)removeDuplicatePrepopulatedData;
@end
