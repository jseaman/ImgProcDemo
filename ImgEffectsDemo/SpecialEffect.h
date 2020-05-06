//
//  SpecialEffect.h
//  TestImgEffects
//
//  Created by Julio Seaman on 5/12/13.
//  Copyright (c) 2013 Julio Seaman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Pixel;

@interface SpecialEffect : NSObject {
    unsigned char *imgPointer;
    CGContextRef imgContext;
    CGImageRef imgRef;
    
    UIImage *_img;
}

@property (nonatomic, copy) UIImage *img;
@property (nonatomic, readonly) NSDictionary *palette;
@property (nonatomic, readonly) int pixelWidth;
@property (nonatomic, readonly) int pixelHeight;

- (id) initWithImage: (UIImage *) img;
- (UIImage *) processImg;
- (Pixel *) getPixelX: (int) x Y: (int) y;
- (void) setPixelX: (int) x Y: (int) y Pixel: (Pixel *) p;
- (float) colorDistanceFrom: (Pixel *) p1 To: (Pixel *) p2;
- (void) pixelateToWidth: (int) width Height: (int) height;

@end
