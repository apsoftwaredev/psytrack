//
//  MyInformationAndTotalClients.m
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "MyInformationAndTotalClients.h"
#import "ClinicianEntity.h"
#import "PTTAppDelegate.h"
@implementation MyInformationAndTotalClients
@synthesize myName = myName_,totalClients = totalClients_;

- (id) init
{
    self = [super init];

    if (self)
    {
        self.myName = [self getStudentName];
        self.totalClients = [self getClientCount];
    }

    return self;
}


- (int) getClientCount
{
    int clientCount = 0;

    NSArray *clientArray = [self fetchObjectsFromEntity:@"ClientEntity" filterPredicate:nil];

    if (clientArray && clientArray.count)
    {
        clientCount = clientArray.count;
    }

    return clientCount;
}


- (NSString *) getStudentName
{
    NSString *studentName = nil;

    NSArray *cliniciansArrayWithMyInfo = [self fetchObjectsFromEntity:@"ClinicianEntity" filterPredicate:[NSPredicate predicateWithFormat:@"myInformation== %@",[NSNumber numberWithBool:YES]]];

    if (cliniciansArrayWithMyInfo && cliniciansArrayWithMyInfo.count)
    {
        int clinicianCount = cliniciansArrayWithMyInfo.count;

        if (clinicianCount > 1)
        {
            //there should only be one

            for (ClinicianEntity *clinicianInArray in cliniciansArrayWithMyInfo)
            {
                //try to find the right one
                if ([clinicianInArray.firstName isEqualToString:@"Enter Your"])
                {
                    studentName = clinicianInArray.combinedName;
                    break;
                }
            }

            if ( (!studentName || !studentName.length) && cliniciansArrayWithMyInfo && cliniciansArrayWithMyInfo.count )
            {
                ClinicianEntity *clinicianInArray = [cliniciansArrayWithMyInfo objectAtIndex:0];
                studentName = clinicianInArray.combinedName;
            }
        }
        else if (cliniciansArrayWithMyInfo && cliniciansArrayWithMyInfo.count)
        {
            ClinicianEntity *clinicianInArray = [cliniciansArrayWithMyInfo objectAtIndex:0];
            studentName = clinicianInArray.combinedName;
        }
    }

    return studentName;
}


- (NSArray *) fetchObjectsFromEntity:(NSString *)entityStr filterPredicate:(NSPredicate *)filterPredicate
{
    NSManagedObjectContext *managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSEntityDescription *entity = [NSEntityDescription entityForName:entityStr inManagedObjectContext:managedObjectContext];

    [fetchRequest setEntity:entity];

    if (filterPredicate)
    {
        [fetchRequest setPredicate:filterPredicate];
    }

    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];

    return fetchedObjects;
}


@end
