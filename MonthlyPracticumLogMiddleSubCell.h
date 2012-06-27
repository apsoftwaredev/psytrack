//
//  MonthlyPracticumLogMiddleSubCell.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/26/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//



@interface MonthlyPracticumLogMiddleSubCell : SCCustomCell <SCTableViewModelDelegate>{

    SCArrayOfObjectsModel *objectsModel;


}


@property (nonatomic, strong)IBOutlet UILabel *cellHeaderLabel;

@property (nonatomic, strong)IBOutlet UILabel *sectionFooterTotalLabel;

@property (nonatomic, strong)IBOutlet UIView *sectionFooterView;

@property (nonatomic, strong)IBOutlet UITableView *sectionTableView;
@end
