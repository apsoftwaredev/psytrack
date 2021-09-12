/*
 *  DrugViewController_Shared.m
 *  psyTrack Clinician Tools
 *  Version: 1.5.4
 *
 *
 The MIT License (MIT)
 Copyright © 2011- 2021 Daniel Boice
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 *  Created by Daniel Boice on 12/19/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "DrugViewController_Shared.h"
#import "PTTAppDelegate.h"
#import "DrugProductEntity.h"
#import "CustomSCTextViewCell.h"

@implementation DrugViewController_Shared
@synthesize drugDef, drugsArray;

- (id) setupTheDrugsViewModelUsingSTV
{
    drugsManagedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate drugsManagedObjectContext];
    //Create a class definition for Client entity

//    BOOL checkMain=FALSE;
//    if (checkMain){
//
//    NSEntityDescription *appEntityDesc=[NSEntityDescription entityForName:@"DrugApplicationEntity" inManagedObjectContext:drugsManagedObjectContext];
//
//
//    NSFetchRequest *appFetchRequest = [[NSFetchRequest alloc] init];
//
//    [appFetchRequest setEntity:appEntityDesc];
//    NSError *appError = nil;
//    NSArray *appFetchedObjects = [drugsManagedObjectContext executeFetchRequest:appFetchRequest error:&appError];
//
//    NSInteger appFetchedObjectsCount= appFetchedObjects.count;
//    if (appFetchedObjectsCount==0) {
//         [(PTTAppDelegate *)[UIApplication sharedApplication].delegate  setUpDrugStore];
//        [(PTTAppDelegate *)[UIApplication sharedApplication].delegate saveDrugsContext];
//
//    }
//
//
//
////    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
////
//
////    NSEntityDescription *appEntityDescMain=[NSEntityDescription entityForName:@"DrugProductEntity" inManagedObjectContext:managedObjectContext];
////
////
////    NSFetchRequest *appFetchRequestMain = [[NSFetchRequest alloc] init];
////
////    [appFetchRequestMain setEntity:appEntityDescMain];
////    NSError *appMainError = nil;
////    NSArray *appFetchedObjectsMain = [managedObjectContext executeFetchRequest:appFetchRequestMain error:&appMainError];
////
////    NSInteger appFetchedObjectsCountMain= appFetchedObjectsMain.count;
////    if (appFetchedObjectsCountMain==0) {
////        [(PTTAppDelegate *)[UIApplication sharedApplication].delegate  copyDrugsToMainContext];
////         [(PTTAppDelegate *)[UIApplication sharedApplication].delegate saveContext];
////    }
////
//    }

//    BOOL takeOutQuotes=FALSE;
//
//    if (takeOutQuotes) {
//
////        if (appFetchedObjectsCount>0) {
//
//            NSEntityDescription *productEntityDescMain=[NSEntityDescription entityForName:@"DrugProductEntity" inManagedObjectContext:drugsManagedObjectContext];
//
//
//            NSFetchRequest *productFetchRequestMain = [[NSFetchRequest alloc] init];
//
//            [productFetchRequestMain setEntity:productEntityDescMain];
//            NSError *productMainError = nil;
//            NSArray *productFetchedObjectsMain = [drugsManagedObjectContext executeFetchRequest:productFetchRequestMain error:&productMainError];
//
//            NSInteger productCountMain= productFetchedObjectsMain.count;
//
//
//            for (int p=0;p<productCountMain; p++){
//
//                DrugProductEntity *productMain=[productFetchedObjectsMain objectAtIndex:p];
//
//
//
//                //
//                productMain.drugName=[productMain.drugName stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//
//                 productMain.dosage= [productMain.dosage stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//
//            }
//
//
//            NSEntityDescription *productEntityDesc=[NSEntityDescription entityForName:@"DrugProductEntity" inManagedObjectContext:drugsManagedObjectContext];
//
//
//            NSFetchRequest *productFetchRequest = [[NSFetchRequest alloc] init];
//
//            [productFetchRequest setEntity:productEntityDesc];
//            NSError *productError = nil;
//            NSArray *productFetchedObjects = [drugsManagedObjectContext executeFetchRequest:productFetchRequest error:&productError];
//
//            NSInteger productCount= productFetchedObjects.count;
//
//
//            for (int p=0;p<productCount; p++){
//
//                DrugProductEntity *product=[productFetchedObjects objectAtIndex:p];
//
//
//
//                //
//                product.drugName=[product.drugName stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//
//                product.dosage= [product.dosage stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//
//            }
//
//
////        }
//
//    }

    self.drugDef = [SCEntityDefinition definitionWithEntityName:@"DrugProductEntity"
                                           managedObjectContext:drugsManagedObjectContext
                                                  propertyNames:[NSArray arrayWithObject:@"tECode"]];

    //create the dictionary with the data bindings
    NSDictionary *customCellDrugNameDataBindings = [NSDictionary
                                                    dictionaryWithObjects:[NSArray arrayWithObjects:@"drugName",@"Drug Name", @"drugName",    nil]
                                                                  forKeys:[NSArray arrayWithObjects:@"1",@"label", @"propertyNameString", nil  ]]; // 1 is the the control tag

    //create the custom property definition
    SCCustomPropertyDefinition *drugNameDataDataProperty = [SCCustomPropertyDefinition definitionWithName:@"DrugNameData"
                                                                                         uiElementNibName:@"CustomSCTextViewCell_iPhone"
                                                                                           objectBindings:customCellDrugNameDataBindings];

    //insert the custom property definition into the drugsDef class at index 0
    [self.drugDef insertPropertyDefinition:drugNameDataDataProperty atIndex:0];

    //create the dictionary with the data bindings
    NSDictionary *customCellActiveIngredientDataBindings = [NSDictionary
                                                            dictionaryWithObjects:[NSArray arrayWithObjects:@"activeIngredient",@"Active Ingredient", @"activeIngredient",    nil]
                                                                          forKeys:[NSArray arrayWithObjects:@"1",@"label", @"propertyNameString", nil  ]]; // 1 is the the control tag

    //create the custom property definition
    SCCustomPropertyDefinition *activeIngredientDataProperty = [SCCustomPropertyDefinition definitionWithName:@"ActiveIngredientData"
                                                                                             uiElementNibName:@"CustomSCTextViewCell_iPhone"
                                                                                               objectBindings:customCellActiveIngredientDataBindings];

    //insert the custom property definition into the drugsDef class at index 1
    [self.drugDef insertPropertyDefinition:activeIngredientDataProperty atIndex:1];

    //create the dictionary with the data bindings
    NSDictionary *dosageDataBindings = [NSDictionary
                                        dictionaryWithObjects:[NSArray arrayWithObjects:@"dosage",@"Dosage", @"dosage",    nil]
                                                      forKeys:[NSArray arrayWithObjects:@"1",@"label", @"propertyNameString", nil  ]]; // 1 is the the control tag

    //create the custom property definition
    SCCustomPropertyDefinition *dosageDataProperty = [SCCustomPropertyDefinition definitionWithName:@"dosageData"
                                                                                   uiElementNibName:@"CustomSCTextViewCell_iPhone"
                                                                                     objectBindings:dosageDataBindings];

    //insert the custom property definition into the drugsDef class at index 3
    [self.drugDef insertPropertyDefinition:dosageDataProperty atIndex:2];

    //create the dictionary with the data bindings
    NSDictionary *formDataBindings = [NSDictionary
                                      dictionaryWithObjects:[NSArray arrayWithObjects:@"form",@"Form", @"form",    nil]
                                                    forKeys:[NSArray arrayWithObjects:@"1",@"label", @"propertyNameString", nil  ]];  // 1 is the the control tag

    //create the custom property definition
    SCCustomPropertyDefinition *formDataProperty = [SCCustomPropertyDefinition definitionWithName:@"FormData"
                                                                                 uiElementNibName:@"CustomSCTextViewCell_iPhone"
                                                                                   objectBindings:formDataBindings];

    //insert the custom property definition into the drugsDef class at index 3
    [self.drugDef insertPropertyDefinition:formDataProperty atIndex:3];

    int indexofTECode = [self.drugDef indexOfPropertyDefinitionWithName:@"tECode"];
    [self.drugDef removePropertyDefinitionAtIndex:indexofTECode];

//
//
//    //Create the property definition for the active ingredent property in the drugDef class
//    SCPropertyDefinition *sponsorPropertyDef = [self.drugDef propertyDefinitionWithName:@"appl.sponsorApplicant"];
//
//    sponsorPropertyDef.title=@"Made By";
//
//    sponsorPropertyDef.type=SCPropertyTypeTextView;

    self.drugDef.titlePropertyName = @"drugName;dosage";

    self.drugDef.keyPropertyName = @"drugName";

    //Create the property definition for the product te code property in the drugDef class
//    SCPropertyDefinition *productTECodePropertyDef = [self.drugDef propertyDefinitionWithName:@"productTECode"];
//
//
//
//    productTECodePropertyDef.title=@"Therapeutic Equivalents";

    return self;
}


@end
