//
//  ColorSwitcher.m
//  PsyTrack
//
//  Created by Daniel Boice on 6/10/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ColorSwitcher.h"

@implementation ColorSwitcher

//@synthesize imageNames, textColor;

@synthesize processedImages, modifiedImages, hue, saturation, textColor;

-(id)initWithScheme:(NSString*)scheme
{
    self = [super init];
    
    if(self)
    {
        self.processedImages = [NSMutableDictionary dictionary];
        self.modifiedImages = [NSMutableDictionary dictionary];
        
        [processedImages setObject:[UIImage imageNamed:@"menubar-full.png"] forKey:@"menubar-full"];
        [processedImages setObject:[UIImage imageNamed:@"slider-fill.png"] forKey:@"slider-fill"];
        [processedImages setObject:[UIImage imageNamed:@"tabbar.png"] forKey:@"tabbar"];
        [processedImages setObject:[UIImage imageNamed:@"ipad-menubar-full.png"] forKey:@"ipad-menubar-full"];
        [processedImages setObject:[UIImage imageNamed:@"ipad-menubar-left.png"] forKey:@"ipad-menubar-left"];
        [processedImages setObject:[UIImage imageNamed:@"ipad-menubar-right.png"] forKey:@"ipad-menubar-right"];
        [processedImages setObject:[UIImage imageNamed:@"ipad-tabbar-left.png"] forKey:@"ipad-tabbar-left"];
        [processedImages setObject:[UIImage imageNamed:@"ipad-tabbar-right.png"] forKey:@"ipad-tabbar-right"];
        [processedImages setObject:[UIImage imageNamed:@"back.png"] forKey:@"back"];
        [processedImages setObject:[UIImage imageNamed:@"bar-button.png"] forKey:@"bar-button"];
        
        
        if([scheme isEqualToString:@"blue"])
        {   
            hue = 0;
            saturation = 1;
            
            self.textColor = [UIColor colorWithRed:30.0/255 green:110.0/255 blue:178.0/255 alpha:1.0];
            
        }
        else if([scheme isEqualToString:@"brown"])
        {
            hue = -3.14;
            saturation = 1;
            
            self.textColor = [UIColor colorWithRed:194.0/255 green:126.0/255 blue:74.0/255 alpha:1.0];
        }
    }
    
    return self;
}


/*-(id)initWithScheme:(NSString*)scheme
 {
 self = [super init];
 
 if(self)
 {
 NSMutableDictionary* tempDictionary = [[NSMutableDictionary alloc] init];
 
 if([scheme isEqualToString:@"blue"])
 {         
 [tempDictionary setObject:@"menubar.png" forKey:@"menubar"];
 [tempDictionary setObject:@"slider-fill.png" forKey:@"slider-fill"];
 [tempDictionary setObject:@"tabbar.png" forKey:@"tabbar"];
 [tempDictionary setObject:@"ipad-menubar-left.png" forKey:@"ipad-menubar-left"];
 [tempDictionary setObject:@"ipad-menubar-right.png" forKey:@"ipad-menubar-right"];
 [tempDictionary setObject:@"ipad-tabbar-left.png" forKey:@"ipad-tabbar-left"];
 [tempDictionary setObject:@"ipad-tabbar-right.png" forKey:@"ipad-tabbar-right"];
 [tempDictionary setObject:@"back.png" forKey:@"back"];
 [tempDictionary setObject:@"bar-button.png" forKey:@"bar-button"];
 
 self.textColor = [UIColor colorWithRed:30.0/255 green:110.0/255 blue:178.0/255 alpha:1.0];
 }
 else if([scheme isEqualToString:@"brown"])
 {
 
 [tempDictionary setObject:@"menubar-brown.png" forKey:@"menubar"];
 [tempDictionary setObject:@"slider-fill-brown.png" forKey:@"slider-fill"];
 [tempDictionary setObject:@"tabbar-brown.png" forKey:@"tabbar"];
 [tempDictionary setObject:@"ipad-menubar-left-brown.png" forKey:@"ipad-menubar-left"];
 [tempDictionary setObject:@"ipad-menubar-right-brown.png" forKey:@"ipad-menubar-right"];
 [tempDictionary setObject:@"ipad-tabbar-left-brown.png" forKey:@"ipad-tabbar-left"];
 [tempDictionary setObject:@"ipad-tabbar-right-brown.png" forKey:@"ipad-tabbar-right"];
 [tempDictionary setObject:@"back-brown.png" forKey:@"back"];
 [tempDictionary setObject:@"bar-button-brown.png" forKey:@"bar-button"];
 
 self.textColor = [UIColor colorWithRed:194.0/255 green:126.0/255 blue:74.0/255 alpha:1.0];
 
 }
 
 self.imageNames =[NSDictionary dictionaryWithDictionary:tempDictionary];
 
 }
 
 return self;
 }
 */


-(UIImage*)processImage:(UIImage*)originalImage withKey:(NSString*)key
{
    
    UIImage* existingImage = [modifiedImages objectForKey:key];
    
    if(existingImage)
    {
        return existingImage;
    }
    else if (hue == 0 && saturation == 1)
    {
        return originalImage;
    }
    
    
    CIImage *beginImage = [CIImage imageWithData:UIImagePNGRepresentation(originalImage)];
    
    CIContext* context = [CIContext contextWithOptions:nil];
    
    CIFilter* hueFilter = [CIFilter filterWithName:@"CIHueAdjust" keysAndValues:kCIInputImageKey, beginImage, @"inputAngle", [NSNumber numberWithFloat:hue], nil];
    
    CIImage *outputImage = [hueFilter outputImage];
    
    CIFilter* saturationFilter = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, outputImage, @"inputSaturation", [NSNumber numberWithFloat:saturation], nil];
    
    outputImage = [saturationFilter outputImage];
    
    
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    
    UIImage *processed;
    if ( [[[UIDevice currentDevice] systemVersion] intValue] >= 4 && [[UIScreen mainScreen] scale] == 2.0 )
    {
        processed = [UIImage imageWithCGImage:cgimg scale:2.0 orientation:UIImageOrientationUp]; 
    }
    else
    {
        processed = [UIImage imageWithCGImage:cgimg]; 
    }
    
    CGImageRelease(cgimg);
    
    [modifiedImages setObject:processed forKey:key];
    
    return processed;
    
}



-(UIImage*)getImageWithName:(NSString*)imageName
{
    UIImage* image = [processedImages objectForKey:imageName];
    
    return [self processImage:image withKey:imageName];
}

/*
 
 -(NSString*)getImageNameForResource:(NSString*)resource
 {
 return [imageNames objectForKey:resource];
 }
 */

@end
