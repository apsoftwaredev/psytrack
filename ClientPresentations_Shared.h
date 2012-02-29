//
//  ClientsAndObservations_Shared.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 10/22/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SCTableViewModel.h"

@interface ClientPresentations_Shared : NSObject <SCTableViewModelDelegate,SCTableViewControllerDelegate>{


     SCArrayOfObjectsModel *tableModel;

     SCClassDefinition *clientPresentationDef;


}


@property (strong, nonatomic) IBOutlet SCClassDefinition *clientPresentationDef;
@property (strong, nonatomic) IBOutlet SCArrayOfObjectsModel *tableModel;

@property (strong, nonatomic)IBOutlet NSDate *serviceDatePickerDate;

-(id)setupUsingSTV ;
-(void)addWechlerAgeCellToSection:(SCTableViewSection *)section;

@end
