//
//  DemographicReportTopCell.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

@interface DemographicReportTopCell : SCCustomCell <SCTableViewModelDelegate, SCTableViewControllerDelegate, UITableViewDelegate, SCTableViewModelDataSource>{
    
    
    SCArrayOfObjectsModel *sexObjectsModel_;
    SCArrayOfObjectsModel *genderObjectsModel_;
    SCArrayOfObjectsModel *ethnicitiesObjectsModel_;
    SCArrayOfObjectsModel *racesObjectsModel_;
    SCArrayOfObjectsModel *disabilityObjectsModel_;
    SCArrayOfObjectsModel *educationLevelObjectsModel_;
    SCArrayOfObjectsModel  *sexualOrientationObjectsModel_;
    NSInteger numberOfSupervisors;
    
    BOOL markAmended;
    CGFloat currentOffsetY;
    
}

@property (nonatomic,strong)  SCArrayOfObjectsModel *sexObjectsModel;
@property (nonatomic,strong)  SCArrayOfObjectsModel *genderObjectsModel;
@property (nonatomic,strong)  SCArrayOfObjectsModel *ethnicitiesObjectsModel;
@property (nonatomic,strong)  SCArrayOfObjectsModel *racesObjectsModel;

@property (nonatomic,strong)  SCArrayOfObjectsModel *disabilityObjectsModel;
@property (nonatomic,strong)  SCArrayOfObjectsModel *educationLevelObjectsModel;
@property (nonatomic,strong)  SCArrayOfObjectsModel *sexualOrientationObjectsModel;



@property (nonatomic, weak)IBOutlet UITableView *sexTableView;
@property (nonatomic, weak)IBOutlet UITableView *genderTableView;
@property (nonatomic, weak)IBOutlet UITableView *ethnicitiesTableView;
@property (nonatomic, weak)IBOutlet UITableView *racesTableView;

@property (nonatomic, weak)IBOutlet UITableView *disabilityTableView;
@property (nonatomic, weak)IBOutlet UITableView *educationTableView;
@property (nonatomic, weak)IBOutlet UITableView *sexualOrientationTableView;


@property (nonatomic, weak)IBOutlet UILabel *clinicianNameLabel;

@property (nonatomic, weak)IBOutlet UIScrollView *mainPageScrollView;

@property (nonatomic, weak)IBOutlet UIView *tablesContainerView;
@property (nonatomic, weak) IBOutlet UILabel *totalClientsLabel;
@end
