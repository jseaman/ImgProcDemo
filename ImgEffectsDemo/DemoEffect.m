//
//  DemoEffect.m
//  ImgEffectsDemo
//
//  Created by Julio Seaman on 5/27/16.
//  Copyright © 2016 Julio Seaman. All rights reserved.
//

#import "DemoEffect.h"
#import "Pixel.h"

@implementation DemoEffect {
    SpecialEffect *original;
}

- (id) initWithImage: (UIImage *) img {
    original = [[SpecialEffect alloc] initWithImage:img];
    self.gamma = 1;
    return [super initWithImage:img];
}

- (int) gCorrect: (int) x {
    return round(pow(x/255.0,self.gamma) * 255);
}

- (UIImage *) processImg
{
    
    for (int y=0;y<self.img.size.height;y++)
        for (int x=0;x<self.img.size.width;x++)
        {
            Pixel *p = [original getPixelX:x Y:y];
            
            switch(_colorMode)
            {
                case RED:
                    p.g = p.b = 0;
                    break;
                    
                case GREEN:
                    p.r = p.b = 0;
                    break;
                    
                case BLUE:
                    p.r = p.g = 0;
                    break;
                    
                case BW:
                    p.r = p.g = p.b = round(0.21*p.r + 0.72*p.g + 0.07*p.b);
                    break;
                    
                case NEGBW:
                    p.r = p.g = p.b = 255 - round(0.21*p.r + 0.72*p.g + 0.07*p.b);
                    break;
                    
                default:
                    break;
                    
            }
            
            p.r = [self gCorrect:p.r];
            p.g = [self gCorrect:p.g];
            p.b = [self gCorrect:p.b];
            
            [self setPixelX:x Y:y Pixel:p];
        }
    
    return [UIImage imageWithCGImage:CGBitmapContextCreateImage(imgContext)];
}

@end
