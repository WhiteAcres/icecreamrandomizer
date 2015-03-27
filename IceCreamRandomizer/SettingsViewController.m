//
//  SettingsViewController.m
//  IceCreamRandomizer
//
//  Created by Jeremy Whitaker on 1/28/15.
//  Copyright (c) 2015 SEFCOM User. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

UILabel *favoritesValueLabel;
UISlider *favoritesSlider;

@implementation SettingsViewController

- (void) sliderChanged
{
    favoritesValueLabel.text = [NSString stringWithFormat:@"%.00f %%", favoritesSlider.value];
}

- (void) sliderReleased
{
    NSNumber *favoriteValueNum = [[NSNumber alloc] initWithFloat:favoritesSlider.value];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
    NSMutableDictionary *settingsDict = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    [settingsDict setValue:favoriteValueNum forKey:@"FavoriteChance"];
    [settingsDict writeToFile:filePath atomically:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do view setup here.

    self.view.backgroundColor = [UIColor whiteColor];
    
    // create the favorites slider
    favoritesSlider = [[UISlider alloc] initWithFrame:CGRectMake(190, 150, 400, 50)];
    favoritesSlider.minimumValue = 0;
    favoritesSlider.maximumValue = 100;
    favoritesSlider.value = 0;
    [favoritesSlider addTarget:self action:@selector(sliderChanged) forControlEvents:UIControlEventValueChanged];
    [favoritesSlider addTarget:self action:@selector(sliderReleased) forControlEvents:UIControlEventTouchUpInside];
    [favoritesSlider addTarget:self action:@selector(sliderReleased) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:favoritesSlider];
    
    //create the favorites label
    UILabel *favoritesLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 90, 200, 50)];
    [favoritesLabel setText:@"Favorite Chance:"];
    [self.view addSubview:favoritesLabel];
    
    //create the favorites value label
    favoritesValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(460, 90, 100, 50)];
    [favoritesValueLabel setText:[NSString stringWithFormat:@"%.00f %%", favoritesSlider.value]];
    [self.view addSubview:favoritesValueLabel];
    
//    // creating random button
//    UIButton *randomButton = [[UIButton alloc] init];
//    randomButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [randomButton addTarget:self action:@selector(randomButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [randomButton setTitle:@"Randomize" forState:UIControlStateNormal];
//    randomButton.titleLabel.font = [UIFont systemFontOfSize:42];
//    randomButton.frame = CGRectMake(170, 650, 430, 170);
//    randomButton.backgroundColor = [UIColor whiteColor];
//    randomButton.layer.borderColor = [UIColor blackColor].CGColor;
//    randomButton.layer.borderWidth = 0.5f;
//    randomButton.layer.cornerRadius = 10.0f;
//    [self.view addSubview:randomButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
