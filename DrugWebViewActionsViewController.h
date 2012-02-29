//
//  DrugWebViewActionsViewController.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 1/29/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrugWebViewActionsViewController : UIViewController {

    UIButton *emailButton_;
    UIButton *printButton_;

}

@property (nonatomic,strong)IBOutlet UIButton *emailButton;
@property (nonatomic, strong) IBOutlet UIButton *printButton;

@end
