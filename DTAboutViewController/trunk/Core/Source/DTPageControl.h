//
//  DTPageControl.h
//  About
//
//  Created by Oliver Drobnik on 2/16/10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTPageControl : UIPageControl
{
    UIImage *dotImage;
    UIImage *dotSelectedImage;
}

@property (nonatomic, retain) UIImage *dotImage;
@property (nonatomic, retain) UIImage *dotSelectedImage;

@end
