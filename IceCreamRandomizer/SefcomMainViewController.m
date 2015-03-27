//
//  SefcomMainViewController.m
//  IceCreamRandomizer
//
//  Created by SEFCOM User on 1/5/15.
//  Copyright (c) 2015 SEFCOM User. All rights reserved.
//

#import "SefcomMainViewController.h"
#import "SettingsViewController.h"

@interface SefcomMainViewController ()
<UIPickerViewDelegate>

@end

UIPickerView *iceCreamPicker;
NSMutableArray *iceCreams;
NSMutableArray *mixIns;
NSMutableArray *iceCreamFavorites;
NSMutableArray *mixInFavorites;
NSInteger numberOfMixins;
UILabel *iceCreamLabel;
UILabel *mixInLabel1;
UILabel *mixInLabel2;
UILabel *mixInLabel3;
NSString *path0;
NSString *path1;
NSString *path2;
NSString *path3;

@implementation SefcomMainViewController

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            [iceCreamLabel setText:[iceCreams[row] objectForKey:@"Name"]];
            break;
        case 1:
            [mixInLabel1 setText:[mixIns[row] objectForKey:@"Name"]];
            break;
        case 2:
            [mixInLabel2 setText:[mixIns[row] objectForKey:@"Name"]];
            break;
        case 3:
            [mixInLabel3 setText:[mixIns[row] objectForKey:@"Name"]];
            break;
            
        default:
            break;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 100;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
// //NOTE: Look at various "." properties of the UIPickerView class to find something to set to an observer to solve this.
//    switch (component) {
//        case 0:
//            [iceCreamLabel setText:[iceCreams[row] objectForKey:@"Name"]];
//            break;
//        case 1:
//            [mixInLabel1 setText:[mixIns[row] objectForKey:@"Name"]];
//            break;
//        case 2:
//            [mixInLabel2 setText:[mixIns[row] objectForKey:@"Name"]];
//            break;
//        case 3:
//            [mixInLabel3 setText:[mixIns[row] objectForKey:@"Name"]];
//            break;
//            
//        default:
//            break;
//    }
    
    if (component == 0)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 100)];
        imgView.image = [UIImage imageNamed:[iceCreams[row] objectForKey:@"Image"]];
        imgView.backgroundColor = [UIColor clearColor];
        return imgView;
    }
    else
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 90)];
        imgView.image = [UIImage imageNamed:[mixIns[row] objectForKey:@"Image"]];
        imgView.backgroundColor = [UIColor clearColor];
        return imgView;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
        return [iceCreams count];
    else
        return [mixIns count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return numberOfMixins + 1;
}

- (void) favoriteButtonPressed
{
    
//    NSString* content = [NSString stringWithContentsOfFile:path0
//                                                  encoding:NSUTF8StringEncoding
//                                                     error:NULL];
    
//    //your variable "deck"
//    [deck writeToFile: docFile atomically: NO];
    
    // creating a dictionary to add to one of the arrays and then write the settingsDict back to file.
    // will need to load the current favorites into writearray and then rewrite that to settings dict.
    NSMutableArray *newFavorite = [[NSMutableArray alloc] init];
    
    switch (numberOfMixins) {
        case 0:
        {
            BOOL alreadyFavorited = NO;
            NSString *inputString = [NSString stringWithContentsOfFile:path0 encoding:NSUTF8StringEncoding error:nil];
            NSMutableArray *zeroMixinArray = [[NSMutableArray alloc] initWithArray:[inputString componentsSeparatedByString:@"\n"]];
            
            for (NSString *favorite in zeroMixinArray) {
                if ([iceCreamLabel.text isEqualToString:favorite])
                    alreadyFavorited = YES;
            }
            
            if (!alreadyFavorited)
                [[NSString stringWithFormat:@"%@\n",iceCreamLabel.text] writeToFile: path0 atomically: NO];
            
            break;
        }
        case 1:
        {
//            [newFavorite addObject:iceCreamLabel.text];
//            [newFavorite addObject:mixInLabel1.text];
//            NSMutableArray *writeArray0 = [[NSMutableArray alloc] initWithArray:[settingsDict objectForKey:@"0MixinFavorites"]];
//            [writeArray0 addObject:newFavorite];
//            [settingsDict setValue:writeArray0 forKey:@"1MixinFavorites"];
            break;
        }
        case 2:
        {
//            [newFavorite addObject:iceCreamLabel.text];
//            [newFavorite addObject:mixInLabel1.text];
//            [newFavorite addObject:mixInLabel2.text];
//            NSMutableArray *writeArray0 = [[NSMutableArray alloc] initWithArray:[settingsDict objectForKey:@"0MixinFavorites"]];
//            [writeArray0 addObject:newFavorite];
//            [settingsDict setValue:writeArray0 forKey:@"2MixinFavorites"];
            break;
        }
        case 3:
        {
//            [newFavorite addObject:iceCreamLabel.text];
//            [newFavorite addObject:mixInLabel1.text];
//            [newFavorite addObject:mixInLabel2.text];
//            [newFavorite addObject:mixInLabel3.text];
//            NSMutableArray *writeArray0 = [[NSMutableArray alloc] initWithArray:[settingsDict objectForKey:@"0MixinFavorites"]];
//            [writeArray0 addObject:newFavorite];
//            [settingsDict setValue:writeArray0 forKey:@"3MixinFavorites"];
            break;
        }
        default:
            break;
    }
    
}

- (void) addButtonPressed
{
    if ([self numberOfComponentsInPickerView:iceCreamPicker] < 4)
    {
        numberOfMixins ++;
        switch (numberOfMixins) {
            case 1:
                [iceCreamLabel setFrame:CGRectMake(65, 545, 280, 50)];
                [iceCreamLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:26]];
                
                [mixInLabel1 setFrame:CGRectMake(405, 545, 280, 50)];
                [mixInLabel1 setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:26]];
                mixInLabel1.text = [mixIns[0] objectForKey:@"Name"];
                
                [mixInLabel1 setHidden:NO];
                [mixInLabel2 setHidden:YES];
                [mixInLabel3 setHidden:YES];
                break;
            case 2:
                [iceCreamLabel setFrame:CGRectMake(50, 545, 190, 50)];
                [iceCreamLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
                
                [mixInLabel1 setFrame:CGRectMake(285, 545, 190, 50)];
                [mixInLabel1 setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
                
                [mixInLabel2 setFrame:CGRectMake(515, 545, 190, 50)];
                mixInLabel1.text = [mixIns[0] objectForKey:@"Name"];
                mixInLabel2.text = [mixIns[0] objectForKey:@"Name"];
                
                [mixInLabel1 setHidden:NO];
                [mixInLabel2 setHidden:NO];
                [mixInLabel3 setHidden:YES];
                break;
            case 3:
                [iceCreamLabel setFrame:CGRectMake(5, 545, 190, 50)];
                [iceCreamLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
                
                [mixInLabel1 setFrame:CGRectMake(180, 545, 190, 50)];
                [mixInLabel1 setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
                
                [mixInLabel2 setFrame:CGRectMake(375, 545, 190, 50)];
                [mixInLabel3 setFrame:CGRectMake(570, 545, 190, 50)];
                mixInLabel1.text = [mixIns[0] objectForKey:@"Name"];
                mixInLabel2.text = [mixIns[0] objectForKey:@"Name"];
                mixInLabel3.text = [mixIns[0] objectForKey:@"Name"];
                
                [mixInLabel1 setHidden:NO];
                [mixInLabel2 setHidden:NO];
                [mixInLabel3 setHidden:NO];
                break;
            default:
                break;
        }
        [iceCreamPicker reloadAllComponents];
    }
}

- (void) removeButtonPressed
{
    if ([self numberOfComponentsInPickerView:iceCreamPicker] > 1)
    {
        numberOfMixins --;
        switch (numberOfMixins) {
            case 0:
                [iceCreamLabel setFrame:CGRectMake(215, 545, 330, 50)];
                [iceCreamLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:30]];
                
                [mixInLabel1 setHidden:YES];
                [mixInLabel2 setHidden:YES];
                [mixInLabel3 setHidden:YES];
                break;
            case 1:
                [iceCreamLabel setFrame:CGRectMake(65, 545, 280, 50)];
                [iceCreamLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:26]];
                
                [mixInLabel1 setFrame:CGRectMake(405, 545, 280, 50)];
                [mixInLabel1 setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:26]];
                
                [mixInLabel1 setHidden:NO];
                [mixInLabel2 setHidden:YES];
                [mixInLabel3 setHidden:YES];
                break;
            case 2:
                [iceCreamLabel setFrame:CGRectMake(50, 545, 190, 50)];
                [iceCreamLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
                
                [mixInLabel1 setFrame:CGRectMake(285, 545, 190, 50)];
                [mixInLabel1 setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
                
                [mixInLabel2 setFrame:CGRectMake(515, 545, 190, 50)];
                
                [mixInLabel1 setHidden:NO];
                [mixInLabel2 setHidden:NO];
                [mixInLabel3 setHidden:YES];
                break;
            default:
                break;
        }
        [iceCreamPicker reloadAllComponents];
    }
}

- (void) randomButtonPressed
{
    
    NSInteger selectedIceCream = (0 + arc4random() % ([iceCreams count] - 0));
    NSInteger selectedMixIn1 = (0 + arc4random() % ([mixIns count] - 0));
    NSInteger selectedMixIn2 = (0 + arc4random() % ([mixIns count] - 0));
    NSInteger selectedMixIn3 = (0 + arc4random() % ([mixIns count] - 0));
    
    // ex for 50% chance of favorite:
    // generate random # between 1 and 100, if > 50, change selected mixins / ice cream to one of the items in the
    // favorite ice creams / favorite mixins array also selected at random. Get the name of the favorite ice cream
    // and favorite mixin at that index, see what index those names correspond to in the full ice cream / mixin

    
    switch ([self numberOfComponentsInPickerView:iceCreamPicker]) {
        case 1:
            [iceCreamPicker selectRow:selectedIceCream inComponent:0 animated:YES];
            [iceCreamLabel setText:[iceCreams[selectedIceCream] objectForKey:@"Name"]];
            break;
        case 2:
            [iceCreamPicker selectRow:selectedIceCream inComponent:0 animated:YES];
            [iceCreamPicker selectRow:selectedMixIn1 inComponent:1 animated:YES];
            [iceCreamLabel setText:[iceCreams[selectedIceCream] objectForKey:@"Name"]];
            [mixInLabel1 setText:[mixIns[selectedMixIn1] objectForKey:@"Name"]];
            break;
        case 3:
            [iceCreamPicker selectRow:selectedIceCream inComponent:0 animated:YES];
            [iceCreamPicker selectRow:selectedMixIn1 inComponent:1 animated:YES];
            [iceCreamPicker selectRow:selectedMixIn2 inComponent:2 animated:YES];
            [iceCreamLabel setText:[iceCreams[selectedIceCream] objectForKey:@"Name"]];
            [mixInLabel1 setText:[mixIns[selectedMixIn1] objectForKey:@"Name"]];
            [mixInLabel2 setText:[mixIns[selectedMixIn2] objectForKey:@"Name"]];
            break;
        case 4:
            [iceCreamPicker selectRow:selectedIceCream inComponent:0 animated:YES];
            [iceCreamPicker selectRow:selectedMixIn1 inComponent:1 animated:YES];
            [iceCreamPicker selectRow:selectedMixIn2 inComponent:2 animated:YES];
            [iceCreamPicker selectRow:selectedMixIn3 inComponent:3 animated:YES];
            [iceCreamLabel setText:[iceCreams[selectedIceCream] objectForKey:@"Name"]];
            [mixInLabel1 setText:[mixIns[selectedMixIn1] objectForKey:@"Name"]];
            [mixInLabel2 setText:[mixIns[selectedMixIn2] objectForKey:@"Name"]];
            [mixInLabel3 setText:[mixIns[selectedMixIn3] objectForKey:@"Name"]];
            break;
        default:
            break;
    }
}

-(void) settingsButtonPressed
{
    SettingsViewController *settings = [[SettingsViewController alloc] init];
    [self.navigationController pushViewController:settings animated:YES];
}

- (void)viewDidLoad
{
    numberOfMixins = 2;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    path0 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/0MixinFavorites.txt"];
    path1 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/1MixinFavorites.txt"];
    path2 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/2MixinFavorites.txt"];
    path3 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/3MixinFavorites.txt"];
    
    if (![fileManager fileExistsAtPath:path0]){
        // create empty textFile;
        [@"" writeToFile:path0 atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    
    // create ice cream and mix-in dictionaries
    NSString *iceCreamPath = [[NSBundle mainBundle] pathForResource:@"IceCream" ofType:@"plist"];
    NSString *mixInPath = [[NSBundle mainBundle] pathForResource:@"MixIn" ofType:@"plist"];
    
    iceCreams = [NSMutableArray arrayWithContentsOfFile:iceCreamPath];
    mixIns = [NSMutableArray arrayWithContentsOfFile:mixInPath];
    
    for (int i = 0; i < [iceCreams count]; i++)
    {
        NSString *myString = [NSString stringWithFormat:@"%@", [iceCreams[i] objectForKey:@"Active"]];
        if ([myString isEqualToString:@"0"])
            [iceCreams removeObjectAtIndex:i];
    }
    
    for (int i = 0; i < [mixIns count]; i++)
    {
        NSString *myString = [NSString stringWithFormat:@"%@", [mixIns[i] objectForKey:@"Active"]];
        if ([myString isEqualToString:@"0"])
            [mixIns removeObjectAtIndex:i];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // setting the nav bar button
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(settingsButtonPressed)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    // creating picker view
    iceCreamPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(180, 240, 400, 400)];
    iceCreamPicker.delegate = self;
    iceCreamPicker.transform = CGAffineTransformMakeScale(1.75, 1.75);
    [iceCreamPicker showsSelectionIndicator];
    [self.view addSubview:iceCreamPicker];
    
    // creating random button
    UIButton *randomButton = [[UIButton alloc] init];
    randomButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [randomButton addTarget:self action:@selector(randomButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [randomButton setTitle:@"Randomize" forState:UIControlStateNormal];
    randomButton.titleLabel.font = [UIFont systemFontOfSize:42];
    randomButton.frame = CGRectMake(170, 650, 430, 170);
    randomButton.backgroundColor = [UIColor whiteColor];
    randomButton.layer.borderColor = [UIColor blackColor].CGColor;
    randomButton.layer.borderWidth = 0.5f;
    randomButton.layer.cornerRadius = 10.0f;
    [self.view addSubview:randomButton];
    
    UIButton *favoriteButton = [[UIButton alloc] init];
    randomButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [randomButton addTarget:self action:@selector(favoriteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [randomButton setTitle:@"Favorite" forState:UIControlStateNormal];
    randomButton.titleLabel.font = [UIFont systemFontOfSize:28];
    randomButton.frame = CGRectMake(290, 90, 180, 70);
    randomButton.backgroundColor = [UIColor whiteColor];
    randomButton.layer.borderColor = [UIColor blackColor].CGColor;
    randomButton.layer.borderWidth = 0.5f;
    randomButton.layer.cornerRadius = 10.0f;
    [self.view addSubview:randomButton];
    
    // creating addMixIn button
    UIButton *addMixIn = [[UIButton alloc] init];
    addMixIn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addMixIn addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [addMixIn setTitle:@"+" forState:UIControlStateNormal];
    addMixIn.titleLabel.font = [UIFont systemFontOfSize:38];
    addMixIn.frame = CGRectMake(575, 90, 70, 70);
    addMixIn.backgroundColor = [UIColor whiteColor];
    addMixIn.layer.borderColor = [UIColor blackColor].CGColor;
    addMixIn.layer.borderWidth = 0.5f;
    addMixIn.layer.cornerRadius = 10.0f;
    [self.view addSubview:addMixIn];
    
    // creating removeMixIn button
    UIButton *removeMixIn = [[UIButton alloc] init];
    removeMixIn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [removeMixIn addTarget:self action:@selector(removeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [removeMixIn setTitle:@"-" forState:UIControlStateNormal];
    removeMixIn.titleLabel.font = [UIFont systemFontOfSize:38];
    removeMixIn.frame = CGRectMake(105, 90, 70, 70);
    removeMixIn.backgroundColor = [UIColor whiteColor];
    removeMixIn.layer.borderColor = [UIColor blackColor].CGColor;
    removeMixIn.layer.borderWidth = 0.5f;
    removeMixIn.layer.cornerRadius = 10.0f;
    [self.view addSubview:removeMixIn];
    
    iceCreamLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 545, 190, 50)];
    iceCreamLabel.text = [iceCreams[0] objectForKey:@"Name"];
    iceCreamLabel.textColor = [UIColor blackColor];
    [iceCreamLabel setTextAlignment:(UITextAlignmentCenter)];
    [iceCreamLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
    [self.view addSubview:iceCreamLabel];
    
    mixInLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(285, 545, 190, 50)];
    mixInLabel1.text = [mixIns[0] objectForKey:@"Name"];
    mixInLabel1.textColor = [UIColor blackColor];
    [mixInLabel1 setTextAlignment:(UITextAlignmentCenter)];
    [mixInLabel1 setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
    [self.view addSubview:mixInLabel1];
    
    mixInLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(515, 545, 190, 50)];
    mixInLabel2.text = [mixIns[0] objectForKey:@"Name"];
    mixInLabel2.textColor = [UIColor blackColor];
    [mixInLabel2 setTextAlignment:(UITextAlignmentCenter)];
    [mixInLabel2 setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
    [self.view addSubview:mixInLabel2];
    
    mixInLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(525, 545, 190, 50)];
    mixInLabel3.text = [mixIns[0] objectForKey:@"Name"];
    mixInLabel3.textColor = [UIColor blackColor];
    [mixInLabel3 setTextAlignment:(UITextAlignmentCenter)];
    [mixInLabel3 setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
    [mixInLabel3 setHidden:YES];
    [self.view addSubview:mixInLabel3];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
