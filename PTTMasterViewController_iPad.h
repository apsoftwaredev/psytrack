//
//  MasterViewController_iPad.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 9/23/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTTMasterViewController_iPad : UIViewController {


    UIWindow *window;
    UIView *containerView;
//    UIImageView *imageView;


}
@property (strong, nonatomic) IBOutlet UITabBarController *tabBarController;
@property (strong, nonatomic)IBOutlet UIWindow *window;
@property (strong, nonatomic)IBOutlet UIView *containerView;
//@property (strong, nonatomic)IBOutlet UIImageView *imageView;
@end
