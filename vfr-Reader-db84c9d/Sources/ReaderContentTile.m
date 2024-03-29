//
//	ReaderContentTile.m
//	Reader v2.5.5
//
//	Created by Julius Oklamcak on 2011-07-01.
//	Copyright © 2011-2012 Julius Oklamcak. All rights reserved.
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights to
//	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//	of the Software, and to permit persons to whom the Software is furnished to
//	do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "ReaderContentTile.h"

@implementation ReaderContentTile

#pragma mark Constants

#define LEVELS_OF_DETAIL 4
#define LEVELS_OF_DETAIL_BIAS 3

//#pragma mark Properties

//@synthesize ;

#pragma mark ReaderContentTile class methods

+ (CFTimeInterval) fadeDuration
{
#ifdef DEBUGX
    NSLog(@"%s", __FUNCTION__);
#endif

    return 0.001;     // iOS bug workaround

    //return 0.0; // No fading wanted
}


#pragma mark ReaderContentTile instance methods

- (id) init
{
#ifdef DEBUGX
    NSLog(@"%s", __FUNCTION__);
#endif

    if ( (self = [super init]) )
    {
        self.levelsOfDetail = LEVELS_OF_DETAIL;         // Zoom (?) levels

        UIScreen *mainScreen = [UIScreen mainScreen];         // Main screen

        CGFloat screenScale = [mainScreen scale];         // Main screen scale

        self.levelsOfDetailBias = (screenScale > 1.0f) ? 1 : LEVELS_OF_DETAIL_BIAS;

        CGRect screenBounds = [mainScreen bounds];         // Main screen bounds

        CGFloat w_pixels = (screenBounds.size.width * screenScale);

        CGFloat h_pixels = (screenBounds.size.height * screenScale);

        CGFloat max = ( (w_pixels < h_pixels) ? h_pixels : w_pixels );

        CGFloat sizeOfTiles = ( (max < 512.0f) ? 512.0f : 1024.0f );

        self.tileSize = CGSizeMake(sizeOfTiles, sizeOfTiles);
    }

    return self;
}


@end
