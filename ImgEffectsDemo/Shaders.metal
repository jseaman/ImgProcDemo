//
//  Shaders.metal
//  ImgEffectsDemo
//
//  Created by Julio Seaman on 5/27/16.
//  Copyright © 2016 Julio Seaman. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct AdjustPaletteUniforms
{
    uchar paletteType;
    uchar ditherType;
};

constant float4 cga_black = {0x00/255.0, 0x00/255.0, 0x00/255.0, 1};
constant float4 cga_white = {0xff/255.0, 0xff/255.0, 0xff/255.0, 1};
constant float4 cga_light_gray = {0xaa/255.0, 0xaa/255.0, 0xaa/255.0, 1};
constant float4 cga_dark_gray = {0x55/255.0, 0x55/255.0, 0x55/255.0, 1};
constant float4 cga_yellow = {0xff/255.0, 0xff/255.0, 0x55/255.0, 1};
constant float4 cga_brown = {0xaa/255.0, 0x55/255.0, 0x00/255.0, 1};
constant float4 cga_light_red = {0xff/255.0, 0x55/255.0, 0x55/255.0, 1};
constant float4 cga_dark_red = {0xaa/255.0, 0x00/255.0, 0x00/255.0, 1};
constant float4 cga_light_green = {0x55/255.0, 0xff/255.0, 0x55/255.0, 1};
constant float4 cga_dark_green = {0x00/255.0, 0xaa/255.0, 0x00/255.0, 1};
constant float4 cga_light_cyan = {0x55/255.0, 0xff/255.0, 0xff/255.0, 1};
constant float4 cga_dark_cyan = {0x00/255.0, 0xaa/255.0, 0xaa/255.0, 1};
constant float4 cga_light_blue = {0x55/255.0, 0x55/255.0, 0xff/255.0, 1};
constant float4 cga_dark_blue = {0x00/255.0, 0x00/255.0, 0xaa/255.0, 1};
constant float4 cga_light_magenta = {0xff/255.0, 0x55/255.0, 0xff/255.0, 1};
constant float4 cga_dark_magenta = {0xaa/255.0, 0x00/255.0, 0xaa/255.0, 1};

constant float4 cga_palette[6][4] =
{
    {cga_dark_cyan, cga_dark_magenta, cga_light_gray, cga_black },
    {cga_black, cga_light_cyan, cga_light_magenta, cga_white},
    {cga_black, cga_dark_green, cga_dark_red, cga_brown},
    {cga_black, cga_light_green, cga_light_red, cga_yellow},
    {cga_black, cga_dark_cyan, cga_dark_red, cga_light_gray},
    {cga_black, cga_light_cyan, cga_light_red, cga_white}
};

kernel void palette_matcher(texture2d<float, access::read> inTexture [[texture(0)]],
                            texture2d<float, access::write> outTexture [[texture(1)]],
                            constant AdjustPaletteUniforms &uniforms [[buffer(0)]],
                            texture2d<float, access::read> ditherMap [[texture(2)]],
                            uint2 gid [[thread_position_in_grid]])
{
    float4 inColor = inTexture.read(gid);
    
    if (uniforms.ditherType>0)
    {
        //inColor.gb = 0;
        
        int size = ditherMap.get_width();
        uint2 dithIndex(gid.x % size, gid.y % size);
        inColor.rgb = inColor.rgb + (inColor.rgb * ditherMap.read(dithIndex).rrr);
    }
    
    float4 minColor = cga_palette[uniforms.paletteType][0];
    float minDistance = distance(minColor,inColor);
    
    for (int i=1;i<4;i++)
    {
        float dist = distance(cga_palette[uniforms.paletteType][i],inColor);
        minColor = select(cga_palette[uniforms.paletteType][i],minColor,dist>minDistance);
        minDistance = min(dist,minDistance);
    }
    
    
    outTexture.write(minColor, gid);
    
    //outTexture.write(outColor, gid);
}

struct ColorModeUniforms
{
    uchar colorMode;
    float gamma;
};

kernel void setColorMode (texture2d<float, access::read> inTexture [[texture(0)]],
                            texture2d<float, access::write> outTexture [[texture(1)]],
                            constant ColorModeUniforms &uniforms [[buffer(0)]],
                            uint2 gid [[thread_position_in_grid]])
{
    float4 inColor = inTexture.read(gid);
    
    inColor = select(inColor, float4(inColor.r,0,0,1), uniforms.colorMode==1);
    inColor = select(inColor, float4(0,inColor.g,0,1), uniforms.colorMode==2);
    inColor = select(inColor, float4(0,0,inColor.b,1), uniforms.colorMode==3);
    
    float bw = 0.21*inColor.r + 0.72*inColor.g + 0.07*inColor.b;
    
    inColor = select(inColor, float4(bw,bw,bw,1), uniforms.colorMode==4);
    inColor = select(inColor, float4(1-bw,1-bw,1-bw,1), uniforms.colorMode==5);
    
    inColor = pow(inColor,uniforms.gamma);
    
    
    outTexture.write(inColor, gid);
}
