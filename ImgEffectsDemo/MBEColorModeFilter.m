//
//  MBEColorModeFilter.m
//  ImgEffectsDemo
//
//  Created by Julio Seaman on 5/28/16.
//  Copyright © 2016 Julio Seaman. All rights reserved.
//

#import "MBEColorModeFilter.h"
#import <Metal/Metal.h>

struct ColorModeUniforms
{
    unsigned char colorMode;
    float gamma;
};

@implementation MBEColorModeFilter

@synthesize colorMode = _colorMode;
@synthesize gamma = _gamma;

+ (instancetype)filterWithColorMode:(colorModeValues) colorMode gamma: (float) gamma context:(MBEContext *)context
{
    return [[self alloc] initWithColorMode:colorMode gamma:gamma context:context];
}

- (instancetype)initWithColorMode:(colorModeValues) colorMode gamma: (float) gamma context:(MBEContext *)context
{
    if ((self = [super initWithFunctionName:@"setColorMode" context:context]))
    {
        self.colorMode = colorMode;
        self.gamma = gamma;
    }
    return self;
}

- (void) setColorMode:(colorModeValues)colorMode
{
    self.dirty = YES;
    _colorMode = colorMode;
}

- (void) setGamma:(float)gamma
{
    self.dirty = YES;
    _gamma = gamma;
}

- (void)configureArgumentTableWithCommandEncoder:(id<MTLComputeCommandEncoder>)commandEncoder
{
    struct ColorModeUniforms uniforms;
    uniforms.colorMode = _colorMode;
    
    uniforms.gamma = _gamma;
    
    if (!self.uniformBuffer)
        self.uniformBuffer = [self.context.device newBufferWithLength:sizeof(uniforms) options:MTLResourceOptionCPUCacheModeDefault];
    
    memcpy([self.uniformBuffer contents], &uniforms, sizeof(uniforms));
    
    [commandEncoder setBuffer:self.uniformBuffer offset:0 atIndex:0];
}

@end
