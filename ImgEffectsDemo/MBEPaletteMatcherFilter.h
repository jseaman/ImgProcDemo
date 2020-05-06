//
//  MEPaletteMatcherFilter.h
//  ImageProcessing
//
//  Created by Julio Seaman on 4/26/15.
//  Copyright (c) 2015 Metal By Example. All rights reserved.
//

#import "MBEImageFilter.h"

@interface MBEPaletteMatcherFilter : MBEImageFilter

@property (nonatomic, assign) unsigned char paletteType;
@property (nonatomic, assign) unsigned char ditherType;

+ (instancetype)filterWithPaletteType:(Byte)paletteType context:(MBEContext *)context;

@end
