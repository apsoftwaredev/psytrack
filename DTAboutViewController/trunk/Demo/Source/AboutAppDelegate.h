//
//  AboutAppDelegate.h
//  About
//
//  Created by Oliver Drobnik on 2/13/10.
//  Copyright Drobnik.com 2010. All rights reserved.
//

@interface AboutAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

