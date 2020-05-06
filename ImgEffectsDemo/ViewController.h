//
//  ViewController.h
//  ImgEffectsDemo
//
//  Created by Julio Seaman on 5/27/16.
//  Copyright © 2016 Julio Seaman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *colorModeSegment;
@property (weak, nonatomic) IBOutlet UISlider *gammaSlider;

- (IBAction)onColorModeChange:(id)sender;
- (IBAction)onGammaSliderChange:(id)sender;


@end

