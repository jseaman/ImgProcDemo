//
//  MBEColorModeFilter.h
//  ImgEffectsDemo
//
//  Created by Julio Seaman on 5/28/16.
//  Copyright © 2016 Julio Seaman. All rights reserved.
//

#import "MBEImageFilter.h"

#ifndef colorModeEnum
#define colorModeEnum
typedef enum {NONE, RED, GREEN, BLUE, BW, NEGBW} colorModeValues;
#endif

@interface MBEColorModeFilter : MBEImageFilter

@property (nonatomic) colorModeValues colorMode;
@property (nonatomic) float gamma;

+ (instancetype)filterWithColorMode:(colorModeValues) colorMode gamma: (float) gamma context:(MBEContext *)context;

@end
