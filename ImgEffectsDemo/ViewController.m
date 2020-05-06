//
//  ViewController.m
//  ImgEffectsDemo
//
//  Created by Julio Seaman on 5/27/16.
//  Copyright © 2016 Julio Seaman. All rights reserved.
//

#import "ViewController.h"
#import "DemoEffect.h"

#import "MBEContext.h"
#import "UIImage+MBETextureUtilities.h"
#import "MBEMainBundleTextureProvider.h"

#import "MBEPaletteMatcherFilter.h"
#import "MBEColorModeFilter.h"

@interface ViewController ()
{
    DemoEffect *effect;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UISwitch *GPUSwitch;

@property (nonatomic, strong) MBEContext *context;
@property (nonatomic, strong) id<MBETextureProvider> imageProvider;
@property (nonatomic, strong) MBEPaletteMatcherFilter *paletteMatcherFilter;
@property (nonatomic, strong) MBEColorModeFilter *colorModeFilter;

@property (nonatomic, strong) dispatch_queue_t renderingQueue;
@property (atomic, assign) uint64_t jobIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.imgView.image = [UIImage imageNamed:@"tiger"];
    effect = [[DemoEffect alloc] initWithImage:[UIImage imageNamed:@"tiger"]];
    
    self.renderingQueue = dispatch_queue_create("Rendering", DISPATCH_QUEUE_SERIAL);
    [self setupGPUEnvironment];
    
}

- (void) setupGPUEnvironment {
    self.context = [MBEContext newContext];
    
    self.imageProvider = [MBEMainBundleTextureProvider textureProviderWithImageNamed:@"tiger"
                                                                             context:self.context];
    
    //self.paletteMatcherFilter = [MBEPaletteMatcherFilter filterWithPaletteType:0 context:self.context];
    //self.paletteMatcherFilter.provider = self.imageProvider;
    
    self.colorModeFilter = [MBEColorModeFilter filterWithColorMode:0 gamma:1 context:self.context];
    self.colorModeFilter.provider = self.imageProvider;
}


- (IBAction)test:(id)sender {
    
    
    self.imgView.image = [effect processImg];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) performEffectsCPU {
    effect.colorMode = (int)[self.colorModeSegment selectedSegmentIndex];
    self.imgView.image = [effect processImg];
}

- (void) performEffectsGPU {
    ++self.jobIndex;
    uint64_t currentJobIndex = self.jobIndex;
    
    dispatch_async(self.renderingQueue, ^{
        if (currentJobIndex != self.jobIndex)
            return;
        
        
        //self.paletteMatcherFilter.paletteType = 0;
        //self.paletteMatcherFilter.ditherType = 0;
        
        self.colorModeFilter.colorMode = (int)[self.colorModeSegment selectedSegmentIndex];
        self.colorModeFilter.gamma = [self gammaValue];
        
        
        id<MTLTexture> texture = self.colorModeFilter.texture;
        
        UIImage *image = [UIImage imageWithMTLTexture:texture];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //NSLog(@"Dimensions: (%0.2f,%0.2f)",image.size.width,image.size.height);
            self.imgView.image = image;
        });
    });

}

- (void) performEffects {
    if ([self.GPUSwitch isOn])
        [self performEffectsGPU];
    else
        [self performEffectsCPU];
}

- (float) gammaValue {
    if (self.gammaSlider.value<0)
        return fabsf(self.gammaSlider.value-1);
    else
        return 1/(self.gammaSlider.value+1);

}

- (IBAction)onColorModeChange:(id)sender {
    [self performEffects];
}

- (IBAction)onGammaSliderChange:(id)sender {
    effect.gamma = [self gammaValue];
    
    //NSLog(@"assigned gamma : %0.4f", effect.gamma);
    
    [self performEffects];

}
@end
