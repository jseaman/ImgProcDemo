//
//  SpecialEffect.m
//  TestImgEffects
//
//  Created by Julio Seaman on 5/12/13.
//  Copyright (c) 2013 Julio Seaman. All rights reserved.
//

#import "SpecialEffect.h"
#import "Pixel.h"

@implementation SpecialEffect {
    
}

- (id) init {
    self = [super init];
    _pixelHeight = _pixelWidth = 1;
    return self;
}

- (id) initWithImage: (UIImage *) img {
    self = [self init];
    self.img = img;
    return self;
}

- (UIImage *) img {
    return _img;
}

- (void) setImg:(UIImage *)img {
    _img = img;
    
    imgRef = [img CGImage];
    [self CreateARGBBitmapContext:imgRef];
    
    // Get image width, height. We'll use the entire image.
    size_t w = CGImageGetWidth(imgRef);
    size_t h = CGImageGetHeight(imgRef);
    CGRect rect = {{0,0},{w,h}};
    
    // Draw the image to the bitmap context. Once we draw, the memory
    // allocated for the context for rendering will then contain the
    // raw image data in the specified color space.
    CGContextDrawImage(imgContext, rect, imgRef);
    
    imgPointer = CGBitmapContextGetData (imgContext);
}

static NSDictionary *palette = nil;

- (NSDictionary *) palette {
    if (palette==nil)
        NSLog(@"aqui me crean");
    else
        NSLog(@"ya estaba creado");
    
    if (palette==nil)
        palette = [NSDictionary dictionaryWithObjects:
                   [NSArray arrayWithObjects:
                    [NSArray arrayWithObjects:
                     [NSNumber numberWithInt:cga_black],
                     [NSNumber numberWithInt:cga_dark_cyan],
                     [NSNumber numberWithInt:cga_dark_magenta],
                     [NSNumber numberWithInt:cga_light_gray],
                     nil
                     ],
                    [NSArray arrayWithObjects:
                     [NSNumber numberWithInt:cga_black],
                     [NSNumber numberWithInt:cga_light_cyan],
                     [NSNumber numberWithInt:cga_light_magenta],
                     [NSNumber numberWithInt:cga_white],
                     nil
                     ],
                    [NSArray arrayWithObjects:
                     [NSNumber numberWithInt:cga_black],
                     [NSNumber numberWithInt:cga_dark_green],
                     [NSNumber numberWithInt:cga_dark_red],
                     [NSNumber numberWithInt:cga_brown],
                     nil
                     ],
                    [NSArray arrayWithObjects:
                     [NSNumber numberWithInt:cga_black],
                     [NSNumber numberWithInt:cga_light_green],
                     [NSNumber numberWithInt:cga_light_red],
                     [NSNumber numberWithInt:cga_yellow],
                     nil
                     ],
                    [NSArray arrayWithObjects:
                     [NSNumber numberWithInt:cga_black],
                     [NSNumber numberWithInt:cga_dark_cyan],
                     [NSNumber numberWithInt:cga_dark_red],
                     [NSNumber numberWithInt:cga_light_gray],
                     nil
                     ],
                    [NSArray arrayWithObjects:
                     [NSNumber numberWithInt:cga_black],
                     [NSNumber numberWithInt:cga_light_cyan],
                     [NSNumber numberWithInt:cga_light_red],
                     [NSNumber numberWithInt:cga_white],
                     nil
                     ],
                    [NSArray arrayWithObjects:
                     [NSNumber numberWithInt:cga_black],
                     [NSNumber numberWithInt:cga_white],
                     [NSNumber numberWithInt:cga_light_gray],
                     [NSNumber numberWithInt:cga_dark_gray],
                     [NSNumber numberWithInt:cga_yellow],
                     [NSNumber numberWithInt:cga_brown],
                     [NSNumber numberWithInt:cga_light_red],
                     [NSNumber numberWithInt:cga_dark_red],
                     [NSNumber numberWithInt:cga_light_green],
                     [NSNumber numberWithInt:cga_dark_green],
                     [NSNumber numberWithInt:cga_light_cyan],
                     [NSNumber numberWithInt:cga_dark_cyan],
                     [NSNumber numberWithInt:cga_light_blue],
                     [NSNumber numberWithInt:cga_dark_blue],
                     [NSNumber numberWithInt:cga_light_magenta],
                     [NSNumber numberWithInt:cga_dark_magenta],
                     nil
                     ],
                    [NSArray arrayWithObjects:
                     [NSNumber numberWithInt:cga_comp_black],
                     [NSNumber numberWithInt:cga_comp_green],
                     [NSNumber numberWithInt:cga_comp_dark_blue],
                     [NSNumber numberWithInt:cga_comp_light_blue],
                     [NSNumber numberWithInt:cga_comp_marron],
                     [NSNumber numberWithInt:cga_comp_gray],
                     [NSNumber numberWithInt:cga_comp_fuschia],
                     [NSNumber numberWithInt:cga_comp_light_purple],
                     [NSNumber numberWithInt:cga_comp_dark_green],
                     [NSNumber numberWithInt:cga_comp_light_green],
                     [NSNumber numberWithInt:cga_comp_aqua],
                     [NSNumber numberWithInt:cga_comp_orange],
                     [NSNumber numberWithInt:cga_comp_yellowgreen],
                     [NSNumber numberWithInt:cga_comp_pink],
                     [NSNumber numberWithInt:cga_comp_white],
                     nil
                     ],
                    [NSArray arrayWithObjects:
                     [NSNumber numberWithInt:0x000000],
                     [NSNumber numberWithInt:0x404040],
                     [NSNumber numberWithInt:0x6C6C6C],
                     [NSNumber numberWithInt:0x909090],
                     [NSNumber numberWithInt:0xB0B0B0],
                     [NSNumber numberWithInt:0xC8C8C8],
                     [NSNumber numberWithInt:0xDCDCDC],
                     [NSNumber numberWithInt:0xECECEC],
                     [NSNumber numberWithInt:0x444400],
                     [NSNumber numberWithInt:0x646410],
                     [NSNumber numberWithInt:0x848424],
                     [NSNumber numberWithInt:0xA0A034],
                     [NSNumber numberWithInt:0xB8B840],
                     [NSNumber numberWithInt:0xD0D050],
                     [NSNumber numberWithInt:0xE8E85C],
                     [NSNumber numberWithInt:0xFCFC68],
                     [NSNumber numberWithInt:0x702800],
                     [NSNumber numberWithInt:0x844414],
                     [NSNumber numberWithInt:0x985C28],
                     [NSNumber numberWithInt:0xAC783C],
                     [NSNumber numberWithInt:0xBC8C4C],
                     [NSNumber numberWithInt:0xCCA05C],
                     [NSNumber numberWithInt:0xDCB468],
                     [NSNumber numberWithInt:0xE8CC7C],
                     [NSNumber numberWithInt:0x841800],
                     [NSNumber numberWithInt:0x983418],
                     [NSNumber numberWithInt:0xAC5030],
                     [NSNumber numberWithInt:0xC06848],
                     [NSNumber numberWithInt:0xD0805C],
                     [NSNumber numberWithInt:0xE09470],
                     [NSNumber numberWithInt:0xECA880],
                     [NSNumber numberWithInt:0xFCBC94],
                     [NSNumber numberWithInt:0x880000],
                     [NSNumber numberWithInt:0x9C2020],
                     [NSNumber numberWithInt:0xB03C3C],
                     [NSNumber numberWithInt:0xC05858],
                     [NSNumber numberWithInt:0xD07070],
                     [NSNumber numberWithInt:0xE08888],
                     [NSNumber numberWithInt:0xECA0A0],
                     [NSNumber numberWithInt:0xFCB4B4],
                     [NSNumber numberWithInt:0x78005C],
                     [NSNumber numberWithInt:0x8C2074],
                     [NSNumber numberWithInt:0xA03C88],
                     [NSNumber numberWithInt:0xB0589C],
                     [NSNumber numberWithInt:0xC070B0],
                     [NSNumber numberWithInt:0xD084C0],
                     [NSNumber numberWithInt:0xDC9CD0],
                     [NSNumber numberWithInt:0xECB0E0],
                     [NSNumber numberWithInt:0x480078],
                     [NSNumber numberWithInt:0x602090],
                     [NSNumber numberWithInt:0x783CA4],
                     [NSNumber numberWithInt:0x8C58B8],
                     [NSNumber numberWithInt:0xA070CC],
                     [NSNumber numberWithInt:0xB484DC],
                     [NSNumber numberWithInt:0xC49CEC],
                     [NSNumber numberWithInt:0xD4B0FC],
                     [NSNumber numberWithInt:0x140084],
                     [NSNumber numberWithInt:0x302098],
                     [NSNumber numberWithInt:0x4C3CAC],
                     [NSNumber numberWithInt:0x6858C0],
                     [NSNumber numberWithInt:0x7C70D0],
                     [NSNumber numberWithInt:0x9488E0],
                     [NSNumber numberWithInt:0xA8A0EC],
                     [NSNumber numberWithInt:0xBCB4FC],
                     [NSNumber numberWithInt:0x000088],
                     [NSNumber numberWithInt:0x1C209C],
                     [NSNumber numberWithInt:0x3840B0],
                     [NSNumber numberWithInt:0x505CC0],
                     [NSNumber numberWithInt:0x6874D0],
                     [NSNumber numberWithInt:0x7C8CE0],
                     [NSNumber numberWithInt:0x90A4EC],
                     [NSNumber numberWithInt:0xA4B8FC],
                     [NSNumber numberWithInt:0x00187C],
                     [NSNumber numberWithInt:0x1C3890],
                     [NSNumber numberWithInt:0x3854A8],
                     [NSNumber numberWithInt:0x5070BC],
                     [NSNumber numberWithInt:0x6888CC],
                     [NSNumber numberWithInt:0x7C9CDC],
                     [NSNumber numberWithInt:0x90B4EC],
                     [NSNumber numberWithInt:0xA4C8FC],
                     [NSNumber numberWithInt:0x002C5C],
                     [NSNumber numberWithInt:0x1C4C78],
                     [NSNumber numberWithInt:0x386890],
                     [NSNumber numberWithInt:0x5084AC],
                     [NSNumber numberWithInt:0x689CC0],
                     [NSNumber numberWithInt:0x7CB4D4],
                     [NSNumber numberWithInt:0x90CCE8],
                     [NSNumber numberWithInt:0xA4E0FC],
                     [NSNumber numberWithInt:0x00402C],
                     [NSNumber numberWithInt:0x1C5C48],
                     [NSNumber numberWithInt:0x387C64],
                     [NSNumber numberWithInt:0x509C80],
                     [NSNumber numberWithInt:0x68B494],
                     [NSNumber numberWithInt:0x7CD0AC],
                     [NSNumber numberWithInt:0x90E4C0],
                     [NSNumber numberWithInt:0xA4FCD4],
                     [NSNumber numberWithInt:0x003C00],
                     [NSNumber numberWithInt:0x205C20],
                     [NSNumber numberWithInt:0x407C40],
                     [NSNumber numberWithInt:0x5C9C5C],
                     [NSNumber numberWithInt:0x74B474],
                     [NSNumber numberWithInt:0x8CD08C],
                     [NSNumber numberWithInt:0xA4E4A4],
                     [NSNumber numberWithInt:0xB8FCB8],
                     [NSNumber numberWithInt:0x143800],
                     [NSNumber numberWithInt:0x345C1C],
                     [NSNumber numberWithInt:0x507C38],
                     [NSNumber numberWithInt:0x6C9850],
                     [NSNumber numberWithInt:0x84B468],
                     [NSNumber numberWithInt:0x9CCC7C],
                     [NSNumber numberWithInt:0xB4E490],
                     [NSNumber numberWithInt:0xC8FCA4],
                     [NSNumber numberWithInt:0x2C3000],
                     [NSNumber numberWithInt:0x4C501C],
                     [NSNumber numberWithInt:0x687034],
                     [NSNumber numberWithInt:0x848C4C],
                     [NSNumber numberWithInt:0x9CA864],
                     [NSNumber numberWithInt:0xB4C078],
                     [NSNumber numberWithInt:0xCCD488],
                     [NSNumber numberWithInt:0xE0EC9C],
                     [NSNumber numberWithInt:0x442800],
                     [NSNumber numberWithInt:0x644818],
                     [NSNumber numberWithInt:0x846830],
                     [NSNumber numberWithInt:0xA08444],
                     [NSNumber numberWithInt:0xB89C58],
                     [NSNumber numberWithInt:0xD0B46C],
                     [NSNumber numberWithInt:0xE8CC7C],
                     [NSNumber numberWithInt:0xFCE08C]
                     ,nil],
                    nil]
                                              forKeys: [NSArray arrayWithObjects: @"CGA1",@"CGA2",@"CGA3",@"CGA4",@"CGA5",@"CGA6",@"EGA",@"CGA_COMP",@"ATARI",nil]
                   ];
    
    return palette;
}

- (void) CreateARGBBitmapContext: (CGImageRef) inImage {
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    // Get image width, height. We'll use the entire image.
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    // Use the generic RGB color space.
    colorSpace = CGColorSpaceCreateDeviceRGB(); //CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    if (colorSpace == NULL)
    {
        NSLog(@"Error allocating color space\n");
        return;
    }
    
    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        NSLog (@"Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return;
    }
    
    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
    // per component. Regardless of what the source image format is
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    imgContext = CGBitmapContextCreate (bitmapData,
                                        pixelsWide,
                                        pixelsHigh,
                                        8,      // bits per component
                                        bitmapBytesPerRow,
                                        colorSpace,
                                        kCGImageAlphaPremultipliedFirst);
    if (imgContext == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    
    // Make sure and release colorspace before returning
    CGColorSpaceRelease( colorSpace );
}

- (Pixel *) getPixelX: (int) x Y: (int) y {
    unsigned int index = (y*_img.size.width + x)*4;
    
    Pixel *p = [[Pixel alloc] initWithR:imgPointer[index+1] G:imgPointer[index+2] B:imgPointer[index+3]];
    
    return p;
}

- (void) setPixelX: (int) x Y: (int) y Pixel: (Pixel *) p {
    unsigned int index = (y*_img.size.width + x)*4;
    
    //imgPointer[index] = p.a;
    imgPointer[index+1] = p.r;
    imgPointer[index+2] = p.g;
    imgPointer[index+3] = p.b;
}

- (float) colorDistanceFrom: (Pixel *) p1 To: (Pixel *) p2 {
    return pow(p1.r-p2.r,2) + pow(p1.g-p2.g,2) + pow(p1.b-p2.b,2);
}

- (UIImage *) processImg {
    return _img;
}

- (void) pixelateToWidth: (int) width Height: (int) height {
    if (width>=height)
    {
        _pixelWidth = _img.size.width/(float)width + 0.5;
        _pixelHeight = _img.size.height/(float)height + 0.5;
    }
    else
    {
        _pixelWidth = _img.size.width/(float)height + 0.5;
        _pixelHeight = _img.size.height/(float)width + 0.5;
    }
    
    if (_pixelWidth==0)
        _pixelWidth = 1;
    
    if (_pixelHeight==0)
        _pixelHeight = 1;
    
    NSLog(@"diffx = %d",_pixelWidth);
    NSLog(@"diffy = %d",_pixelHeight);
    
    int chunkSize = _pixelWidth*_pixelHeight;
    
    for (int y=0;y<_img.size.height;y+=_pixelHeight)
        for (int x=0;x<_img.size.width;x+=_pixelWidth)
        {
            struct {
                int r,b,g;
            } total = {0,0,0};
            
            int maxX = x+_pixelWidth > _img.size.width ? _img.size.width : x+_pixelWidth;
            int maxY = y+_pixelHeight > _img.size.height ? _img.size.height : y+_pixelHeight;
            
            for (int y2=y;y2<maxY;y2++)
                for (int x2=x;x2<maxX;x2++)
                {
                    if (y2>_img.size.height)
                        NSLog(@"mierdaaaaaaaaaaaaaaaaaaaaa!");
                    
                    Pixel *p = [self getPixelX:x2 Y:y2];
                    total.r+=p.r;
                    total.g+=p.g;
                    total.b+=p.b;
                }
            
            total.r = total.r/chunkSize + 0.5;
            total.g = total.g/chunkSize + 0.5;
            total.b = total.b/chunkSize + 0.5;
            
            for (int y2=y;y2<maxY;y2++)
                for (int x2=x;x2<maxX;x2++)
                {
                    Pixel *p = [[Pixel alloc] initWithR:total.r G:total.g B:total.b];
                    [self setPixelX:x2 Y:y2 Pixel:p];
                }
        }
}


@end
