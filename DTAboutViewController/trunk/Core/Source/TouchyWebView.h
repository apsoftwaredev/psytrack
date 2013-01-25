//
//  TouchyWebView.h
//  ELO
//
//  Created by Oliver on 06.09.09.
//  Copyright 2009 Drobnik.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol TouchyDelegate <NSObject>

@optional

- (void) touchAtPoint:(CGPoint)touchPoint;


@end



@interface TouchyWebView : UIWebView 
{

}

@end
