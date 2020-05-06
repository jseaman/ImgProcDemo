//
//  MEPaletteMatcherFilter.m
//  ImageProcessing
//
//  Created by Julio Seaman on 4/26/15.
//  Copyright (c) 2015 Metal By Example. All rights reserved.
//

#import "MBEPaletteMatcherFilter.h"
#import <Metal/Metal.h>

struct AdjustPaletteUniforms
{
    unsigned char paletteType;
    unsigned char ditherType;
};

float dithMap1[2][2] =
{
    {1/5.0, 3/5.0},
    {4/5.0, 2/5.0}
};

float dithMap2[3][3] =
{
    {3/10.0, 7/10.0, 4/10.0},
    {6/10.0, 1/10.0, 9/10.0},
    {2/10.0, 8/10.0, 5/10.0}
};

float dithMap3[4][4] =
{
    {1/17.0, 9/17.0, 3/17.0, 11/17.0},
    {13/17.0, 5/17.0, 15/17.0, 7/17.0},
    {4/17.0, 12/17.0, 2/17.0, 10/17.0},
    {16/17.0, 8/17.0, 14/17.0, 6/17.0}
};

float dithMap4[8][8] =
{
    {1/65.0, 49/65.0, 13/65.0, 61/65.0, 4/65.0, 52/65.0, 16/65.0, 64/65.0},
    {33/65.0, 17/65.0, 45/65.0, 29/65.0, 36/65.0, 20/65.0, 48/65.0, 32/65.0},
    {9/65.0, 57/65.0, 5/65.0, 53/65.0, 12/65.0, 60/65.0, 8/65.0, 56/65.0},
    {41/65.0, 25/65.0, 37/65.0, 21/65.0, 44/65.0, 28/65.0, 40/65.0, 24/65.0},
    {3/65.0, 51/65.0, 15/65.0, 63/65.0, 2/65.0, 50/65.0, 14/65.0, 62/65.0},
    {35/65.0, 19/65.0, 47/65.0, 31/65.0, 34/65.0, 18/65.0, 46/65.0, 30/65.0},
    {11/65.0, 59/65.0, 7/65.0, 55/65.0, 10/65.0, 58/65.0, 6/65.0, 54/65.0},
    {43/65.0, 27/65.0, 39/65.0, 23/65.0, 42/65.0, 26/65.0, 38/65.0, 22/65.0}
};

@interface MBEPaletteMatcherFilter ()
@property (nonatomic, strong) id<MTLTexture> ditherTexture;
@end

@implementation MBEPaletteMatcherFilter

@synthesize paletteType = _paletteType;
@synthesize ditherType = _ditherType;

+ (instancetype)filterWithPaletteType:(Byte)paletteType context:(MBEContext *)context
{
    return [[self alloc] initWithPaletteType:paletteType context:context];
}

- (instancetype)initWithPaletteType:(Byte)paletteType context:(MBEContext *)context
{
    if ((self = [super initWithFunctionName:@"palette_matcher" context:context]))
    {
        _paletteType = paletteType;
    }
    return self;
}

- (void) setPaletteType:(Byte)paletteType
{
    self.dirty = YES;
    _paletteType = paletteType;
}

- (void) setDitherType:(unsigned char)ditherType
{
    self.dirty = YES;
    _ditherType = ditherType;
    self.ditherTexture = nil;
}

- (void) generateDitherTexture
{
    int size = 0;
    float *bytes = NULL;
    
    if (_ditherType==1 || _ditherType==0)
    {
        size = 2;
        bytes = (float *) dithMap1;
    }
    else if (_ditherType==2)
    {
        size = 3;
        bytes = (float *) dithMap2;
    }
    else if (_ditherType==3)
    {
        size = 4;
        bytes = (float *) dithMap3;
    }
    else if (_ditherType==4)
    {
        size = 8;
        bytes = (float *) dithMap4;
    }
    
    MTLTextureDescriptor *textureDescriptor = [MTLTextureDescriptor texture2DDescriptorWithPixelFormat:MTLPixelFormatR32Float
                                                                                                 width:size
                                                                                                height:size
                                                                                             mipmapped:NO];
    
    self.ditherTexture = [self.context.device newTextureWithDescriptor:textureDescriptor];
    
    MTLRegion region = MTLRegionMake2D(0, 0, size, size);
    [self.ditherTexture replaceRegion:region mipmapLevel:0 withBytes:bytes bytesPerRow:sizeof(float) * size];
}


- (void)configureArgumentTableWithCommandEncoder:(id<MTLComputeCommandEncoder>)commandEncoder
{
    struct AdjustPaletteUniforms uniforms;
    uniforms.paletteType = _paletteType;
    uniforms.ditherType = _ditherType;
    
    if (!self.uniformBuffer)
        self.uniformBuffer = [self.context.device newBufferWithLength:sizeof(uniforms) options:MTLResourceOptionCPUCacheModeDefault];
    
    memcpy([self.uniformBuffer contents], &uniforms, sizeof(uniforms));
    
    [commandEncoder setBuffer:self.uniformBuffer offset:0 atIndex:0];
    
    //if (_ditherType>0)
    {
        if (!self.ditherTexture)
            [self generateDitherTexture];
        
        [commandEncoder setTexture:self.ditherTexture atIndex:2];
    }
}

@end
