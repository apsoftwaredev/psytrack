//
//  ClientsViewController_shared.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 9/26/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//


#import "SCTableViewModel.h"


@interface ClientsViewController_Shared : NSObject /*<SCTableViewModelDelegate>*/{

NSManagedObjectContext *managedObjectContext;
    SCClassDefinition *clientDef;

}

@property (strong,nonatomic) SCClassDefinition *clientDef;


-(id)setupTheClientsViewModelUsingSTV;

-(NSString *)calculateWechslerAgeWithBirthdate:(NSDate *)birthdate;
-(NSString *)calculateActualAgeWithBirthdate:(NSDate *)birthdate;
-(NSString *)calculateWechslerAgeWithBirthdate:(NSDate *)birthdate toDate:(NSDate *)toDate;
-(NSString *)calculateActualAgeWithBirthdate:(NSDate *)birthdate toDate:(NSDate *)toDate;


@end
