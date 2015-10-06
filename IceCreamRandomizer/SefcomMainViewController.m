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
NSMutableArray *zeroMixinFavorites;
NSMutableArray *oneMixinFavorites;
NSMutableArray *twoMixinFavorites;
NSMutableArray *threeMixinFavorites;
NSMutableArray *iceCreamActivityArray;
NSMutableArray *mixinActivityArray;
NSInteger numberOfMixins;
UILabel *iceCreamLabel;
UILabel *mixInLabel1;
UILabel *mixInLabel2;
UILabel *mixInLabel3;
NSString *path0;
NSString *path1;
NSString *path2;
NSString *path3;
NSString *settingsPath;
NSString *iceCreamPath;
NSString *mixInPath;
NSString *iceCreamActivityPath;
NSString *mixinActivityPath;
int favoriteChance;

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
    {
        int count = 0;
        for (int i = 0; i < [iceCreamActivityArray count]; i++)
        {
            if ([iceCreamActivityArray[i] integerValue])
                 count ++;
        }
        return count;
    }
    else
    {
        int count = 0;
        for (int i = 0; i < [mixinActivityArray count]; i++)
        {
            if ([mixinActivityArray[i] integerValue])
                 count ++;
        }
        return count;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return numberOfMixins + 1;
}

- (void) favoriteButtonPressed
{
    BOOL alreadyFavorited = NO;
    switch (numberOfMixins) {
        case 0:
        {
            // erase command - uncomment to clear the files.
            //[@"" writeToFile:path0 atomically:NO encoding:NSUTF8StringEncoding error:nil];
            NSString *inputString = [NSString stringWithContentsOfFile:path0 encoding:NSUTF8StringEncoding error:nil];
            NSMutableArray *zeroMixinArray = [[NSMutableArray alloc] initWithArray:[inputString componentsSeparatedByString:@"\n"]];
            
            for (NSString *favorite in zeroMixinArray) {
                if ([iceCreamLabel.text isEqualToString:favorite])
                    alreadyFavorited = YES;
            }
            
            if (!alreadyFavorited){
                [[NSString stringWithFormat:@"%@%@\n",inputString, iceCreamLabel.text] writeToFile: path0 atomically: NO];
                zeroMixinFavorites = [zeroMixinArray mutableCopy];
                [zeroMixinFavorites removeLastObject];
                [zeroMixinFavorites addObject:iceCreamLabel.text];
                
            }
            break;
        }
        case 1:
        {
            
            //[@"" writeToFile:path1 atomically:NO encoding:NSUTF8StringEncoding error:nil];
            NSString *inputString = [NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:nil];
            NSMutableArray *oneMixinArray = [[NSMutableArray alloc] initWithArray:[inputString componentsSeparatedByString:@"\n"]];
            
            NSString *newFavorite = [NSString stringWithFormat:@"%@#%@", iceCreamLabel.text, mixInLabel1.text];
            
            for (NSString *favorite in oneMixinArray) {
                if ([newFavorite isEqualToString:favorite])
                    alreadyFavorited = YES;
            }
            
            if (!alreadyFavorited){
                [[NSString stringWithFormat:@"%@%@\n",inputString, newFavorite] writeToFile: path1 atomically: NO];
                oneMixinFavorites = [oneMixinArray mutableCopy];
                [oneMixinFavorites removeLastObject];
                [oneMixinFavorites addObject:newFavorite];
            }
            break;
        }
        case 2:
        {
//            [@"" writeToFile:path2 atomically:NO encoding:NSUTF8StringEncoding error:nil];
            NSString *inputString = [NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
            NSMutableArray *twoMixinArray = [[NSMutableArray alloc] initWithArray:[inputString componentsSeparatedByString:@"\n"]];
            
            NSString *newFavorite = [NSString stringWithFormat:@"%@#%@#%@", iceCreamLabel.text, mixInLabel1.text, mixInLabel2.text];
            
            for (NSString *favorite in twoMixinArray) {
                if ([newFavorite isEqualToString:favorite])
                    alreadyFavorited = YES;
            }
            
            if (!alreadyFavorited){
//                if ([inputString isEqualToString:@""])
//                    [[NSString stringWithFormat:@"%@\n", newFavorite] writeToFile: path2 atomically: NO];
//                else
                    [[NSString stringWithFormat:@"%@%@\n",inputString, newFavorite] writeToFile: path2 atomically: NO];
                
                twoMixinFavorites = [twoMixinArray mutableCopy];
                [twoMixinFavorites removeLastObject];
                [twoMixinFavorites addObject:newFavorite];
            }
            break;
        }
        case 3:
        {
            //[@"" writeToFile:path3 atomically:NO encoding:NSUTF8StringEncoding error:nil];
            NSString *inputString = [NSString stringWithContentsOfFile:path3 encoding:NSUTF8StringEncoding error:nil];
            NSMutableArray *threeMixinArray = [[NSMutableArray alloc] initWithArray:[inputString componentsSeparatedByString:@"\n"]];
            
            NSString *newFavorite = [NSString stringWithFormat:@"%@#%@#%@#%@", iceCreamLabel.text, mixInLabel1.text, mixInLabel2.text, mixInLabel3.text];
            
            for (NSString *favorite in threeMixinArray) {
                if ([newFavorite isEqualToString:favorite])
                    alreadyFavorited = YES;
            }
            
            if (!alreadyFavorited){
                [[NSString stringWithFormat:@"%@%@\n",inputString, newFavorite] writeToFile: path3 atomically: NO];
                threeMixinFavorites = [threeMixinArray mutableCopy];
                [threeMixinFavorites removeLastObject];
                [threeMixinFavorites addObject:newFavorite];
            }
            break;
        }
        default:
            break;
    }
    
    if (!alreadyFavorited)
    {
        UIAlertView *favoriteAlert = [[UIAlertView alloc] initWithTitle:@"Favorite Added" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [favoriteAlert show];
    }
    else
    {
        UIAlertView *alreadyAddedAlert = [[UIAlertView alloc] initWithTitle:@"Favorite already exists" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alreadyAddedAlert show];
    }
    
}

- (void) addButtonPressed
{
    if ([self numberOfComponentsInPickerView:iceCreamPicker] < 4)
    {
        numberOfMixins ++;
        switch (numberOfMixins) {
            case 1:
                [iceCreamLabel setFrame:CGRectMake(65, 445, 280, 50)];
                [iceCreamLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:26]];
                
                [mixInLabel1 setFrame:CGRectMake(405, 445, 280, 50)];
                [mixInLabel1 setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:26]];
                mixInLabel1.text = [mixIns[0] objectForKey:@"Name"];
                
                [mixInLabel1 setHidden:NO];
                [mixInLabel2 setHidden:YES];
                [mixInLabel3 setHidden:YES];
                break;
            case 2:
                [iceCreamLabel setFrame:CGRectMake(50, 445, 190, 50)];
                [iceCreamLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
                
                [mixInLabel1 setFrame:CGRectMake(285, 445, 190, 50)];
                [mixInLabel1 setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
                
                [mixInLabel2 setFrame:CGRectMake(515, 445, 190, 50)];
                mixInLabel1.text = [mixIns[0] objectForKey:@"Name"];
                mixInLabel2.text = [mixIns[0] objectForKey:@"Name"];
                
                [mixInLabel1 setHidden:NO];
                [mixInLabel2 setHidden:NO];
                [mixInLabel3 setHidden:YES];
                break;
            case 3:
                [iceCreamLabel setFrame:CGRectMake(5, 445, 190, 50)];
                [iceCreamLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
                
                [mixInLabel1 setFrame:CGRectMake(180, 445, 190, 50)];
                [mixInLabel1 setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
                
                [mixInLabel2 setFrame:CGRectMake(375, 445, 190, 50)];
                [mixInLabel3 setFrame:CGRectMake(570, 445, 190, 50)];
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
                [iceCreamLabel setFrame:CGRectMake(215, 445, 330, 50)];
                [iceCreamLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:30]];
                
                [mixInLabel1 setHidden:YES];
                [mixInLabel2 setHidden:YES];
                [mixInLabel3 setHidden:YES];
                break;
            case 1:
                [iceCreamLabel setFrame:CGRectMake(65, 445, 280, 50)];
                [iceCreamLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:26]];
                
                [mixInLabel1 setFrame:CGRectMake(405, 445, 280, 50)];
                [mixInLabel1 setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:26]];
                
                [mixInLabel1 setHidden:NO];
                [mixInLabel2 setHidden:YES];
                [mixInLabel3 setHidden:YES];
                break;
            case 2:
                [iceCreamLabel setFrame:CGRectMake(50, 445, 190, 50)];
                [iceCreamLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
                
                [mixInLabel1 setFrame:CGRectMake(285, 445, 190, 50)];
                [mixInLabel1 setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
                
                [mixInLabel2 setFrame:CGRectMake(515, 445, 190, 50)];
                
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
    // Loading the favoriteChance from the settings text file
    int favoriteChance = 0;
    NSString *settingsString = [NSString stringWithContentsOfFile:settingsPath encoding:NSUTF8StringEncoding error:nil];
    
    NSMutableArray *settingsArray = [[NSMutableArray alloc] initWithArray:[settingsString componentsSeparatedByString:@"\n"]];
    [settingsArray removeLastObject];
    
    for (NSString *setting in settingsArray) {
        if ([setting rangeOfString:@"FavoriteValue:"].location != NSNotFound)
        {
            NSArray *tempArray = [setting componentsSeparatedByString:@" "];
            favoriteChance = [[tempArray objectAtIndex:1] integerValue];
        }
    }
    
    // Deciding whether or not to select a favorite.
    BOOL selectFavorite = NO;
    BOOL emptyFavoritesList = NO;
    NSInteger favoriteRandom = (1 + arc4random() % 100);
    
    if (favoriteRandom <= favoriteChance)
        selectFavorite = YES;
    
    NSInteger selectedIceCream = 0;
    NSInteger selectedMixIn1 = 0;
    NSInteger selectedMixIn2 = 0;
    NSInteger selectedMixIn3 = 0;
    
    if (selectFavorite)
    {
        switch ([self numberOfComponentsInPickerView:iceCreamPicker]) {
            case 1:
            {
                NSString *inputString = [NSString stringWithContentsOfFile:path0 encoding:NSUTF8StringEncoding error:nil];
                NSMutableArray *zeroMixinArray = [[NSMutableArray alloc] initWithArray:[inputString componentsSeparatedByString:@"\n"]];
                [zeroMixinArray removeLastObject];
                
                if ([zeroMixinArray count] > 0)
                {
                    NSInteger tempIceCreamIndex = (0 + arc4random() % ([zeroMixinArray count]));
                    NSString *randFavorite = [zeroMixinArray objectAtIndex:tempIceCreamIndex];
                    
                    for (NSDictionary *iceCream in iceCreams) {
                        if ([[iceCream objectForKey:@"Name"] isEqualToString:randFavorite])
                            selectedIceCream = [iceCreams indexOfObject:iceCream];
                    }
                }
                else
                    emptyFavoritesList = YES;
                break;
            }
            case 2:
            {
                NSString *inputString = [NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:nil];
                NSMutableArray *oneMixinArray = [[NSMutableArray alloc] initWithArray:[inputString componentsSeparatedByString:@"\n"]];
                [oneMixinArray removeLastObject];

                if ([oneMixinArray count] > 0)
                {
                    NSInteger tempFavoriteMixin1 = (0 + arc4random() % ([oneMixinArray count]));
                    NSString *randFavorite = [oneMixinArray objectAtIndex:tempFavoriteMixin1];
                    NSArray *randFavoriteArray = [randFavorite componentsSeparatedByString:@"#"];
                    
                    // matching icecream name
                    for (NSDictionary *iceCream in iceCreams) {
                        if ([[iceCream objectForKey:@"Name"] isEqualToString:randFavoriteArray[0]])
                            selectedIceCream = [iceCreams indexOfObject:iceCream];
                    }
                    
                    
                    // matching mixin1 name
                    for (NSDictionary *mixin1 in mixIns) {
                        if ([[mixin1 objectForKey:@"Name"] isEqualToString:randFavoriteArray[1]])
                            selectedMixIn1 = [mixIns indexOfObject:mixin1];
                    }
                }
                else
                    emptyFavoritesList = YES;
                break;
            }
            case 3:
            {
                NSString *inputString = [NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
                NSMutableArray *twoMixinArray = [[NSMutableArray alloc] initWithArray:[inputString componentsSeparatedByString:@"\n"]];
                [twoMixinArray removeLastObject];

                if ([twoMixinArray count] > 0)
                {
                    NSInteger tempFavoriteMixin1 = (0 + arc4random() % ([twoMixinArray count]));
                    NSString *randFavorite = [twoMixinArray objectAtIndex:tempFavoriteMixin1];
                    NSArray *randFavoriteArray = [randFavorite componentsSeparatedByString:@"#"];
                    
                    // matching icecream name
                    for (NSDictionary *iceCream in iceCreams) {
                        if ([[iceCream objectForKey:@"Name"] isEqualToString:randFavoriteArray[0]])
                            selectedIceCream = [iceCreams indexOfObject:iceCream];
                    }
                    
                    // matching mixin1 name
                    for (NSDictionary *mixin1 in mixIns) {
                        if ([[mixin1 objectForKey:@"Name"] isEqualToString:randFavoriteArray[1]])
                            selectedMixIn1 = [mixIns indexOfObject:mixin1];
                    }
                    
                    // matching mixin2 name
                    for (NSDictionary *mixin2 in mixIns) {
                        if ([[mixin2 objectForKey:@"Name"] isEqualToString:randFavoriteArray[2]])
                            selectedMixIn2 = [mixIns indexOfObject:mixin2];
                    }
                }
                else
                    emptyFavoritesList = YES;
                break;
            }
            case 4:
            {
                NSString *inputString = [NSString stringWithContentsOfFile:path3 encoding:NSUTF8StringEncoding error:nil];
                NSMutableArray *threeMixinArray = [[NSMutableArray alloc] initWithArray:[inputString componentsSeparatedByString:@"\n"]];
                [threeMixinArray removeLastObject];
                
                if ([threeMixinArray count] > 0)
                {
                    NSInteger tempFavoriteMixin1 = (0 + arc4random() % ([threeMixinArray count]));
                    NSString *randFavorite = [threeMixinArray objectAtIndex:tempFavoriteMixin1];
                    NSArray *randFavoriteArray = [randFavorite componentsSeparatedByString:@"#"];
                    // matching icecream name
                    for (NSDictionary *iceCream in iceCreams) {
                        if ([[iceCream objectForKey:@"Name"] isEqualToString:randFavoriteArray[0]])
                            selectedIceCream = [iceCreams indexOfObject:iceCream];
                    }
                
                    // matching mixin1 name
                    for (NSDictionary *mixin1 in mixIns) {
                        if ([[mixin1 objectForKey:@"Name"] isEqualToString:randFavoriteArray[1]])
                            selectedMixIn1 = [mixIns indexOfObject:mixin1];
                    }
                
                    // matching mixin2 name
                    for (NSDictionary *mixin2 in mixIns) {
                        if ([[mixin2 objectForKey:@"Name"] isEqualToString:randFavoriteArray[2]])
                            selectedMixIn2 = [mixIns indexOfObject:mixin2];
                    }
                
                    // matching mixin3 name
                    for (NSDictionary *mixin3 in mixIns) {
                        if ([[mixin3 objectForKey:@"Name"] isEqualToString:randFavoriteArray[1]])
                            selectedMixIn3 = [mixIns indexOfObject:mixin3];
                    }
                }
                else
                    emptyFavoritesList = YES;
                break;
            }
            default:
                break;
        }
    }
    if (emptyFavoritesList || !selectFavorite)
    {
        
        selectedIceCream = (0 + arc4random() % ([iceCreams count] - 0));
        selectedMixIn1 = (0 + arc4random() % ([mixIns count] - 0));
        selectedMixIn2 = (0 + arc4random() % ([mixIns count] - 0));
        selectedMixIn3 = (0 + arc4random() % ([mixIns count] - 0));
    }
    
    // ex for 50% chance of favorite:
    // generate random # between 1 and 100, if > 50, change selected mixins / ice cream to one of the items in the
    // favorite ice creams / favorite mixins array also selected at random. Get the name of the favorite ice cream
    // and favorite mixin at that index, see what index those names correspond to in the full ice cream / mixin arrays.

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

- (void)viewWillAppear:(BOOL)animated
{
    iceCreams = [NSMutableArray arrayWithContentsOfFile:iceCreamPath];
    mixIns = [NSMutableArray arrayWithContentsOfFile:mixInPath];
    
    // deactivating the ice creams and mixins that are not active according to the activity files.
    NSString *iceCreamActivitySetting = [NSString stringWithContentsOfFile:iceCreamActivityPath encoding:NSUTF8StringEncoding error:nil];
    NSString *mixinActivitySetting = [NSString stringWithContentsOfFile:mixinActivityPath encoding:NSUTF8StringEncoding error:nil];
    iceCreamActivityArray = [[NSMutableArray alloc] initWithArray:[iceCreamActivitySetting componentsSeparatedByString:@"\n"]];
    [iceCreamActivityArray removeLastObject];
    mixinActivityArray = [[NSMutableArray alloc] initWithArray:[mixinActivitySetting componentsSeparatedByString:@"\n"]];
    [mixinActivityArray removeLastObject];
    
    NSMutableIndexSet *iceCreamsToDelete = [[NSMutableIndexSet alloc] init];
    NSMutableIndexSet *mixinsToDelete = [[NSMutableIndexSet alloc] init];
    
    for (int i = 0; i < [iceCreamActivityArray count]; i++)
    {
        if ([[iceCreamActivityArray objectAtIndex:i] isEqualToString:@"0"])
            [iceCreamsToDelete addIndex:i];
    }
    
    for (int i = 0; i < [mixinActivityArray count]; i++)
    {
        if ([[mixinActivityArray objectAtIndex:i] isEqualToString:@"0"])
            [mixinsToDelete addIndex:i];
    }
    
    [iceCreams removeObjectsAtIndexes:iceCreamsToDelete];
    [mixIns removeObjectsAtIndexes:mixinsToDelete];
    
    [iceCreamPicker reloadAllComponents];
}

- (void)viewDidLoad
{
    numberOfMixins = 2;
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
    path0 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/0MixinFavorites.txt"];
    path1 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/1MixinFavorites.txt"];
    path2 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/2MixinFavorites.txt"];
    path3 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/3MixinFavorites.txt"];
    settingsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/settings.txt"];
    iceCreamActivityPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/iceCreamActivity.txt"];
    mixinActivityPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/mixinActivity.txt"];
    // create ice cream and mix-in dictionaries
    iceCreamPath = [[NSBundle mainBundle] pathForResource:@"IceCream" ofType:@"plist"];
    mixInPath = [[NSBundle mainBundle] pathForResource:@"MixIn" ofType:@"plist"];
    
    iceCreams = [NSMutableArray arrayWithContentsOfFile:iceCreamPath];
    mixIns = [NSMutableArray arrayWithContentsOfFile:mixInPath];
    
    // creating the active ice cream and mixins activity text files.
    if (![[NSFileManager defaultManager] fileExistsAtPath:iceCreamActivityPath])
    {
        NSMutableString *stringtoWrite = [[NSMutableString alloc] init];
        for (int i = 0; i < [iceCreams count]; i++)
            [stringtoWrite appendString:@"1\n"];
        
        [stringtoWrite writeToFile:iceCreamActivityPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:mixinActivityPath])
    {
        NSMutableString *stringtoWrite = [[NSMutableString alloc] init];
        for (int i = 0; i < [mixIns count]; i++)
            [stringtoWrite appendString:@"1\n"];
        
        [stringtoWrite writeToFile:mixinActivityPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // setting the nav bar button
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(settingsButtonPressed)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    // creating picker view
    iceCreamPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(180, 140, 400, 400)];
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
    randomButton.frame = CGRectMake(170, 725, 430, 170);
    randomButton.backgroundColor = [UIColor whiteColor];
    randomButton.layer.borderColor = [UIColor blackColor].CGColor;
    randomButton.layer.borderWidth = 0.5f;
    randomButton.layer.cornerRadius = 10.0f;
    [self.view addSubview:randomButton];
    
    UIButton *favoriteButton = [[UIButton alloc] init];
    favoriteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [favoriteButton addTarget:self action:@selector(favoriteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [favoriteButton setTitle:@"Favorite" forState:UIControlStateNormal];
    favoriteButton.titleLabel.font = [UIFont systemFontOfSize:28];
    favoriteButton.frame = CGRectMake(295, 550, 180, 70);
    favoriteButton.backgroundColor = [UIColor whiteColor];
    favoriteButton.layer.borderColor = [UIColor blackColor].CGColor;
    favoriteButton.layer.borderWidth = 0.5f;
    favoriteButton.layer.cornerRadius = 10.0f;
    [self.view addSubview:favoriteButton];
    
    // creating addMixIn button
    UIButton *addMixIn = [[UIButton alloc] init];
    addMixIn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addMixIn addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [addMixIn setTitle:@"+" forState:UIControlStateNormal];
    addMixIn.titleLabel.font = [UIFont systemFontOfSize:38];
    addMixIn.frame = CGRectMake(590, 550, 70, 70);
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
    removeMixIn.frame = CGRectMake(105, 550, 70, 70);
    removeMixIn.backgroundColor = [UIColor whiteColor];
    removeMixIn.layer.borderColor = [UIColor blackColor].CGColor;
    removeMixIn.layer.borderWidth = 0.5f;
    removeMixIn.layer.cornerRadius = 10.0f;
    [self.view addSubview:removeMixIn];
    
    iceCreamLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 445, 190, 50)];
    iceCreamLabel.text = [iceCreams[0] objectForKey:@"Name"];
    iceCreamLabel.textColor = [UIColor blackColor];
    [iceCreamLabel setTextAlignment:(UITextAlignmentCenter)];
    [iceCreamLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
    [self.view addSubview:iceCreamLabel];
    
    mixInLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(285, 445, 190, 50)];
    mixInLabel1.text = [mixIns[0] objectForKey:@"Name"];
    mixInLabel1.textColor = [UIColor blackColor];
    [mixInLabel1 setTextAlignment:(UITextAlignmentCenter)];
    [mixInLabel1 setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
    [self.view addSubview:mixInLabel1];
    
    mixInLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(515, 445, 190, 50)];
    mixInLabel2.text = [mixIns[0] objectForKey:@"Name"];
    mixInLabel2.textColor = [UIColor blackColor];
    [mixInLabel2 setTextAlignment:(UITextAlignmentCenter)];
    [mixInLabel2 setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:18]];
    [self.view addSubview:mixInLabel2];
    
    mixInLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(525, 445, 190, 50)];
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
