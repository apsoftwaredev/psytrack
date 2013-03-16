//
//  SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter.m
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 7/12/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter.h"

@implementation SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter

@synthesize footerNotes,footerTotal;

- (id) initWithHeaderTitle:(NSString *)sectionHeaderTitle footerNotes:(NSString *)sectionNotes sectionTotalStr:(NSString *)sectionTotal items:(NSMutableArray *)sectionItems itemsDefinition:(SCDataDefinition *)definition
{
    self = [super initWithHeaderTitle:sectionHeaderTitle items:sectionItems itemsDefinition:definition];

    if (self)
    {
        self.footerTotal = sectionTotal;
        self.footerNotes = sectionNotes;
    }

    return self;
}


+ (id) sectionWithHeaderTitle:(NSString *)sectionHeaderTitle footerNotes:(NSString *)sectionNotes sectionTotalStr:(NSString *)sectionTotal items:(NSMutableArray *)sectionItems itemsDefinition:(SCDataDefinition *)definition
{
    return [[[self class] alloc] initWithHeaderTitle:sectionHeaderTitle footerNotes:sectionNotes sectionTotalStr:sectionTotal items:sectionItems itemsDefinition:definition];
}


@end
