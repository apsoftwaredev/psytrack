//
//  DemographicDetailViewController_Shared.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 9/24/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTableViewModel.h"


@interface DemographicDetailViewController_Shared : NSObject{



}


@property (strong,nonatomic)IBOutlet SCClassDefinition *demographicProfileDef;


-(id)setupTheDemographicView;

@end
