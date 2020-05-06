//
//  DemoEffect.h
//  ImgEffectsDemo
//
//  Created by Julio Seaman on 5/27/16.
//  Copyright © 2016 Julio Seaman. All rights reserved.
//

#import "SpecialEffect.h"

#ifndef colorModeEnum
#define colorModeEnum
typedef enum {NONE, RED, GREEN, BLUE, BW, NEGBW} colorModeValues;
#endif

@interface DemoEffect : SpecialEffect {
    
}

@property (nonatomic) colorModeValues colorMode;
@property (nonatomic) float gamma;

@end
