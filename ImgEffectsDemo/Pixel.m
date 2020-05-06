//
//  Pixel.m
//  TestImgEffects
//
//  Created by Julio Seaman on 6/9/13.
//  Copyright (c) 2013 Julio Seaman. All rights reserved.
//

#import "Pixel.h"

@implementation Pixel

- (void) setColorVal:(int)colorVal {
    _colorVal = colorVal;
    
    _b = colorVal & 0xff;
    colorVal>>=8;
    _g = colorVal & 0xff;
    colorVal>>=8;
    _r = colorVal & 0xff;
}

- (void) setR:(int)r {
    _r = r;
    _colorVal = (_colorVal & 0x00ffff) | r<<16;
}

- (void) setG:(int)g {
    _g = g;
    _colorVal = (_colorVal & 0xff00ff) | g<<8;
}

- (void) setB:(int)b {
    _b = b;
    _colorVal = (_colorVal & 0xffff00) | b;
}

- (id) initWithColorVal : (int) colorVal {
    self = [super init];
    self.colorVal = colorVal;
    return self;
}

- (id) initWithR: (int) r G: (int) g B: (int) b {
    self = [super init];
    [self setValuesR:r G:g B:b];
    return self;
}

- (void) setValuesR: (int) r G: (int) g B: (int) b {
    _r = r;
    _g = g;
    _b = b;
    
    _colorVal = r<<16 | g<<8 | b;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%d,%d,%d",_r,_g,_b];
}

@end
