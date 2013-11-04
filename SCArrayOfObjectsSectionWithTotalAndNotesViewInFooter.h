//
//  SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 7/12/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

@interface SCArrayOfObjectsSectionWithTotalAndNotesViewInFooter : SCArrayOfObjectsSection

@property (nonatomic, weak) NSString *footerNotes;
@property (nonatomic, weak) NSString *footerTotal;

- (id) initWithHeaderTitle:(NSString *)sectionHeaderTitle footerNotes:(NSString *)sectionNotes sectionTotalStr:(NSString *)sectionTotal items:(NSMutableArray *)sectionItems itemsDefinition:(SCDataDefinition *)definition;

+ (id) sectionWithHeaderTitle:(NSString *)sectionHeaderTitle footerNotes:(NSString *)sectionNotes sectionTotalStr:(NSString *)sectionTotal items:(NSMutableArray *)sectionItems itemsDefinition:(SCDataDefinition *)definition;
@end
