//
//  Pixel.h
//  TestImgEffects
//
//  Created by Julio Seaman on 6/9/13.
//  Copyright (c) 2013 Julio Seaman. All rights reserved.
//

#import <Foundation/Foundation.h>

static const int cga_black = 0x000000;
static const int cga_white = 0xffffff;
static const int cga_light_gray = 0xaaaaaa;
static const int cga_dark_gray = 0x555555;
static const int cga_yellow = 0xffff55;
static const int cga_brown = 0xaa5500;
static const int cga_light_red = 0xff5555;
static const int cga_dark_red = 0xaa0000;
static const int cga_light_green = 0x55ff55;
static const int cga_dark_green = 0x00aa00;
static const int cga_light_cyan = 0x55ffff;
static const int cga_dark_cyan = 0x00aaaa;
static const int cga_light_blue = 0x5555ff;
static const int cga_dark_blue = 0x0000aa;
static const int cga_light_magenta = 0xff55ff;
static const int cga_dark_magenta = 0xaa00aa;

static const int cga_comp_black = 0x000000;
static const int cga_comp_green = 0x006e31;
static const int cga_comp_dark_blue = 0x3109ff;
static const int cga_comp_light_blue = 0x008aff;
static const int cga_comp_marron = 0xa70031;
static const int cga_comp_gray = 0x767676;
static const int cga_comp_fuschia = 0xec11ff;
static const int cga_comp_light_purple = 0xbb92ff;
static const int cga_comp_dark_green = 0x315a00;
static const int cga_comp_light_green = 0x00db00;
static const int cga_comp_aqua = 0x45f7bb;
static const int cga_comp_orange = 0xec6300;
static const int cga_comp_yellowgreen = 0xbbe400;
static const int cga_comp_pink = 0xff7fbb;
static const int cga_comp_white = 0xffffff;


@interface Pixel : NSObject

@property (nonatomic) int r;
@property (nonatomic) int g;
@property (nonatomic) int b;
@property (nonatomic) int colorVal;

- (id) initWithColorVal : (int) colorVal;
- (id) initWithR: (int) r G: (int) g B: (int) b;
- (void) setValuesR: (int) r G: (int) g B: (int) b;

@end
