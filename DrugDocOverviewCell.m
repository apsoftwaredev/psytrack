/*
 *  DrugRegActionOverviewCell.m
 *  psyTrack Clinician Tools
 *  Version: 1.5.4
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 1/5/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "DrugDocOverviewCell.h"
#import "DrugAppDocsViewController.h"
#import "WebViewDetailViewController.h"
#import "PTTAppDelegate.h"
#import "DrugDocTypeLookupEntity.h"
#import "DrugActionDateViewController.h"

@implementation DrugDocOverviewCell

@synthesize dateField,docTypeField;

- (void) performInitialization
{
    [super performInitialization];
}


- (void) loadBindingsIntoCustomControls
{
    [super loadBindingsIntoCustomControls];
//
//

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];

    [dateFormatter setDateFormat:@"M/d/yyyy"];

    NSString *datePropertyString = [self.objectBindings valueForKey:@"bottom"];

    NSDate *actionDate = [self.boundObject valueForKey:datePropertyString];

    if (datePropertyString.length)
    {
        dateField.text = [dateFormatter stringFromDate:actionDate];
    }

//

    NSString *keyPathStringForTopText = [self.objectBindings valueForKey:@"top"];
    openNibNameString = [self.objectBindings valueForKey:@"openNib"];

    if ([openNibNameString isEqualToString:@"WebViewDetailViewController"])
    {
        NSString *docTypeString = (NSString *)[self.boundObject valueForKey:keyPathStringForTopText];
        docTypeField.text = docTypeString;
    }
    else
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"docType matches %@",
                                  [self.boundObject valueForKey:@"docType"] ];

        NSArray *docTypeLookupArray = (NSArray *)[(DrugActionDateViewController *)self.ownerTableViewModel.delegate docTypesArray];

//

        docTypeLookupArray = (NSArray *)[docTypeLookupArray filteredArrayUsingPredicate:predicate];

        if (docTypeLookupArray.count > 0)
        {
//
            DrugDocTypeLookupEntity *docTypeLookup = (DrugDocTypeLookupEntity *)[docTypeLookupArray objectAtIndex:0];

            NSString *docTypeDescString = (NSString *)docTypeLookup.docTypeDesc;
//
            docTypeField.text = docTypeDescString;
        }

//
//        docTypeField.text=(NSString *)docTypeSet;
//
    }

//    docTypeLookup= actionDateObject.documentType.self;
//    if (mutableArray.count>0) {
//         docTypeLookup=[mutableArray objectAtIndex:0];
//         docTypeField.text=docTypeLookup.docTypeDesc;
//    }
}


- (void) willDisplayCell
{
    if (self.isSelected )
    {
        docTypeField.textColor = [UIColor whiteColor];
        dateField.textColor = [UIColor whiteColor];
    }
    else
    {
        docTypeField.textColor = [UIColor colorWithRed:0.185592 green:0.506495 blue:0.686239 alpha:1];
        dateField.textColor = [UIColor blackColor];
    }
}


- (void) willSelectCell
{
    docTypeField.textColor = [UIColor whiteColor];
    dateField.textColor = [UIColor whiteColor];
}


- (void) didSelectCell
{
    if ([openNibNameString isEqualToString:@"WebViewDetailViewController"])
    {
        NSString *urlString = (NSString *)[self.boundObject valueForKey:@"docUrl"];

        if (urlString.length)
        {
            WebViewDetailViewController *webDetailViewController = [[WebViewDetailViewController alloc]initWithNibName:openNibNameString bundle:nil urlString:urlString];

            [self.ownerTableViewModel.viewController.navigationController pushViewController:webDetailViewController animated:YES];
        }
    }
    else if ([openNibNameString isEqualToString:@"DrugAppDocsViewController"])
    {
        //
        NSString *applNoString = [self.boundObject valueForKey:@"applNo"];
        NSString *inDocSeqNoString = [self.boundObject valueForKey:@"inDocTypeSeqNo"];

        //        UITabBarController *tabBarController=(UITabBarController *)[(PTTAppDelegate *)[UIApplication sharedApplication].delegate tabBarController];
        //
        //        [tabBarController.tabBar setHidden:TRUE ];
        //

        DrugAppDocsViewController *drugAppDocsViewController = [[DrugAppDocsViewController alloc]initWithNibName:openNibNameString bundle:nil applNoString:applNoString inDocSeqNo:inDocSeqNoString];

        [self.ownerTableViewModel.viewController.navigationController pushViewController:drugAppDocsViewController animated:YES];
    }

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:2];
    self.highlighted = FALSE;
    docTypeField.textColor = [UIColor colorWithRed:0.185592 green:0.506495 blue:0.686239 alpha:1];
    dateField.textColor = [UIColor blackColor];
    [UIView commitAnimations];
}


- (void) didSelectCell:(SCTableViewCell *)cell
{
//
}


- (void) didDeselectCell
{
    docTypeField.textColor = [UIColor colorWithRed:0.185592 green:0.506495 blue:0.686239 alpha:1];
    dateField.textColor = [UIColor blackColor];
}


@end
