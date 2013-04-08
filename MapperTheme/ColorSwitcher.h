//
//  ColorSwitcher.h
//  PsyTrack Clinician Tools
//  Version: 1.5.1
//
//  Created by Daniel Boice on 6/10/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorSwitcher : NSObject

/*
   @property (nonatomic, retain) NSDictionary* imageNames;

   -(id)initWithScheme:(NSString*)scheme;

   -(NSString*)getImageNameForResource:(NSString*)resource;

   @property (nonatomic, retain) UIColor *textColor;
 */

- (id) initWithScheme:(NSString *)scheme;

@property (nonatomic, retain) NSMutableDictionary *processedImages;

@property (nonatomic, retain) NSMutableDictionary *modifiedImages;

@property (nonatomic, assign) float hue;

@property (nonatomic, assign) float saturation;

- (UIImage *) getImageWithName:(NSString *)imageName;

- (UIImage *) processImage:(UIImage *)originalImage withKey:(NSString *)key;

@property (nonatomic, retain) UIColor *textColor;

@end
