//
//  PrepopulateAndRemoveDuplicates.m
//  PsyTrack
//
//  Created by Daniel Boice on 10/20/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "PrepopulateAndRemoveDuplicates.h"
#import "AssessmentTypeEntity.h"
#import "InterventionTypeEntity.h"
#import "InterventionTypeSubtypeEntity.h"
#import "SupervisionTypeEntity.h"
#import "SupervisionTypeSubtypeEntity.h"
#import "SupportActivityTypeEntity.h"
#import "GenderEntity.h"
#import "LanguageEntity.h"
#import "EducationLevelEntity.h"
#import "EmploymentStatusEntity.h"
#import "RelationshipEntity.h"
#import "ClinicianTypeEntity.h"
#import "PTTAppDelegate.h"
#import "AssessmentEntity.h"
#import "InterventionDeliveredEntity.h"
#import "SupportActivityDeliveredEntity.h"
#import "SupervisionGivenEntity.h"
#import "SupervisionReceivedEntity.h"
#import "ClinicianEntity.h"
#import "DemographicProfileEntity.h"
#import "InterpersonalEntity.h"
#import "ExistingSupervisionEntity.h"
#import "ExistingInterventionEntity.h"

@implementation PrepopulateAndRemoveDuplicates


-(id)init{

    if (self = [super init]) {
        
        
    
    }
    
    
    return self;

}


-(NSArray *)assessmentTypeArray{
    return [NSArray arrayWithObjects:@"Intake/Structured Interview",@"Psychodiagnostic Test Administration",@"Neuropsychological Test Administration", @"Other Assessment Activities (specify in notes)", nil];
}


-(NSArray *)interventionTypeArray{
    
    //dont change the order of these without changing prepopulate interventiontype
    
    return [NSArray arrayWithObjects:@"Individual Therapy/Counseling", @"Group Therapy/Counseling",@"Family and Couples Therapy/Counseling",@"Other Psychological Interventions",nil];
}




-(NSArray *)interventionTypeSubtypeArray{
    return [NSArray arrayWithObjects:@"Older Adult (65+)",@"Adult (18-64)",@"Adolescent (13-17)",@"School Age (6-12)",@"Pre-School Age (3-5)", @"Infant (0-2)",@"Adults (18 and over)",@"Adolescents (13-17)",@"Children (12 and under)", @"Family",@"Couples",@"Sport Psychology Intervention",@"Medical/Health-Related Intervention",@"Substance Abuse Intervention",@"Consulation With Client(s) Present",@"Other Interventions (specify in notes)", nil];
}

-(NSArray *)subtypesForInterventionIndividual{

 return [NSArray arrayWithObjects:@"Older Adult (65+)",@"Adult (18-64)",@"Adolescent (13-17)",@"School Age (6-12)",@"Pre-School Age (3-5)", @"Infant (0-2)", nil];

}


-(NSArray *)subtypesForInterventionGroup{
    
    return [NSArray arrayWithObjects:@"Adults (18 and over)",@"Adolescents (13-17)",@"Children (12 and under)", nil];
    
}
-(NSArray *)subtypesForInterventionFamily{
    
    return [NSArray arrayWithObjects:@"Family",@"Couples", nil];
    
}

-(NSArray *)subtypesForInterventionOther{
    
    return [NSArray arrayWithObjects:@"Sport Psychology Intervention",@"Medical/Health-Related Intervention",@"Substance Abuse Intervention",@"Consulation With Client(s) Present",@"Other Interventions (specify in notes)", nil];
    
}




-(NSArray *)supportActivityTypeArray{
    return [NSArray arrayWithObjects:@"Case Conferences",@"Didactic Training Seminars/Grand Rounds",@"Progress Note/Clinical Writing/Chart Review",@"Psych. Assessment Scoring/Interpretation",@"Report Writing",@"Video-Audio-Digital Recording Review",@"Peer Supervision/Consultation",@"Other (specify in notes)", nil];
};




-(NSArray *)supervisionTypeArray{
    return [NSArray arrayWithObjects:@"Supervision by a Licensed Psychologist",@"Supervision By Other Licensed Mental Health Professional",@"Advanced Graduate Student Supervised by a Licensed Psychologist ", nil];
};



-(NSArray *)supervisionTypeSubtypeArray{
    return [NSArray arrayWithObjects:@"Individual Supervision",@"Group Supervision", nil];
}





-(NSArray *)genderArray{
    return [NSArray arrayWithObjects:@"Man",@"Woman",@"Young Man",@"Young Woman",@"Boy",@"Girl",@"Two-Spirit",@"Third Gender",@"Undisclosed", nil];
}





-(NSArray *)educationLevelArray{
    return [NSArray arrayWithObjects:@"Never attended school",@"In Preschool",@"In Kindergarten",@"Completed Kindergarten",@"In First Grade",@"Completed 1st Grade",@"In 2nd Grade",@"Completed 2nd Grade",@"In 3rd Grade",@"Completed 3rd Grade",@"In 4th Grade",@"Completed 4th Grade",@"In 5th Grade",@"Completed 5th Grade",@"In 6th Grade",@"Completed 7th Grade",@"In 8th Grade",@"Completed 9th Grade",@"In 10th Grade",@"Completed 11th Grade",@"In 12th Grade",@"Completed 12th Grade",@"1st Year Undergraduate",@"2nd Year Undergraduate",@"3rd Year Undergraduate",@"4th Year Undergraduate",@"5th Year Undergraduate",@"Bachelors Degree",@"Two Bachelors Degrees",@"1st Year Graduate School",@"2nd Year Graduate Student",@"3rd Year Graduate Student",@"4th Year Graduate Student", @"5th Year Graduate Student",@"6th Year Graduate Student",@"8th Year Graduate Student",@"Graduate Degree",@"Two Graduate Degrees",@"Doctor Ph.D., Psy.D.",@"Doctor M.D./D.O.",@"Doctor JD",nil];
}



-(NSArray *)employmentStatusArray{
    return [NSArray arrayWithObjects:@"Employed Full Time",@"Part-Time",@"Full-Time and Part-Time",@"Two Full-Time Jobs",@"Unemployed Looking For Work",@"Unemployed Not Looking For Work",@"Unemployed On Disability",@"Retired", nil];
}



-(NSArray *)relationshipArray{
    return [NSArray arrayWithObjects:@"Aunt",@"Brother",@"Brother-in-Law",@"Daughter",@"Father",@"Father-in-Law",@"First Cousin",@"Grandfather",@"Grandmother",@"Great-Grandfather",@"Great-Grandmother",@"Husband",@"Mother",@"Mother-in-Law",@"Second Cousin",@"Sister",@"Sister-in-Law",@"Son",@"Uncle",@"Wife", nil];
}



-(NSArray *)clinicianTypeArray{
   return  [NSArray arrayWithObjects:@"Advanced Practicum Student",@"Case Manager",@"Licensed Associate Counselor",@"Licensed Professional Counselor",@"Licensed Social Worker",@"Master's Level Therapist (unlicensed)",@"Paraprofessional",@"Post-Doctorate Intern",@"Practicum Student",@"Pre-Doctorate Intern",@"Psychiatric Nurse Practicioner",@"Psychiatric Physician's Assistant",@"Psychiatrist",@"Psychologist",@"Technician", nil];
}


-(void)prepopulate{

    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    if (!assessmentTypeArray_) {
        assessmentTypeArray_=[self assessmentTypeArray];
    }
    for (NSString * textToAdd in assessmentTypeArray_) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"AssessmentTypeEntity" inManagedObjectContext:managedObjectContext];
        
        if (![self existsInEntity:entity fieldStr:@"assessmentType" populateStr:textToAdd]) {
            AssessmentTypeEntity *newType=[[AssessmentTypeEntity alloc]initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
            
            newType.assessmentType=textToAdd.copy;
        }
        
    }
    assessmentTypeArray_=nil;
    if (!interventionTypeArray_) {
        interventionTypeArray_=[self interventionTypeArray];
    }
    
    for (NSString * textToAdd in interventionTypeArray_) {
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"InterventionTypeEntity" inManagedObjectContext:managedObjectContext];
        
        if (![self existsInEntity:entity fieldStr:@"interventionType" populateStr:textToAdd]) {
        InterventionTypeEntity *newType=[[InterventionTypeEntity alloc]initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
        
        newType.interventionType=textToAdd.copy;
           NSUInteger integerOfObject= [interventionTypeArray_ indexOfObject:textToAdd];
            
            //:@"Individual Therapy/Counseling", @"Group Therapy/Counseling",@"Family and Couples Therapy/Counseling",@"Other Psychological Interventions"
            
            
            
            if (!interventionTypeSubtypeArray_) {
                interventionTypeSubtypeArray_=[self interventionTypeSubtypeArray];
            }
            
            
                    
                    switch (integerOfObject) {
                        case 0:
                        {
                            NSArray *subtypeArray=[self subtypesForInterventionIndividual];
                            for (NSString * textToAddToSubType in subtypeArray) {
                               
                                   
                                    NSEntityDescription *entityOfSubtype = [NSEntityDescription entityForName:@"InterventionTypeSubtypeEntity" inManagedObjectContext:managedObjectContext];
                                    
                                
                                        
                                        
                                        InterventionTypeSubtypeEntity *newSubType=[[InterventionTypeSubtypeEntity alloc]initWithEntity:entityOfSubtype insertIntoManagedObjectContext:managedObjectContext];
                                        
                                        newSubType.interventionSubType=textToAddToSubType.copy;
                                        newSubType.interventionType=newType;
                                        

                                }
                            }
                            break;
                        case 1:
                        {
                            NSArray *subtypeArray=[self subtypesForInterventionGroup];
                            for (NSString * textToAddToSubType in subtypeArray) {
                                
                                
                                NSEntityDescription *entityOfSubtype = [NSEntityDescription entityForName:@"InterventionTypeSubtypeEntity" inManagedObjectContext:managedObjectContext];
                                
                                
                                
                                
                                InterventionTypeSubtypeEntity *newSubType=[[InterventionTypeSubtypeEntity alloc]initWithEntity:entityOfSubtype insertIntoManagedObjectContext:managedObjectContext];
                                
                                newSubType.interventionSubType=textToAddToSubType.copy;
                                newSubType.interventionType=newType;
                                
                                
                            }
                        }
    
                            break;
                        case 2:
                        {
                            NSArray *subtypeArray=[self subtypesForInterventionFamily];
                            for (NSString * textToAddToSubType in subtypeArray) {
                                
                                
                                NSEntityDescription *entityOfSubtype = [NSEntityDescription entityForName:@"InterventionTypeSubtypeEntity" inManagedObjectContext:managedObjectContext];
                                
                                
                                
                                
                                InterventionTypeSubtypeEntity *newSubType=[[InterventionTypeSubtypeEntity alloc]initWithEntity:entityOfSubtype insertIntoManagedObjectContext:managedObjectContext];
                                
                                newSubType.interventionSubType=textToAddToSubType.copy;
                                newSubType.interventionType=newType;
                                
                                
                            }
                        }
                            
                            break;
                        case 3:
                        {
                            NSArray *subtypeArray=[self subtypesForInterventionOther];
                            for (NSString * textToAddToSubType in subtypeArray) {
                                
                                
                                NSEntityDescription *entityOfSubtype = [NSEntityDescription entityForName:@"InterventionTypeSubtypeEntity" inManagedObjectContext:managedObjectContext];
                                
                                
                                
                                
                                InterventionTypeSubtypeEntity *newSubType=[[InterventionTypeSubtypeEntity alloc]initWithEntity:entityOfSubtype insertIntoManagedObjectContext:managedObjectContext];
                                
                                newSubType.interventionSubType=textToAddToSubType.copy;
                                newSubType.interventionType=newType;
                                
                                
                            }
                        }
                            
                            break;
                            
                        default:
                            break;
                    }

                    
        
            }
            interventionTypeSubtypeArray_=nil;

            
      
    }
    interventionTypeArray_=nil;
    
    
 
    
    
    if (!supportActivityTypeArray_) {
        supportActivityTypeArray_=[self supportActivityTypeArray];
    }
    for (NSString * textToAdd in supportActivityTypeArray_) {
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"SupportActivityTypeEntity" inManagedObjectContext:managedObjectContext];
        
        if (![self existsInEntity:entity fieldStr:@"supportActivityType" populateStr:textToAdd]) {
            
        SupportActivityTypeEntity *newType=[[SupportActivityTypeEntity alloc]initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
        
        newType.supportActivityType=textToAdd.copy;
        
        }
       
    }
    supportActivityTypeArray_=nil;
    
    if (!supervisionTypeArray_) {
        supervisionTypeArray_=[self supervisionTypeArray];
    }
    
    for (NSString * textToAdd in supervisionTypeArray_) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"SupervisionTypeEntity" inManagedObjectContext:managedObjectContext];
        
        if (![self existsInEntity:entity fieldStr:@"supervisionType" populateStr:textToAdd]) {
            
        SupervisionTypeEntity *newType=[[SupervisionTypeEntity alloc]initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
        
        newType.supervisionType=textToAdd.copy;
            
            if (!supervisionTypeSubtypeArray_) {
                supervisionTypeSubtypeArray_=[self supervisionTypeSubtypeArray];
            }
            for (NSString * subTextToAdd in supervisionTypeSubtypeArray_) {
                
                NSEntityDescription *subTypeEntity = [NSEntityDescription entityForName:@"SupervisionTypeSubtypeEntity" inManagedObjectContext:managedObjectContext];
                
                SupervisionTypeSubtypeEntity *newSubType=[[SupervisionTypeSubtypeEntity alloc]initWithEntity:subTypeEntity insertIntoManagedObjectContext:managedObjectContext];
                    
                newSubType.subType=subTextToAdd.copy;
                newSubType.supervisionType=newType;
            }
            
        
        }
       
    }
    supervisionTypeArray_=nil;
    
    
    supervisionTypeSubtypeArray_=nil;
    
    if (!genderArray_) {
        genderArray_=[self genderArray];
    }
    for (NSString * textToAdd in genderArray_) {
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"GenderEntity" inManagedObjectContext:managedObjectContext];
        if (![self existsInEntity:entity fieldStr:@"genderName" populateStr:textToAdd]) {
            
            GenderEntity *newType=[[GenderEntity alloc]initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
            
            newType.genderName=textToAdd.copy;
        }
    }
    genderArray_=nil;
    
    if (!educationLevelArray_) {
        educationLevelArray_=[self educationLevelArray];
    }
    for (NSString * textToAdd in educationLevelArray_) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"EducationLevelEntity" inManagedObjectContext:managedObjectContext];
        if (![self existsInEntity:entity fieldStr:@"educationLevel" populateStr:textToAdd]) {
            
            EducationLevelEntity *newType=[[EducationLevelEntity alloc]initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
            
            newType.educationLevel=textToAdd.copy;
        }

       
    }
    educationLevelArray_=nil;
    
    
    if (!employmentStatusArray_) {
        employmentStatusArray_=[self employmentStatusArray];
    }
    
    for (NSString * textToAdd in employmentStatusArray_) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"EmploymentStatusEntity" inManagedObjectContext:managedObjectContext];
        if (![self existsInEntity:entity fieldStr:@"employmentStatus" populateStr:textToAdd]) {
            
            EmploymentStatusEntity *newType=[[EmploymentStatusEntity alloc]initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
            
            newType.employmentStatus=textToAdd.copy;
        }
        

       
    }
    employmentStatusArray_=nil;
    
    if (!relationshipArray_) {
        relationshipArray_=[self relationshipArray];
    }
    
    for (NSString * textToAdd in relationshipArray_) {
       
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"RelationshipEntity" inManagedObjectContext:managedObjectContext];
        if (![self existsInEntity:entity fieldStr:@"relationship" populateStr:textToAdd]) {
            
            RelationshipEntity *newType=[[RelationshipEntity alloc]initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
            
            newType.relationship=textToAdd.copy;
        }
        
        

        
       
    }
    relationshipArray_=nil;
    
    if (!clinicianTypeArray_) {
        clinicianTypeArray_=[self clinicianTypeArray];
    }
    
    for (NSString * textToAdd in clinicianTypeArray_) {
       
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ClinicianTypeEntity" inManagedObjectContext:managedObjectContext];
        if (![self existsInEntity:entity fieldStr:@"clinicianType" populateStr:textToAdd]) {
            
            ClinicianTypeEntity *newType=[[ClinicianTypeEntity alloc]initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
            
            newType.clinicianType=textToAdd.copy;
        }
        
        
       
    }
    clinicianTypeArray_=nil;




}


-(void)removeDuplicatePrepopulatedData{
    

    if (!assessmentTypeArray_) {
        assessmentTypeArray_=[self assessmentTypeArray];
    }
    for (NSString * checkText in assessmentTypeArray_) {
         [self checkEntityStr:@"AssessmentTypeEntity" checkFieldNameStr:@"assessmentType" checkTextStr:checkText];
    }
    assessmentTypeArray_=nil;
    if (!interventionTypeArray_) {
        interventionTypeArray_=[self interventionTypeArray];
    }
    
    for (NSString * checkText in interventionTypeArray_) {
        [self checkEntityStr:@"InterventionTypeEntity" checkFieldNameStr:@"interventionType" checkTextStr:checkText];
    }
    interventionTypeArray_=nil;
    if (!interventionTypeSubtypeArray_) {
        interventionTypeSubtypeArray_=[self interventionTypeSubtypeArray];
    }
    
    for (NSString * checkText in interventionTypeSubtypeArray_) {
        [self checkEntityStr:@"InterventionTypeSubtypeEntity" checkFieldNameStr:@"interventionSubType" checkTextStr:checkText];
    }
    interventionTypeSubtypeArray_=nil;
    
    if (!supportActivityTypeArray_) {
        supportActivityTypeArray_=[self supportActivityTypeArray];
    }
    for (NSString * checkText in supportActivityTypeArray_) {
        [self checkEntityStr:@"SupportActivityTypeEntity" checkFieldNameStr:@"supportActivityType" checkTextStr:checkText];
    }
    supportActivityTypeArray_=nil;
    
    if (!supervisionTypeArray_) {
        supervisionTypeArray_=[self supervisionTypeArray];
    }
    
    for (NSString * checkText in supervisionTypeArray_) {
        if ([checkText isEqualToString:@"Supervision By Other Licensed Mental Health Professional"]) {
            DLog(@"chektest %@",checkText);
        }
        [self checkEntityStr:@"SupervisionTypeEntity" checkFieldNameStr:@"supervisionType" checkTextStr:checkText];
    }
    supervisionTypeArray_=nil;
    
    if (!supervisionTypeSubtypeArray_) {
        supervisionTypeSubtypeArray_=[self supervisionTypeSubtypeArray];
    }
    for (NSString * checkText in supervisionTypeSubtypeArray_) {
        [self checkEntityStr:@"SupervisionTypeSubtypeEntity" checkFieldNameStr:@"subType" checkTextStr:checkText];
    }
    supervisionTypeSubtypeArray_=nil;
    
    if (!genderArray_) {
        genderArray_=[self genderArray];
    }
    for (NSString * checkText in genderArray_) {
        [self checkEntityStr:@"GenderEntity" checkFieldNameStr:@"genderName" checkTextStr:checkText];
    }
    genderArray_=nil;
    
    if (!educationLevelArray_) {
        educationLevelArray_=[self educationLevelArray];
    }
    for (NSString * checkText in educationLevelArray_) {
        [self checkEntityStr:@"EducationLevelEntity" checkFieldNameStr:@"educationLevel" checkTextStr:checkText];
    }
    educationLevelArray_=nil;
    
    
    if (!employmentStatusArray_) {
        employmentStatusArray_=[self employmentStatusArray];
    }
    
    for (NSString * checkText in employmentStatusArray_) {
        [self checkEntityStr:@"EmploymentStatusEntity" checkFieldNameStr:@"employmentStatus" checkTextStr:checkText];
    }
    employmentStatusArray_=nil;
    
    if (!relationshipArray_) {
        relationshipArray_=[self relationshipArray];
    }
    
    for (NSString * checkText in relationshipArray_) {
        [self checkEntityStr:@"RelationshipEntity" checkFieldNameStr:@"relationship" checkTextStr:checkText];
    }
    relationshipArray_=nil;
    
    if (!clinicianTypeArray_) {
        clinicianTypeArray_=[self clinicianTypeArray];
    }
    
    for (NSString * checkText in clinicianTypeArray_) {
        [self checkEntityStr:@"ClinicianTypeEntity" checkFieldNameStr:@"clinicianType" checkTextStr:checkText];
    }
    clinicianTypeArray_=nil;
    
}

-(BOOL)existsInEntity:(NSEntityDescription *)entity fieldStr:(NSString *)fieldStr populateStr:(NSString *)populateStr{
    
    BOOL existsInEnity=NO;
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

[fetchRequest setEntity:entity];

NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K matches %@", fieldStr,populateStr];
[fetchRequest setPredicate:predicate];

NSError *error = nil;

    int count=[managedObjectContext countForFetchRequest:fetchRequest error:&error];
    
    if (count>0) {
        existsInEnity=YES;
    }
    
    
    return existsInEnity;
}


-(void)checkEntityStr:(NSString *)checkEntityStr checkFieldNameStr:(NSString *)checkFieldNameStr checkTextStr:(NSString *)checkTextStr{


    if (checkEntityStr && checkEntityStr.length &&checkFieldNameStr && checkFieldNameStr.length && checkTextStr && checkTextStr.length) {
       
        
        
        NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
       
       NSPredicate *predicate=[NSPredicate predicateWithFormat:@"%K == %@", checkFieldNameStr, checkTextStr];
        
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:checkEntityStr inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
        
       
        [fetchRequest setPredicate:predicate];
         NSError *error = nil;
        int count=[managedObjectContext countForFetchRequest:fetchRequest error:&error];
        
        if (count>1){
        
            NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
            if (fetchedObjects == nil) {
                
            }

            //Find records with associated time records
            NSMutableArray *objsWithAssociatedTimeRecords=[NSMutableArray array];
            NSMutableArray *objectsWithoutAssociatedTimeRecords=[NSMutableArray array];
            
            for (id obj in fetchedObjects) {
                if ([obj isKindOfClass:[AssessmentTypeEntity class]]) {
                    AssessmentTypeEntity *assessmentType=(AssessmentTypeEntity*)obj;
                    
                    if (assessmentType.associatedWithTimeRecords) {
                        [objsWithAssociatedTimeRecords addObject:obj];
                    }
                    else
                    {
                        [objectsWithoutAssociatedTimeRecords addObject:obj];
                    
                    }
                
                    
                    
                }
                
                if ([obj isKindOfClass:[InterventionTypeEntity class]]) {
                    InterventionTypeEntity *type=(InterventionTypeEntity*)obj;
                    
                    if (type.associatedWithTimeRecords) {
                        [objsWithAssociatedTimeRecords addObject:obj];
                    }
                    else
                    {
                        [objectsWithoutAssociatedTimeRecords addObject:obj];
                        
                    }
                    
                    
                    
                }
                if ([obj isKindOfClass:[InterventionTypeSubtypeEntity class]]) {
                    InterventionTypeSubtypeEntity *type=(InterventionTypeSubtypeEntity*)obj;
                    
                    if (type.associatedWithTimeRecords) {
                        [objsWithAssociatedTimeRecords addObject:obj];
                    }
                    else
                    {
                        [objectsWithoutAssociatedTimeRecords addObject:obj];
                        
                    }
                    
                    
                    
                }
                
                if ([obj isKindOfClass:[SupportActivityTypeEntity class]]) {
                    SupportActivityTypeEntity *type=(SupportActivityTypeEntity*)obj;
                    
                    if (type.associatedWithTimeRecords) {
                        [objsWithAssociatedTimeRecords addObject:obj];
                    }
                    else
                    {
                        [objectsWithoutAssociatedTimeRecords addObject:obj];
                        
                    }
                    
                    
                    
                }
                
                if ([obj isKindOfClass:[SupervisionTypeEntity class]]) {
                    SupervisionTypeEntity *type=(SupervisionTypeEntity*)obj;
                    
                    if (type.associatedWithTimeRecords) {
                        [objsWithAssociatedTimeRecords addObject:obj];
                    }
                    else
                    {
                        [objectsWithoutAssociatedTimeRecords addObject:obj];
                        
                    }
                    
                    
                    
                }
                
                if ([obj isKindOfClass:[SupervisionTypeSubtypeEntity class]]) {
                    SupervisionTypeSubtypeEntity *type=(SupervisionTypeSubtypeEntity*)obj;
                    
                    if (type.associatedWithTimeRecords) {
                        [objsWithAssociatedTimeRecords addObject:obj];
                    }
                    else
                    {
                        [objectsWithoutAssociatedTimeRecords addObject:obj];
                        
                    }
                    
                    
                    
                }
                
                if ([obj isKindOfClass:[GenderEntity class]]) {
                    GenderEntity *type=(GenderEntity*)obj;
                    
                    if (type.associatedWithTimeRecords) {
                        [objsWithAssociatedTimeRecords addObject:obj];
                    }
                    else
                    {
                        [objectsWithoutAssociatedTimeRecords addObject:obj];
                        
                    }
                    
                    
                    
                }
                
                if ([obj isKindOfClass:[EducationLevelEntity class]]) {
                    EducationLevelEntity *type=(EducationLevelEntity*)obj;
                    
                    if (type.associatedWithTimeRecords) {
                        [objsWithAssociatedTimeRecords addObject:obj];
                    }
                    else
                    {
                        [objectsWithoutAssociatedTimeRecords addObject:obj];
                        
                    }
                    
                    
                    
                }
                
                if ([obj isKindOfClass:[EmploymentStatusEntity class]]) {
                    EmploymentStatusEntity *type=(EmploymentStatusEntity*)obj;
                    
                    if (type.associatedWithTimeRecords) {
                        [objsWithAssociatedTimeRecords addObject:obj];
                    }
                    else
                    {
                        [objectsWithoutAssociatedTimeRecords addObject:obj];
                        
                    }
                    
                    
                    
                }
                
                if ([obj isKindOfClass:[RelationshipEntity class]]) {
                    RelationshipEntity *type=(RelationshipEntity*)obj;
                    
                    if (type.associatedWithTimeRecords) {
                        [objsWithAssociatedTimeRecords addObject:obj];
                    }
                    else
                    {
                        [objectsWithoutAssociatedTimeRecords addObject:obj];
                        
                    }
                    
                    
                    
                }
                
                if ([obj isKindOfClass:[ClinicianTypeEntity class]]) {
                    ClinicianTypeEntity *type=(ClinicianTypeEntity*)obj;
                    
                    if (type.associatedWithTimeRecords) {
                        [objsWithAssociatedTimeRecords addObject:obj];
                    }
                    else
                    {
                        [objectsWithoutAssociatedTimeRecords addObject:obj];
                        
                    }
                    
                    
                    
                }
                
                
                
            }
            
             NSMutableArray *deleteExtrasContainingSet=[NSMutableArray array];
           
            NSArray *withoutArray=[NSArray arrayWithArray: objectsWithoutAssociatedTimeRecords];
            if (objectsWithoutAssociatedTimeRecords.count && objsWithAssociatedTimeRecords.count) {
                
                for (id objInObjectsWithoutAssociatedTimeRecords in withoutArray ) {
                    if (![objInObjectsWithoutAssociatedTimeRecords isKindOfClass:[SupervisionTypeSubtypeEntity class]]&&![objInObjectsWithoutAssociatedTimeRecords isKindOfClass:[InterventionTypeSubtypeEntity class]]) {
                         [managedObjectContext deleteObject:objInObjectsWithoutAssociatedTimeRecords];
                    }
                   
                }
                
            }
            if (objsWithAssociatedTimeRecords.count) {
                
                
                id objToKeep =[objsWithAssociatedTimeRecords objectAtIndex:0];
                
                for (int i=0; i<objsWithAssociatedTimeRecords.count; i++) {
                  
                   
                    
                    id objectInArray = [objsWithAssociatedTimeRecords objectAtIndex:i];
                    if (i>0) {
                            if ([objectInArray isKindOfClass:[AssessmentTypeEntity class]]) {
                            AssessmentTypeEntity *assessmentType=(AssessmentTypeEntity*)objectInArray;
                            
                            [assessmentType willAccessValueForKey:@"assessments"];
                            
                            NSSet *assessmentSet= assessmentType.assessments;
                           
                            NSArray *assessmentArray=assessmentSet.allObjects;
                            for (id item in assessmentArray) {
                                if ([item isKindOfClass:[AssessmentEntity class]]) {
                                    AssessmentEntity *assessmentEntity=(AssessmentEntity *)item;
                                    
                                    [assessmentEntity willChangeValueForKey:@"assessmentType"];
                                    assessmentEntity.assessmentType=objToKeep;
                                    [assessmentEntity didChangeValueForKey:@"assessmentType"];
                                    
                                    [managedObjectContext deleteObject:objectInArray];
                                }
                            }
                            
                             [assessmentType didAccessValueForKey:@"assessments"];
                        }

                       
                        
                        else if ([objectInArray isKindOfClass:[InterventionTypeEntity class]]) {
                            InterventionTypeEntity *type=(InterventionTypeEntity*)objectInArray;
                            
                            [type willAccessValueForKey:@"interventionType"];
                            
                            [deleteExtrasContainingSet addObject:type.interventionType];
                            
                            [type willAccessValueForKey:@"interventionsDelivered"];
                            [type willAccessValueForKey:@"existingInterventions"];
                            
                            NSSet *typeSet= type.interventionsDelivered;
                           
                            
                            NSArray *typeArray=typeSet.allObjects;
                            for (id item in typeArray) {
                                
                                if ([item isKindOfClass:[InterventionDeliveredEntity class]]) {
                                    
                                    InterventionDeliveredEntity *interventionDeliveredEntity=(InterventionDeliveredEntity *)item;
                                    
                                    [interventionDeliveredEntity willAccessValueForKey:@"interventionType"];
                                    [interventionDeliveredEntity willAccessValueForKey:@"subtype"];
                                    
                                    [interventionDeliveredEntity.subtype willAccessValueForKey:@"interventionSubType"];
                                    
                                    
                                    
                                    NSString *interventionTypeSubtypStr=interventionDeliveredEntity.subtype.interventionSubType.copy;
                                    
                                    
                                    
                                    
                                    NSPredicate *filterSubtypes=[NSPredicate predicateWithFormat:@"self.interventionSubType == %@",interventionTypeSubtypStr];
                                    
                                    
                                    
                                    
                                    [type willAccessValueForKey:@"subTypes"];
                                    NSSet *typeSubtypes=type.subTypes;
                                    
                                    InterventionTypeEntity *objToKeepInterventionType=(InterventionTypeEntity *)objToKeep;
                                    [objToKeepInterventionType willAccessValueForKey:@"subTypes"];
                                    NSSet *objToKeepSubtypes=objToKeepInterventionType.subTypes;
                                    
                                    
                                    
                                    for (InterventionTypeSubtypeEntity *intvSubType in typeSubtypes) {
                                        
                                        
                                        NSSet *objectToKeepSubtypeEquivalents=[objToKeepSubtypes filteredSetUsingPredicate:filterSubtypes];
                                        
                                        if (objectToKeepSubtypeEquivalents.count) {
                                            InterventionTypeSubtypeEntity *firstEquivalent=[objectToKeepSubtypeEquivalents.allObjects objectAtIndex:0];
                                            [intvSubType willAccessValueForKey:@"interventionsDelivered"];
                                            NSSet *intvSubTypeInterventionDeliveredSet=intvSubType.interventionsDelivered;
                                            NSArray *intvSubTypeInterventionDeliveredArray=intvSubTypeInterventionDeliveredSet.allObjects;
                                            
                                            
                                            for (InterventionDeliveredEntity *interventionDvrd in intvSubTypeInterventionDeliveredArray) {
                                                
                                                if ([interventionDvrd.subtype.interventionSubType isEqualToString:firstEquivalent.interventionSubType]) {
                                                    
                                                    [interventionDvrd willAccessValueForKey:@"interventionType"];
                                                    [interventionDvrd willAccessValueForKey:@"subtype"];
                                                    
                                                    InterventionTypeEntity *potentialDelete=nil;
                                                    if ([fetchedObjects containsObject:interventionDvrd.interventionType]) {
                                                        potentialDelete=(InterventionTypeEntity*)[fetchedObjects objectAtIndex: [fetchedObjects indexOfObject: interventionDvrd.interventionType]];
                                                        
                                                        [potentialDelete willAccessValueForKey:@"interventionType"];
                                                        
                                                        [deleteExtrasContainingSet addObject:potentialDelete.interventionType];
                                                        
                                                    }
                                                    
                                                    
                                                    
                                                    
                                                    [interventionDvrd willChangeValueForKey:@"subtype"];
                                                    interventionDvrd.subtype=firstEquivalent;
                                                    [interventionDvrd didChangeValueForKey:@"subtype"];
                                                    
                                                    
                                                    
                                                    
                                                    [interventionDvrd willChangeValueForKey:@"interventionType"];
                                                    interventionDvrd.interventionType=objToKeepInterventionType;
                                                    [interventionDvrd didChangeValueForKey:@"interventionType"];
                                                    
                                                    
                                                    
                                                    
                                                    [potentialDelete willAccessValueForKey:@"interventionDelivered"];
                                                    
                                                    
                                                    [potentialDelete willAccessValueForKey:@"existingInterventions"];
                                                
                                                    
                                                    
                                                    
                                                    if (potentialDelete && !potentialDelete.interventionsDelivered.count &&!potentialDelete.existingInterventions.count ) {
                                                        
                                                        [managedObjectContext deleteObject:potentialDelete];
                                                    }
                                                    
                                                    
                                                    
                                                }
                                            }
                                            [intvSubType willAccessValueForKey:@"existingInterventions"];
                                            NSSet *intvSubTypeExistingInterventionsSet=intvSubType.existingInterventions;
                                            NSArray *intvSubTypeExistingInterventionsArray=intvSubTypeExistingInterventionsSet.allObjects;
                                            
                                            
                                            for (ExistingInterventionEntity *existingItvs in intvSubTypeExistingInterventionsArray) {
                                                
                                                if ([existingItvs.interventionSubType.interventionSubType isEqualToString:firstEquivalent.interventionSubType]) {
                                                    
                                                    [existingItvs willAccessValueForKey:@"interventionType"];
                                                    [existingItvs willAccessValueForKey:@"interventionSubType"];
                                                    
                                                    InterventionTypeEntity *potentialDelete=nil;
                                                    if ([fetchedObjects containsObject:existingItvs.interventionType]) {
                                                        potentialDelete=(InterventionTypeEntity*)[fetchedObjects objectAtIndex: [fetchedObjects indexOfObject: existingItvs.interventionType]];
                                                        
                                                        [potentialDelete willAccessValueForKey:@"interventionType"];
                                                        
                                                        [deleteExtrasContainingSet addObject:potentialDelete.interventionType];
                                                        
                                                    }
                                                    
                                                    
                                                    
                                                    
                                                    [existingItvs willChangeValueForKey:@"interventionSubType"];
                                                    existingItvs.interventionSubType=firstEquivalent;
                                                    [existingItvs didChangeValueForKey:@"interventionSubType"];
                                                    
                                                    
                                                    
                                                    
                                                    [existingItvs willChangeValueForKey:@"interventionType"];
                                                    existingItvs.interventionType=objToKeepInterventionType;
                                                    [existingItvs didChangeValueForKey:@"interventionType"];
                                                    
                                                    
                                                    
                                                    
                                                    [potentialDelete willAccessValueForKey:@"interventionDelivered"];
                                                    
                                                    
                                                    [potentialDelete willAccessValueForKey:@"existingInterventions"];
                                                    
                                                    
                                                    
                                                    
                                                    if (potentialDelete && !potentialDelete.interventionsDelivered.count &&!potentialDelete.existingInterventions.count ) {
                                                        
                                                        [managedObjectContext deleteObject:potentialDelete];
                                                    }
                                                    
                                                    
                                                    
                                                }
                                            }
                                            

                                            
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                    
                                }}}

                       else if ([objectInArray isKindOfClass:[SupportActivityTypeEntity class]]) {
                            SupportActivityTypeEntity *type=(SupportActivityTypeEntity*)objectInArray;
                            
                            [type willAccessValueForKey:@"supportActivitiesDelivered"];
                            
                            NSSet *typeSet= type.supportActivitiesDelivered;
                           
                           NSArray *typeArray=typeSet.allObjects;
                           for (id item in typeArray) {

                            
                                if ([item isKindOfClass:[SupportActivityDeliveredEntity class]]) {
                                    SupportActivityDeliveredEntity *supportActivityDeliveredEntity=(SupportActivityDeliveredEntity *)item;
                                    
                                    [supportActivityDeliveredEntity willChangeValueForKey:@"supportActivityType"];
                                    supportActivityDeliveredEntity.supportActivityType=objToKeep;
                                    [supportActivityDeliveredEntity didChangeValueForKey:@"supportActivityType"];
                                    
                                    [managedObjectContext deleteObject:objectInArray];
                                }
                            }
                            
                            [type didAccessValueForKey:@"supportActivitiesDelivered"];
                        }
                        else if ([objectInArray isKindOfClass:[SupervisionTypeEntity class]]) {
                            SupervisionTypeEntity *type=(SupervisionTypeEntity*)objectInArray;
                            
                            [type willAccessValueForKey:@"supervisionType"];
                           
                            [deleteExtrasContainingSet addObject:type.supervisionType];
                           
                            [type willAccessValueForKey:@"supervisionRecieved"];
                           [type willAccessValueForKey:@"supervisionGiven"];
                            
                            NSSet *typeSet= type.supervisionRecieved;
                           
                            NSArray *typeArray=typeSet.allObjects;
                            for (id item in typeArray) {

                                if ([item isKindOfClass:[SupervisionReceivedEntity class]]) {
                                    
                                    SupervisionReceivedEntity *supervisionRecievedEntity=(SupervisionReceivedEntity *)item;
                                    
                                    [supervisionRecievedEntity willAccessValueForKey:@"supervisionType"];
                                    [supervisionRecievedEntity willAccessValueForKey:@"subType"];

                                    [supervisionRecievedEntity.subType willAccessValueForKey:@"subType"];
                                    
                                    
                                    
                                    NSString *supervisionTypeSubtypStr=supervisionRecievedEntity.subType.subType.copy;
                                    
                                    
                                    
                                    
                                    NSPredicate *filterSubtypes=[NSPredicate predicateWithFormat:@"self.subType == %@",supervisionTypeSubtypStr];
                                    
                                    
                                    
                                    
                                    [type willAccessValueForKey:@"subTypes"];
                                    NSSet *typeSubtypes=type.subTypes;
                                    
                                    SupervisionTypeEntity *objToKeepSupervisionType=(SupervisionTypeEntity *)objToKeep;
                                    [objToKeepSupervisionType willAccessValueForKey:@"subTypes"];
                                    NSSet *objToKeepSubtypes=objToKeepSupervisionType.subTypes;
                                    
                                   
                                   
                                    for (SupervisionTypeSubtypeEntity *supSubType in typeSubtypes) {
                                        
                                        
                                        NSSet *objectToKeepSubtypeEquivalents=[objToKeepSubtypes filteredSetUsingPredicate:filterSubtypes];
                                        
                                        if (objectToKeepSubtypeEquivalents.count) {
                                            SupervisionTypeSubtypeEntity *firstEquivalent=[objectToKeepSubtypeEquivalents.allObjects objectAtIndex:0];
                                            
                                            [supSubType willAccessValueForKey:@"supervisionReceived"];
                                            NSSet *supSubTypeSupervisionReceivedSet=supSubType.supervisionReceived;
                                            NSArray *supSubTypeSupervisionReceivedArray=supSubTypeSupervisionReceivedSet.allObjects;
                                            

                                                for (SupervisionReceivedEntity *supervisionRcvd in supSubTypeSupervisionReceivedArray) {
                                                    
                                                    if ([supervisionRcvd.subType.subType isEqualToString:firstEquivalent.subType]) {
                                                       
                                                        [supervisionRcvd willAccessValueForKey:@"supervisionType"];
                                                        [supervisionRcvd willAccessValueForKey:@"subType"];
                                                        
                                                        SupervisionTypeEntity *potentialDelete=nil;
                                                        if ([fetchedObjects containsObject:supervisionRcvd.supervisionType]) {
                                                            potentialDelete=(SupervisionTypeEntity*)[fetchedObjects objectAtIndex: [fetchedObjects indexOfObject: supervisionRcvd.supervisionType]];
                                                            
                                                            [potentialDelete willAccessValueForKey:@"supervisionType"];
                                                            
                                                            [deleteExtrasContainingSet addObject:potentialDelete.supervisionType];
                                                          
                                                        }
                                                        
                                                       
                                                        
                                                        
                                                        [supervisionRcvd willChangeValueForKey:@"subType"];
                                                        supervisionRcvd.subType=firstEquivalent;
                                                        [supervisionRcvd didChangeValueForKey:@"subType"];
                                                        
                                                        
                                                        
                                                        
                                                        [supervisionRcvd willChangeValueForKey:@"supervisionType"];
                                                        supervisionRcvd.supervisionType=objToKeepSupervisionType;
                                                        [supervisionRcvd didChangeValueForKey:@"supervisionType"];
                                                        
                                                        
                                                        
                                                        
                                                        [potentialDelete willAccessValueForKey:@"supervisionRecieved"];
                                                        [potentialDelete willAccessValueForKey:@"supervisionGiven"];
                                                        
                                                        [potentialDelete willAccessValueForKey:@"existingSupervision"];
                                                        
                                                        
                                                        
                                                        
                                                        if (potentialDelete && !potentialDelete.supervisionRecieved.count &&!potentialDelete.supervisionGiven.count && !potentialDelete.existingSupervision.count) {
                                                            
                                                            [managedObjectContext deleteObject:potentialDelete];
                                                        }
                                                        
                                                        

                                                    }
                                                }
                                            [supSubType willAccessValueForKey:@"supervisonGiven"];
                                            NSSet *supSubTypeSupervisionGivenSet=supSubType.supervisionGiven;
                                            
                                            NSArray *supSubTypeSupervisionGivenArray=supSubTypeSupervisionGivenSet.allObjects;
                                           

                                            for (SupervisionGivenEntity *supervisionGvn in supSubTypeSupervisionGivenArray) {
                                                
                                                if ([supervisionGvn.subType.subType isEqualToString:firstEquivalent.subType]) {
                                                    
                                                    [supervisionGvn willAccessValueForKey:@"supervisionType"];
                                                    [supervisionGvn willAccessValueForKey:@"subType"];
                                                    
                                                    SupervisionTypeEntity *potentialDelete=nil;
                                                    if ([fetchedObjects containsObject:supervisionGvn.supervisionType]) {
                                                        potentialDelete=[fetchedObjects objectAtIndex: [fetchedObjects indexOfObject: supervisionGvn.supervisionType]];
                                                    
                                                        
                                                        [potentialDelete willAccessValueForKey:@"supervisionType"];
                                                        [deleteExtrasContainingSet addObject:potentialDelete.supervisionType];
                                                    }
                                                    
                                                   

                                                    [supervisionGvn willChangeValueForKey:@"subType"];
                                                    supervisionGvn.subType=firstEquivalent;
                                                    [supervisionGvn didChangeValueForKey:@"subType"];
                                                    
                                                   
                                                    
                                                    [supervisionGvn willChangeValueForKey:@"supervisionType"];
                                                    supervisionGvn.supervisionType=objToKeepSupervisionType;
                                                    [supervisionGvn didChangeValueForKey:@"supervisionType"];
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    [potentialDelete willAccessValueForKey:@"supervisionRecieved"];
                                                    [potentialDelete willAccessValueForKey:@"supervisionGiven"];
                                                    
                                                    [potentialDelete willAccessValueForKey:@"existingSupervision"];
                                                    
                                                    
                                                    
                                                    
                                                    if (!potentialDelete.supervisionRecieved.count &&!potentialDelete.supervisionGiven.count && !potentialDelete.existingSupervision.count) {
                                                        DLog(@"deleting supsubtype %@",potentialDelete);
                                                        [managedObjectContext deleteObject:potentialDelete];
                                                    }
                                                    
                                                    

                                                }
                                            }
                                            
                                            [supSubType willAccessValueForKey:@"existingSupervision"];
                                            NSSet *supSubTypeExistingSupervisionSet=supSubType.existingSupervision;
                                            NSArray *supSubTypeExistingSupervisionArray=supSubTypeExistingSupervisionSet.allObjects;
                                            
                                            
                                            for (SupervisionReceivedEntity *existingSpv in supSubTypeExistingSupervisionArray) {
                                                
                                                if ([existingSpv.subType.subType isEqualToString:firstEquivalent.subType]) {
                                                    
                                                    [existingSpv willAccessValueForKey:@"supervisionType"];
                                                    [existingSpv willAccessValueForKey:@"subType"];
                                                    
                                                    SupervisionTypeEntity *potentialDelete=nil;
                                                    if ([fetchedObjects containsObject:existingSpv.supervisionType]) {
                                                        potentialDelete=(SupervisionTypeEntity*)[fetchedObjects objectAtIndex: [fetchedObjects indexOfObject: existingSpv.supervisionType]];
                                                        
                                                        [potentialDelete willAccessValueForKey:@"supervisionType"];
                                                        
                                                        [deleteExtrasContainingSet addObject:potentialDelete.supervisionType];
                                                        
                                                    }
                                                    
                                                    
                                                    
                                                    
                                                    [existingSpv willChangeValueForKey:@"subType"];
                                                    existingSpv.subType=firstEquivalent;
                                                    [existingSpv didChangeValueForKey:@"subType"];
                                                    
                                                    
                                                    
                                                    
                                                    [existingSpv willChangeValueForKey:@"supervisionType"];
                                                    existingSpv.supervisionType=objToKeepSupervisionType;
                                                    [existingSpv didChangeValueForKey:@"supervisionType"];
                                                    
                                                    
                                                    
                                                    
                                                    [potentialDelete willAccessValueForKey:@"supervisionRecieved"];
                                                    [potentialDelete willAccessValueForKey:@"supervisionGiven"];
                                                    
                                                    [potentialDelete willAccessValueForKey:@"existingSupervision"];
                                                    
                                                    
                                                    
                                                    
                                                    if (potentialDelete && !potentialDelete.supervisionRecieved.count &&!potentialDelete.supervisionGiven.count && !potentialDelete.existingSupervision.count) {
                                                        
                                                        [managedObjectContext deleteObject:potentialDelete];
                                                    }
                                                    
                                                    
                                                    
                                                }
                                            }

                                            
                                            
                                        }
                                        
                                        
                                    }
                                    
                                   
                                    
                                    
                                    
                                }
                                NSSet *typeSetGiven= type.supervisionGiven;
                                NSArray *typeArrayGiven=typeSetGiven.allObjects;
                                for (id item in typeArrayGiven) {
                                    if ([item isKindOfClass:[SupervisionGivenEntity class]]) {
                                        
                                        SupervisionGivenEntity *supervisionGivenEntity=(SupervisionGivenEntity *)item;
                                        
                                        [supervisionGivenEntity willAccessValueForKey:@"supervisionType"];
                                        [supervisionGivenEntity willAccessValueForKey:@"subType"];
                                        
                                        [supervisionGivenEntity.subType willAccessValueForKey:@"subType"];
                                        
                                        
                                        
                                        NSString *supervisionTypeSubtypStr=supervisionGivenEntity.subType.subType.copy;
                                        
                                        
                                        
                                        
                                        NSPredicate *filterSubtypes=[NSPredicate predicateWithFormat:@"self.subType == %@",supervisionTypeSubtypStr];
                                        
                                        
                                        
                                        
                                        [type willAccessValueForKey:@"subTypes"];
                                        NSSet *typeSubtypes=type.subTypes;
                                        
                                        SupervisionTypeEntity *objToKeepSupervisionType=(SupervisionTypeEntity *)objToKeep;
                                        [objToKeepSupervisionType willAccessValueForKey:@"subTypes"];
                                        NSSet *objToKeepSubtypes=objToKeepSupervisionType.subTypes;
                                        
                                        
                                        NSArray *typeSubtypesArray=typeSubtypes.allObjects;
                                        
                                        
                                        for (SupervisionTypeSubtypeEntity *supSubType in typeSubtypesArray) {
                                            
                                            
                                            NSSet *objectToKeepSubtypeEquivalents=[objToKeepSubtypes filteredSetUsingPredicate:filterSubtypes];
                                            
                                            if (objectToKeepSubtypeEquivalents.count) {
                                                SupervisionTypeSubtypeEntity *firstEquivalent=[objectToKeepSubtypeEquivalents.allObjects objectAtIndex:0];
                                                [supSubType willAccessValueForKey:@"supervisionReceived"];
                                                NSSet *supSubTypeSupervisionReceivedSet=supSubType.supervisionReceived;
                                                
                                                NSArray *supSubTypeSupervisionReceivedArray=supSubTypeSupervisionReceivedSet.allObjects;
                                                for (SupervisionReceivedEntity *supervisionRcvd in supSubTypeSupervisionReceivedArray) {
                                                    
                                                    if ([supervisionRcvd.subType.subType isEqualToString:firstEquivalent.subType]) {
                                                        
                                                        [supervisionRcvd willAccessValueForKey:@"supervisionType"];
                                                        [supervisionRcvd willAccessValueForKey:@"subType"];
                                                        
                                                        SupervisionTypeEntity *potentialDelete=nil;
                                                        if ([fetchedObjects containsObject:supervisionRcvd.supervisionType]) {
                                                            potentialDelete=[fetchedObjects objectAtIndex: [fetchedObjects indexOfObject: supervisionRcvd.supervisionType]];
                                                        
                                                            [potentialDelete willAccessValueForKey:@"supervisionType"];
                                                            [deleteExtrasContainingSet addObject:potentialDelete.supervisionType];
                                                        }
                                                        
                                                        
                                                        [supervisionRcvd willChangeValueForKey:@"subType"];
                                                        supervisionRcvd.subType=firstEquivalent;
                                                        [supervisionRcvd didChangeValueForKey:@"subType"];
                                                        
                                                        
                                                        
                                                        
                                                        [supervisionRcvd willChangeValueForKey:@"supervisionType"];
                                                        supervisionRcvd.supervisionType=objToKeepSupervisionType;
                                                        [supervisionRcvd didChangeValueForKey:@"supervisionType"];
                                                        
                                                        
                                                        
                                                        
                                                        [potentialDelete willAccessValueForKey:@"supervisionRecieved"];
                                                        [potentialDelete willAccessValueForKey:@"supervisionGiven"];
                                                        
                                                        [potentialDelete willAccessValueForKey:@"existingSupervision"];
                                                        
                                                        
                                                        
                                                        
                                                        if (potentialDelete && !potentialDelete.supervisionRecieved.count &&!potentialDelete.supervisionGiven.count && !potentialDelete.existingSupervision.count) {
                                                            
                                                            [managedObjectContext deleteObject:potentialDelete];
                                                        }
                                                        
                                                        
                                                    }
                                                }
                                                [supSubType willAccessValueForKey:@"supervisonGiven"];
                                                NSSet *supSubTypeSupervisionGivenSet=supSubType.supervisionGiven;
                                                NSArray *supSubTypeSupervisionGivenArray=supSubTypeSupervisionGivenSet.allObjects;
                                                for (SupervisionGivenEntity *supervisionGvn in supSubTypeSupervisionGivenArray) {
                                                    
                                                    if ([supervisionGvn.subType.subType isEqualToString:firstEquivalent.subType]) {
                                                        
                                                        [supervisionGvn willAccessValueForKey:@"supervisionType"];
                                                        [supervisionGvn willAccessValueForKey:@"subType"];
                                                        
                                                        SupervisionTypeEntity *potentialDelete=nil;
                                                        if ([fetchedObjects containsObject:supervisionGvn.supervisionType]) {
                                                            potentialDelete=[fetchedObjects objectAtIndex: [fetchedObjects indexOfObject: supervisionGvn.supervisionType]];
                                                            [potentialDelete willAccessValueForKey:@"supervisionType"];
                                                            [deleteExtrasContainingSet addObject:potentialDelete.supervisionType];
                                                        }
                                                        
                                                        
                                                        
                                                        [supervisionGvn willChangeValueForKey:@"subType"];
                                                        supervisionGvn.subType=firstEquivalent;
                                                        [supervisionGvn didChangeValueForKey:@"subType"];
                                                        
                                                        
                                                        
                                                        [supervisionGvn willChangeValueForKey:@"supervisionType"];
                                                        supervisionGvn.supervisionType=objToKeepSupervisionType;
                                                        [supervisionGvn didChangeValueForKey:@"supervisionType"];
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        [potentialDelete willAccessValueForKey:@"supervisionRecieved"];
                                                        [potentialDelete willAccessValueForKey:@"supervisionGiven"];
                                                        
                                                        [potentialDelete willAccessValueForKey:@"existingSupervision"];
                                                        
                                                        
                                                        
                                                        
                                                        if (!potentialDelete.supervisionRecieved.count &&!potentialDelete.supervisionGiven.count && !potentialDelete.existingSupervision.count) {
                                                           
                                                            [managedObjectContext deleteObject:potentialDelete];
                                                        }
                                                        
                                                        
                                                    }
                                                }
                                                [supSubType willAccessValueForKey:@"existingSupervision"];
                                                NSSet *supSubTypeExistingSupervisionSet=supSubType.existingSupervision;
                                                NSArray *supSubTypeExistingSupervisionArray=supSubTypeExistingSupervisionSet.allObjects;
                                                
                                                
                                                for (SupervisionReceivedEntity *existingSpv in supSubTypeExistingSupervisionArray) {
                                                    
                                                    if ([existingSpv.subType.subType isEqualToString:firstEquivalent.subType]) {
                                                        
                                                        [existingSpv willAccessValueForKey:@"supervisionType"];
                                                        [existingSpv willAccessValueForKey:@"subType"];
                                                        
                                                        SupervisionTypeEntity *potentialDelete=nil;
                                                        if ([fetchedObjects containsObject:existingSpv.supervisionType]) {
                                                            potentialDelete=(SupervisionTypeEntity*)[fetchedObjects objectAtIndex: [fetchedObjects indexOfObject: existingSpv.supervisionType]];
                                                            
                                                            [potentialDelete willAccessValueForKey:@"supervisionType"];
                                                            
                                                            [deleteExtrasContainingSet addObject:potentialDelete.supervisionType];
                                                            
                                                        }
                                                        
                                                        
                                                        
                                                        
                                                        [existingSpv willChangeValueForKey:@"subType"];
                                                        existingSpv.subType=firstEquivalent;
                                                        [existingSpv didChangeValueForKey:@"subType"];
                                                        
                                                        
                                                        
                                                        
                                                        [existingSpv willChangeValueForKey:@"supervisionType"];
                                                        existingSpv.supervisionType=objToKeepSupervisionType;
                                                        [existingSpv didChangeValueForKey:@"supervisionType"];
                                                        
                                                        
                                                        
                                                        
                                                        [potentialDelete willAccessValueForKey:@"supervisionRecieved"];
                                                        [potentialDelete willAccessValueForKey:@"supervisionGiven"];
                                                        
                                                        [potentialDelete willAccessValueForKey:@"existingSupervision"];
                                                        
                                                        
                                                        
                                                        
                                                        if (potentialDelete && !potentialDelete.supervisionRecieved.count &&!potentialDelete.supervisionGiven.count && !potentialDelete.existingSupervision.count) {
                                                            
                                                            [managedObjectContext deleteObject:potentialDelete];
                                                        }
                                                        
                                                        
                                                        
                                                    }
                                                }
                                                

                                                
                                                
                                            }
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                        
                                    }
                                }}}
                         
                            
                                
                            
                            
                            
                                
                        
                        
                       else if ([objectInArray isKindOfClass:[GenderEntity class]]) {
                            GenderEntity *type=(GenderEntity*)objectInArray;
                            
                            [type willAccessValueForKey:@"demographics"];
                            
                            NSSet *typeSet= type.demographics;
                           NSArray *typeArray=typeSet.allObjects;
                            for (id item in typeArray) {
                                if ([item isKindOfClass:[DemographicProfileEntity class]]) {
                                    DemographicProfileEntity *demographicProfileEntity=(DemographicProfileEntity *)item;
                                    
                                    [demographicProfileEntity willChangeValueForKey:@"gender"];
                                    demographicProfileEntity.gender=objToKeep;
                                    [demographicProfileEntity didChangeValueForKey:@"gender"];
                                    
                                    [managedObjectContext deleteObject:objectInArray];
                                }
                            }
                            
                            [type didAccessValueForKey:@"demographics"];
                        }
                       else if ([objectInArray isKindOfClass:[EmploymentStatusEntity class]]) {
                            EmploymentStatusEntity *type=(EmploymentStatusEntity*)objectInArray;
                            
                            [type willAccessValueForKey:@"demographics"];
                            
                            NSSet *typeSet= type.demographics;
                           NSArray *typeArray=typeSet.allObjects;
                           for (id item in typeArray) {
                                if ([item isKindOfClass:[DemographicProfileEntity class]]) {
                                    DemographicProfileEntity *demographicProfileEntity=(DemographicProfileEntity *)item;
                                    
                                    [demographicProfileEntity willChangeValueForKey:@"employmentStatus"];
                                    demographicProfileEntity.employmentStatus=objToKeep;
                                    [demographicProfileEntity didChangeValueForKey:@"employmentStatus"];
                                    
                                    [managedObjectContext deleteObject:objectInArray];
                                }
                            }
                            
                            [type didAccessValueForKey:@"demographics"];
                        }
                       else if ([objectInArray isKindOfClass:[EducationLevelEntity class]]) {
                            EducationLevelEntity *type=(EducationLevelEntity*)objectInArray;
                            
                            [type willAccessValueForKey:@"demographics"];
                            
                            NSSet *typeSet= type.demographics;
                           NSArray *typeArray=typeSet.allObjects;
                           for (id item in typeArray) {
                                if ([item isKindOfClass:[DemographicProfileEntity class]]) {
                                    DemographicProfileEntity *demographicProfileEntity=(DemographicProfileEntity *)item;
                                    
                                    [demographicProfileEntity willChangeValueForKey:@"educationLevel"];
                                    demographicProfileEntity.educationLevel=objToKeep;
                                    [demographicProfileEntity didChangeValueForKey:@"educationLevel"];
                                    
                                    [managedObjectContext deleteObject:objectInArray];
                                }
                            }
                            
                            [type didAccessValueForKey:@"demographics"];
                        }
                      else  if ([objectInArray isKindOfClass:[RelationshipEntity class]]) {
                            RelationshipEntity *type=(RelationshipEntity*)objectInArray;
                            
                            [type willAccessValueForKey:@"clientRelationship"];
                            
                            NSSet *typeSet= type.clientRelationship;
                            
                          NSArray *typeArray=typeSet.allObjects;
                          for (id item in typeArray) {
                                if ([item isKindOfClass:[InterpersonalEntity class]]) {
                                    InterpersonalEntity *interpersonalEntity=(InterpersonalEntity *)item;
                                    
                                    [interpersonalEntity willChangeValueForKey:@"relationship"];
                                    interpersonalEntity.relationship=objToKeep;
                                    [interpersonalEntity didChangeValueForKey:@"relationship"];
                                    
                                    [managedObjectContext deleteObject:objectInArray];
                                }
                            }
                            
                            [type didAccessValueForKey:@"clientRelationship"];
                        }
                       else if ([objectInArray isKindOfClass:[ClinicianTypeEntity class]]) {
                            ClinicianTypeEntity *type=(ClinicianTypeEntity*)objectInArray;
                            
                            [type willAccessValueForKey:@"clinician"];
                            
                            NSSet *typeSet= type.clinician;
                           NSArray *typeArray=typeSet.allObjects;
                           for (id item in typeArray) {
                                if ([item isKindOfClass:[ClinicianEntity class]]) {
                                    ClinicianEntity *clinicianEntity=(ClinicianEntity *)item;
                                    
                                    [clinicianEntity willChangeValueForKey:@"clinicianType"];
                                    clinicianEntity.clinicianType=objToKeep;
                                    [clinicianEntity didChangeValueForKey:@"clinicianType"];
                                    
                                    [managedObjectContext deleteObject:objectInArray];
                                }
                            }
                            
                            [type didAccessValueForKey:@"clinician"];
                        }
                       
                    }
                    
                    }
                
                }
                
        
        
            
            
             if (objectsWithoutAssociatedTimeRecords.count){
                int countWithout=objectsWithoutAssociatedTimeRecords.count;
                
                
                NSMutableSet *interventionTypesUsedArray=[NSMutableSet set];
                
                 
                NSMutableSet *supervisionTypesUsedArray=[NSMutableSet set];
                 
                 [supervisionTypesUsedArray addObjectsFromArray:deleteExtrasContainingSet];
                 [interventionTypesUsedArray addObjectsFromArray:deleteExtrasContainingSet];
                
                
                for (id objectInArray in objectsWithoutAssociatedTimeRecords) {
                    
                    if ([objectInArray isKindOfClass:[SupervisionTypeEntity class]]) {
                        SupervisionTypeEntity *supervisionTypeEntity=(SupervisionTypeEntity *)objectInArray;
                        
                        [supervisionTypeEntity willAccessValueForKey:@"supervisionType"];
                        if (![supervisionTypesUsedArray containsObject:supervisionTypeEntity.supervisionType]) {
                            [supervisionTypesUsedArray addObject:supervisionTypeEntity.supervisionType];
                            
                        }
                        else
                        {
                            
                            
                            
                            [managedObjectContext deleteObject:objectInArray];
                            
                           
                            
                          
                        
                        }
                       
                        [supervisionTypeEntity didAccessValueForKey:@"supervisionType"];
                        
                        
                        
                    }
                    if ([objectInArray isKindOfClass:[InterventionTypeEntity class]]) {
                        InterventionTypeEntity *interventionTypeEntity=(InterventionTypeEntity *)objectInArray;
                        
                        [interventionTypeEntity willAccessValueForKey:@"interventionType"];
                        if (![interventionTypesUsedArray containsObject:interventionTypeEntity.interventionType]) {
                            [interventionTypesUsedArray addObject:interventionTypeEntity.interventionType];
                            
                        }
                        else
                        {
                            
                            
                            
                            [managedObjectContext deleteObject:objectInArray];
                            
                            
                            
                            
                            
                        }
                        
                        [interventionTypeEntity didAccessValueForKey:@"interventionType"];
                        
                        
                        
                    }

                    else if ([objectInArray isKindOfClass:[SupervisionTypeSubtypeEntity class]]||[objectInArray isKindOfClass:[InterventionTypeSubtypeEntity class]] ) {
                       
                        break;
                        
                    }
                   else if (countWithout>1 || deleteExtrasContainingSet.count) {
                       
                        [managedObjectContext deleteObject:objectInArray];
                        countWithout=countWithout-1;
                    }
                    
                    
                    
                }
                
            }
            
            
            
            
        }
        
        
        
        

        
        
        
        
        
        
        
    }



}

@end
