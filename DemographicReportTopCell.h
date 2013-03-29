//
//  DemographicReportTopCell.h
//  PsyTrack Clinician Tools
//  Version: 1.0.6
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

@interface DemographicReportTopCell : SCCustomCell <SCTableViewModelDelegate, SCTableViewControllerDelegate, UITableViewDelegate, SCTableViewModelDataSource>{
    SCTableViewModel *sexTableViewModel_;
    SCTableViewModel *genderTableViewModel_;
    SCTableViewModel *ethnicitiesTableViewModel_;
    SCTableViewModel *racesTableViewModel_;
    SCTableViewModel *disabilityTableViewModel_;
    SCTableViewModel *educationLevelTableViewModel_;
    SCTableViewModel *sexualOrientationTableViewModel_;
    NSInteger numberOfSupervisors;

    CGFloat currentOffsetY;
}

@property (nonatomic,strong)  SCTableViewModel *sexTableViewModel;
@property (nonatomic,strong)  SCTableViewModel *genderTableViewModel;
@property (nonatomic,strong)  SCTableViewModel *ethnicitiesTableViewModel;
@property (nonatomic,strong)  SCTableViewModel *racesTableViewModel;

@property (nonatomic,strong)  SCTableViewModel *disabilityTableViewModel;
@property (nonatomic,strong)  SCTableViewModel *educationLevelTableViewModel;
@property (nonatomic,strong)  SCTableViewModel *sexualOrientationTableViewModel;

@property (nonatomic, weak) IBOutlet UITableView *sexTableView;
@property (nonatomic, weak) IBOutlet UITableView *genderTableView;
@property (nonatomic, weak) IBOutlet UITableView *ethnicitiesTableView;
@property (nonatomic, weak) IBOutlet UITableView *racesTableView;

@property (nonatomic, weak) IBOutlet UITableView *disabilityTableView;
@property (nonatomic, weak) IBOutlet UITableView *educationTableView;
@property (nonatomic, weak) IBOutlet UITableView *sexualOrientationTableView;

@property (nonatomic, weak) IBOutlet UILabel *clinicianNameLabel;

@property (nonatomic, weak) IBOutlet UIScrollView *mainPageScrollView;

@property (nonatomic, weak) IBOutlet UIView *tablesContainerView;
@property (nonatomic, weak) IBOutlet UILabel *totalClientsLabel;
@end
