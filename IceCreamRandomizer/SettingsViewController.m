//
//  SettingsViewController.m
//  IceCreamRandomizer
//
//  Created by Jeremy Whitaker on 1/28/15.
//  Copyright (c) 2015 SEFCOM User. All rights reserved.
//

#import "SettingsViewController.h"
#import "SefcomMainViewController.h"

@interface SettingsViewController ()
<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@end
UILabel *favoritesValueLabel;
UISlider *favoritesSlider;
NSString *settingsPath;
NSString *inputString;
NSMutableArray *settingsArray;
UIView *editFavoritesView;
UIView *editActivesView;
UIButton *zeroMixinButton;
UIButton *oneMixinButton;
UIButton *twoMixinButton;
UIButton *threeMixinButton;
UITableView *favoritesView;
UITableView *activeIceCreams;
UITableView *activeMixins;
UITapGestureRecognizer *singleTap;
int currentlySelectedButton;

NSMutableArray *zeroMixinFavorites;
NSMutableArray *oneMixinFavorites;
NSMutableArray *twoMixinFavorites;
NSMutableArray *threeMixinFavorites;
NSMutableArray *iceCreams;
NSMutableArray *mixIns;
NSMutableArray *iceCreamActivityArray;
NSMutableArray *mixinActivityArray;
NSString *path0;
NSString *path1;
NSString *path2;
NSString *path3;
NSString *iceCreamPath;
NSString *mixInPath;
NSString *iceCreamActivityPath;
NSString *mixinActivityPath;

@implementation SettingsViewController

- (void) sliderChanged
{
    favoritesValueLabel.text = [NSString stringWithFormat:@"%.00f %%", favoritesSlider.value];
}

- (void) sliderReleased
{
    NSString *stringToWrite = @"";
    BOOL favoriteSettingFound = NO;
    
    int i = 0;
    for (i = 0; i < [settingsArray count]; i++) {
        if ([settingsArray[i] rangeOfString:@"FavoriteValue:"].location != NSNotFound)
        {
            favoriteSettingFound = YES;
            settingsArray[i] = [NSString stringWithFormat:@"FavoriteValue: %.00f\n", favoritesSlider.value];
        }
    }
    // This handles the first case where the setting didn't exist yet.
    if (!favoriteSettingFound)
        [settingsArray addObject:[NSString stringWithFormat:@"FavoriteValue: %.00f\n", favoritesSlider.value]];
    
    // putting the value of the array back into a string to write
    for (NSString *setting in settingsArray) {
        stringToWrite = [stringToWrite stringByAppendingString:setting];
    }
    
    [stringToWrite writeToFile:settingsPath atomically: NO];
}

- (void) loadFavorites
{
    NSString *inputString = [NSString stringWithContentsOfFile:path0 encoding:NSUTF8StringEncoding error:nil];
    
   zeroMixinFavorites = [[NSMutableArray alloc] initWithArray:[inputString componentsSeparatedByString:@"\n"]];
    [zeroMixinFavorites removeLastObject];
    [zeroMixinFavorites sortUsingSelector:@selector(caseInsensitiveCompare:)];
    inputString = [NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:nil];
    oneMixinFavorites = [[NSMutableArray alloc] initWithArray:[inputString componentsSeparatedByString:@"\n"]];
    [oneMixinFavorites removeLastObject];
    [oneMixinFavorites sortUsingSelector:@selector(caseInsensitiveCompare:)];
    
    inputString = [NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
    twoMixinFavorites = [[NSMutableArray alloc] initWithArray:[inputString componentsSeparatedByString:@"\n"]];
    [twoMixinFavorites removeLastObject];
    [twoMixinFavorites sortUsingSelector:@selector(caseInsensitiveCompare:)];
    
    inputString = [NSString stringWithContentsOfFile:path3 encoding:NSUTF8StringEncoding error:nil];
    threeMixinFavorites = [[NSMutableArray alloc] initWithArray:[inputString componentsSeparatedByString:@"\n"]];
    [threeMixinFavorites removeLastObject];
    [threeMixinFavorites sortUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (void) iceCreamsAndMixinsButtonPressed
{
    singleTap.cancelsTouchesInView = NO;
    
    if (editFavoritesView != nil)
        [editFavoritesView removeFromSuperview];
    
    editActivesView = [[UIView alloc] initWithFrame:CGRectMake(35, 230, 700, 600)];
    editActivesView.backgroundColor = [UIColor whiteColor];
    editActivesView.layer.borderColor = [UIColor blackColor].CGColor;
    editActivesView.layer.borderWidth = 1.5f;
    editActivesView.layer.cornerRadius = 10.0f;
    [self.view addSubview:editActivesView];
    
    activeIceCreams = [[UITableView alloc] initWithFrame:CGRectMake(20, 50, 320, 530)];
    activeIceCreams.layer.borderColor = [UIColor blackColor].CGColor;
    activeIceCreams.layer.borderWidth = 0.5f;
    activeIceCreams.layer.cornerRadius = 10.0f;
    [editActivesView addSubview:activeIceCreams];
    //    [self.view addSubview:favoritesView];
    [activeIceCreams setDelegate:self];
    [activeIceCreams setDataSource:self];
    activeIceCreams.allowsSelectionDuringEditing = YES;
    
    activeMixins = [[UITableView alloc] initWithFrame:CGRectMake(360, 50, 320, 530)];
    activeMixins.layer.borderColor = [UIColor blackColor].CGColor;
    activeMixins.layer.borderWidth = 0.5f;
    activeMixins.layer.cornerRadius = 10.0f;
    [editActivesView addSubview:activeMixins];
    //    [self.view addSubview:favoritesView];
    [activeMixins setDelegate:self];
    [activeMixins setDataSource:self];
    activeMixins.allowsSelectionDuringEditing = YES;
}

- (void) editFavoritesButtonPressed
{
    singleTap.cancelsTouchesInView = YES;
    
    if (editActivesView != nil)
        [editActivesView removeFromSuperview];
        
    [self loadFavorites];
    currentlySelectedButton = 5;
    
    editFavoritesView = [[UIView alloc] initWithFrame:CGRectMake(35, 230, 700, 600)];
    editFavoritesView.backgroundColor = [UIColor whiteColor];
    editFavoritesView.layer.borderColor = [UIColor blackColor].CGColor;
    editFavoritesView.layer.borderWidth = 1.5f;
    editFavoritesView.layer.cornerRadius = 10.0f;
    [self.view addSubview:editFavoritesView];
    
    favoritesView = [[UITableView alloc] initWithFrame:CGRectMake(320, 40, 360, 520)];
    favoritesView.layer.borderColor = [UIColor blackColor].CGColor;
    favoritesView.layer.borderWidth = 0.5f;
    favoritesView.layer.cornerRadius = 10.0f;
    [editFavoritesView addSubview:favoritesView];
//    [self.view addSubview:favoritesView];
    [favoritesView setDelegate:self];
    [favoritesView setDataSource:self];
    favoritesView.allowsSelectionDuringEditing = YES;
    
    zeroMixinButton = [[UIButton alloc] init];
    zeroMixinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [zeroMixinButton addTarget:self action:@selector(zeroMixinButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [zeroMixinButton setTitle:@"Zero Mixins" forState:UIControlStateNormal];
    zeroMixinButton.titleLabel.font = [UIFont systemFontOfSize:36];
    zeroMixinButton.frame = CGRectMake(25, 40, 270, 100);
    zeroMixinButton.backgroundColor = [UIColor whiteColor];
    zeroMixinButton.layer.borderColor = [UIColor blackColor].CGColor;
    zeroMixinButton.layer.borderWidth = 0.5f;
    zeroMixinButton.layer.cornerRadius = 10.0f;
    [editFavoritesView addSubview:zeroMixinButton];
    
    oneMixinButton = [[UIButton alloc] init];
    oneMixinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [oneMixinButton addTarget:self action:@selector(oneMixinButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [oneMixinButton setTitle:@"One Mixin" forState:UIControlStateNormal];
    oneMixinButton.titleLabel.font = [UIFont systemFontOfSize:36];
    oneMixinButton.frame = CGRectMake(25, 180, 270, 100);
    oneMixinButton.backgroundColor = [UIColor whiteColor];
    oneMixinButton.layer.borderColor = [UIColor blackColor].CGColor;
    oneMixinButton.layer.borderWidth = 0.5f;
    oneMixinButton.layer.cornerRadius = 10.0f;
    [editFavoritesView addSubview:oneMixinButton];
    
    twoMixinButton = [[UIButton alloc] init];
    twoMixinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [twoMixinButton addTarget:self action:@selector(twoMixinButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [twoMixinButton setTitle:@"Two Mixins" forState:UIControlStateNormal];
    twoMixinButton.titleLabel.font = [UIFont systemFontOfSize:36];
    twoMixinButton.frame = CGRectMake(25, 320, 270, 100);
    twoMixinButton.backgroundColor = [UIColor whiteColor];
    twoMixinButton.layer.borderColor = [UIColor blackColor].CGColor;
    twoMixinButton.layer.borderWidth = 0.5f;
    twoMixinButton.layer.cornerRadius = 10.0f;
    [editFavoritesView addSubview:twoMixinButton];
    
    threeMixinButton = [[UIButton alloc] init];
    threeMixinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [threeMixinButton addTarget:self action:@selector(threeMixinButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [threeMixinButton setTitle:@"Three Mixins" forState:UIControlStateNormal];
    threeMixinButton.titleLabel.font = [UIFont systemFontOfSize:36];
    threeMixinButton.frame = CGRectMake(25, 460, 270, 100);
    threeMixinButton.backgroundColor = [UIColor whiteColor];
    threeMixinButton.layer.borderColor = [UIColor blackColor].CGColor;
    threeMixinButton.layer.borderWidth = 0.5f;
    threeMixinButton.layer.cornerRadius = 10.0f;
    [editFavoritesView addSubview:threeMixinButton];
}

- (void)zeroMixinButtonPressed
{
    zeroMixinButton.layer.borderWidth = 2.0f;
    oneMixinButton.layer.borderWidth = 0.5f;
    twoMixinButton.layer.borderWidth = 0.5f;
    threeMixinButton.layer.borderWidth = 0.5f;
    currentlySelectedButton = 0;
    [favoritesView reloadData];
}

- (void)oneMixinButtonPressed
{
    zeroMixinButton.layer.borderWidth = 0.5f;
    oneMixinButton.layer.borderWidth = 2.0f;
    twoMixinButton.layer.borderWidth = 0.5f;
    threeMixinButton.layer.borderWidth = 0.5f;
    currentlySelectedButton = 1;
    [favoritesView reloadData];
}

- (void)twoMixinButtonPressed
{
    zeroMixinButton.layer.borderWidth = 0.5f;
    oneMixinButton.layer.borderWidth = 0.5f;
    twoMixinButton.layer.borderWidth = 2.0f;
    threeMixinButton.layer.borderWidth = 0.5f;
    currentlySelectedButton = 2;
    [favoritesView reloadData];
}

- (void)threeMixinButtonPressed
{
    zeroMixinButton.layer.borderWidth = 0.5f;
    oneMixinButton.layer.borderWidth = 0.5f;
    twoMixinButton.layer.borderWidth = 0.5f;
    threeMixinButton.layer.borderWidth = 2.0f;
    currentlySelectedButton = 3;
    [favoritesView reloadData];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    if (editFavoritesView != nil && !(location.x > 35 && location.x < 735 && location.y > 230 && location.y < 830))
    {
        [editFavoritesView removeFromSuperview];
        editFavoritesView = nil;
    }
    currentlySelectedButton = 5;
    
    
    if (editActivesView != nil && !(location.x > 35 && location.x < 735 && location.y > 230 && location.y < 830))
    {
        [editActivesView removeFromSuperview];
        editActivesView = nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == favoritesView)
    {
        switch (currentlySelectedButton) {
            case 0:
                return [zeroMixinFavorites count];
                break;
            case 1:
                return [oneMixinFavorites count];
                break;
            case 2:
                return [twoMixinFavorites count];
                break;
            case 3:
                return [threeMixinFavorites count];
                break;
            default:
                break;
        }
    }
    if (tableView == activeIceCreams)
        return [iceCreams count];
    
    if (tableView == activeMixins)
        return [mixIns count];
    
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == favoritesView)
    {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            //add code here for when you hit delete
            switch (currentlySelectedButton) {
                case 0:
                {
                    [zeroMixinFavorites removeObjectAtIndex:indexPath.row];
                    [self deleteZeroMixinFavorites];
                    break;
                }
                    break;
                case 1:
                {
                    [oneMixinFavorites removeObjectAtIndex:indexPath.row];
                    [self deleteOneMixinFavorites];
                    break;
                }
                case 2:
                {
                    [twoMixinFavorites removeObjectAtIndex:indexPath.row];
                    [self deleteTwoMixinFavorites];
                    break;
                }
                case 3:
                {
                    [threeMixinFavorites removeObjectAtIndex:indexPath.row];
                    [self deleteThreeMixinFavorites];
                    break;
                }
                    break;
                default:
                    break;
            }
            [favoritesView reloadData];
        }
    }
}

- (void) deleteZeroMixinFavorites
{
    [@"" writeToFile:path0 atomically:NO encoding:NSUTF8StringEncoding error:nil];
    NSString *stringToWrite = [zeroMixinFavorites componentsJoinedByString:@"\n"];
    if ([stringToWrite length] > 0)
        stringToWrite = [stringToWrite stringByAppendingString:@"\n"];
    [stringToWrite writeToFile:path0 atomically:NO encoding:NSUTF8StringEncoding error:nil];
}

- (void) deleteOneMixinFavorites
{
    [@"" writeToFile:path1 atomically:NO encoding:NSUTF8StringEncoding error:nil];
    NSString *stringToWrite = [oneMixinFavorites componentsJoinedByString:@"\n"];
    if ([stringToWrite length] > 0)
        stringToWrite = [stringToWrite stringByAppendingString:@"\n"];
    [stringToWrite writeToFile:path1 atomically:NO encoding:NSUTF8StringEncoding error:nil];
}

- (void) deleteTwoMixinFavorites
{
    [@"" writeToFile:path2 atomically:NO encoding:NSUTF8StringEncoding error:nil];
    NSString *stringToWrite = [twoMixinFavorites componentsJoinedByString:@"\n"];
    if ([stringToWrite length] > 0)
        stringToWrite = [stringToWrite stringByAppendingString:@"\n"];
    [stringToWrite writeToFile:path2 atomically:NO encoding:NSUTF8StringEncoding error:nil];
}

- (void) deleteThreeMixinFavorites
{
    [@"" writeToFile:path3 atomically:NO encoding:NSUTF8StringEncoding error:nil];
    NSString *stringToWrite = [threeMixinFavorites componentsJoinedByString:@"\n"];
    if ([stringToWrite length] > 0)
        stringToWrite = [stringToWrite stringByAppendingString:@"\n"];
    [stringToWrite writeToFile:path3 atomically:NO encoding:NSUTF8StringEncoding error:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == activeIceCreams)
    {
        if ([[iceCreamActivityArray objectAtIndex:indexPath.row] integerValue])
        {
            iceCreamActivityArray[indexPath.row] = @"0";
            
            NSString *favoriteStringToRemove = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
            [zeroMixinFavorites removeObjectIdenticalTo:favoriteStringToRemove];
            [self deleteZeroMixinFavorites];
            
            NSMutableIndexSet *favoritesToDelete = [[NSMutableIndexSet alloc] init];
            for (int i = 0; i < [oneMixinFavorites count]; i++)
            {
                NSArray *tempFavArray = [oneMixinFavorites[i] componentsSeparatedByString:@"#"];
                if ([tempFavArray containsObject:favoriteStringToRemove])
                    [favoritesToDelete addIndex:i];
            }
            [oneMixinFavorites removeObjectsAtIndexes:favoritesToDelete];
            [self deleteOneMixinFavorites];
            [favoritesToDelete removeAllIndexes];
            
            for (int i = 0; i < [twoMixinFavorites count]; i++)
            {
                NSArray *tempFavArray = [twoMixinFavorites[i] componentsSeparatedByString:@"#"];
                if ([tempFavArray containsObject:favoriteStringToRemove])
                    [favoritesToDelete addIndex:i];
            }
            [twoMixinFavorites removeObjectsAtIndexes:favoritesToDelete];
            [self deleteTwoMixinFavorites];
            [favoritesToDelete removeAllIndexes];
             
            for (int i = 0; i < [threeMixinFavorites count]; i++)
            {
                NSArray *tempFavArray = [threeMixinFavorites[i] componentsSeparatedByString:@"#"];
                if ([tempFavArray containsObject:favoriteStringToRemove])
                    [favoritesToDelete addIndex:i];
            }
            [threeMixinFavorites removeObjectsAtIndexes:favoritesToDelete];
            [self deleteThreeMixinFavorites];
            [favoritesToDelete removeAllIndexes];
        }
        else
            iceCreamActivityArray[indexPath.row] = @"1";
            
        NSString *stringToWrite = [[iceCreamActivityArray componentsJoinedByString:@"\n"] stringByAppendingString:@"\n"];
        [stringToWrite writeToFile:iceCreamActivityPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    if (tableView == activeMixins)
    {
        if ([[mixinActivityArray objectAtIndex:indexPath.row] integerValue])
        {
            mixinActivityArray[indexPath.row] = @"0";
            
            NSString *favoriteStringToRemove = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;

            NSMutableIndexSet *favoritesToDelete = [[NSMutableIndexSet alloc] init];
            for (int i = 0; i < [oneMixinFavorites count]; i++)
            {
                NSArray *tempFavArray = [oneMixinFavorites[i] componentsSeparatedByString:@"#"];
                if ([tempFavArray containsObject:favoriteStringToRemove])
                    [favoritesToDelete addIndex:i];
            }
            [oneMixinFavorites removeObjectsAtIndexes:favoritesToDelete];
            [self deleteOneMixinFavorites];
            [favoritesToDelete removeAllIndexes];
            
            for (int i = 0; i < [twoMixinFavorites count]; i++)
            {
                NSArray *tempFavArray = [twoMixinFavorites[i] componentsSeparatedByString:@"#"];
                if ([tempFavArray containsObject:favoriteStringToRemove])
                    [favoritesToDelete addIndex:i];
            }
            [twoMixinFavorites removeObjectsAtIndexes:favoritesToDelete];
            [self deleteTwoMixinFavorites];
            [favoritesToDelete removeAllIndexes];
            
            for (int i = 0; i < [threeMixinFavorites count]; i++)
            {
                NSArray *tempFavArray = [threeMixinFavorites[i] componentsSeparatedByString:@"#"];
                if ([tempFavArray containsObject:favoriteStringToRemove])
                    [favoritesToDelete addIndex:i];
            }
            [threeMixinFavorites removeObjectsAtIndexes:favoritesToDelete];
            [self deleteThreeMixinFavorites];
            [favoritesToDelete removeAllIndexes];
        }
        else
            mixinActivityArray[indexPath.row] = @"1";
        
        NSString *stringToWrite = [[mixinActivityArray componentsJoinedByString:@"\n"] stringByAppendingString:@"\n"];
        [stringToWrite writeToFile:mixinActivityPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    [tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];

    if (tableView == favoritesView)
    {
        switch (currentlySelectedButton) {
            case 0:
            {
                NSString *filteredString = zeroMixinFavorites[indexPath.row];
                NSRange iceCreamRange = [filteredString rangeOfString:filteredString];
                
                NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:filteredString];
                
                [attrString beginEditing];
                [attrString addAttribute: NSForegroundColorAttributeName
                                   value:[UIColor redColor]
                                   range:iceCreamRange];
                [attrString endEditing];
                
                [cell.textLabel setAttributedText:attrString];
                return cell;
                break;
            }
            case 1:
                {
                NSString *filteredString = [oneMixinFavorites[indexPath.row] stringByReplacingOccurrencesOfString:@"#" withString:@" and "];
                NSArray *tempOneMixinArray = [filteredString componentsSeparatedByString:@" and "];
                NSRange iceCreamRange = [filteredString rangeOfString:[tempOneMixinArray objectAtIndex:0]];
                NSRange mixinOneRange = [filteredString rangeOfString:[tempOneMixinArray objectAtIndex:1]];
                
                NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:filteredString];
                
                [attrString beginEditing];
                [attrString addAttribute: NSForegroundColorAttributeName
                                   value:[UIColor redColor]
                                   range:iceCreamRange];
                
                [attrString addAttribute: NSForegroundColorAttributeName
                                   value:[UIColor blueColor]
                                   range:mixinOneRange];
                
                [attrString endEditing];
                    
                [cell.textLabel setAttributedText:attrString];
                return cell;
                break;
                }
            case 2:
            {
                NSString *filteredString = [twoMixinFavorites[indexPath.row] stringByReplacingOccurrencesOfString:@"#" withString:@" and "];
                NSArray *tempTwoMixinArray = [filteredString componentsSeparatedByString:@" and "];
                NSRange iceCreamRange = [filteredString rangeOfString:[tempTwoMixinArray objectAtIndex:0]];
                NSRange mixinOneRange = [filteredString rangeOfString:[tempTwoMixinArray objectAtIndex:1]];
                NSRange mixinTwoRange = [filteredString rangeOfString:[tempTwoMixinArray objectAtIndex:2]];
                
                NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:filteredString];
                
                [attrString beginEditing];
                [attrString addAttribute: NSForegroundColorAttributeName
                                   value:[UIColor redColor]
                                   range:iceCreamRange];
                
                [attrString addAttribute: NSForegroundColorAttributeName
                                   value:[UIColor blueColor]
                                   range:mixinOneRange];
                
                [attrString addAttribute: NSForegroundColorAttributeName
                                   value:[UIColor blueColor]
                                   range:mixinTwoRange];
                
                [attrString endEditing];
                
                [cell.textLabel setAttributedText:attrString];
                return cell;
                break;
            }
            case 3:
            {
                NSString *filteredString = [threeMixinFavorites[indexPath.row] stringByReplacingOccurrencesOfString:@"#" withString:@" and "];
                NSArray *tempThreeMixinArray = [filteredString componentsSeparatedByString:@" and "];
                NSRange iceCreamRange = [filteredString rangeOfString:[tempThreeMixinArray objectAtIndex:0]];
                NSRange mixinOneRange = [filteredString rangeOfString:[tempThreeMixinArray objectAtIndex:1]];
                NSRange mixinTwoRange = [filteredString rangeOfString:[tempThreeMixinArray objectAtIndex:2]];
                NSRange mixinThreeRange = [filteredString rangeOfString:[tempThreeMixinArray objectAtIndex:3]];

                NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:filteredString];
                
                [attrString beginEditing];
                [attrString addAttribute: NSForegroundColorAttributeName
                                   value:[UIColor redColor]
                                   range:iceCreamRange];
                
                [attrString addAttribute: NSForegroundColorAttributeName
                                   value:[UIColor blueColor]
                                   range:mixinOneRange];
                
                [attrString addAttribute: NSForegroundColorAttributeName
                                   value:[UIColor blueColor]
                                   range:mixinTwoRange];
                
                [attrString addAttribute: NSForegroundColorAttributeName
                                   value:[UIColor blueColor]
                                   range:mixinThreeRange];
                
                [attrString endEditing];
                
                [cell.textLabel setAttributedText:attrString];
                return cell;
                break;
            }
            default:
                break;
        }
    }
    
    if (tableView == activeIceCreams)
    {
        if ([[iceCreamActivityArray objectAtIndex:indexPath.row] integerValue])
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = [[iceCreams objectAtIndex:indexPath.row] objectForKey:@"Name"];
    }
    
    if (tableView == activeMixins)
    {
        if ([[mixinActivityArray objectAtIndex:indexPath.row] integerValue])
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = [[mixIns objectAtIndex:indexPath.row] objectForKey:@"Name"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == favoritesView)
        return 75;
    else
        return 50;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Perform additional setup here
    
    iceCreamPath = [[NSBundle mainBundle] pathForResource:@"IceCream" ofType:@"plist"];
    mixInPath = [[NSBundle mainBundle] pathForResource:@"MixIn" ofType:@"plist"];
    iceCreams = [NSMutableArray arrayWithContentsOfFile:iceCreamPath];
    mixIns = [NSMutableArray arrayWithContentsOfFile:mixInPath];
    
    iceCreamActivityPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/iceCreamActivity.txt"];
    mixinActivityPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/mixinActivity.txt"];
    
    // setting up arrays to be used for selecting rows in active icecream and mixin table views.
    NSString *iceCreamActivitySetting = [NSString stringWithContentsOfFile:iceCreamActivityPath encoding:NSUTF8StringEncoding error:nil];
    NSString *mixinActivitySetting = [NSString stringWithContentsOfFile:mixinActivityPath encoding:NSUTF8StringEncoding error:nil];
    iceCreamActivityArray = [[NSMutableArray alloc] initWithArray:[iceCreamActivitySetting componentsSeparatedByString:@"\n"]];
    [iceCreamActivityArray removeLastObject];
    mixinActivityArray = [[NSMutableArray alloc] initWithArray:[mixinActivitySetting componentsSeparatedByString:@"\n"]];
    [mixinActivityArray removeLastObject];
    
    // setting favorites paths
    path0 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/0MixinFavorites.txt"];
    path1 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/1MixinFavorites.txt"];
    path2 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/2MixinFavorites.txt"];
    path3 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/3MixinFavorites.txt"];
    
    favoritesView.allowsMultipleSelectionDuringEditing = YES;
    
    // setting up tap gesture
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
    
    // Reading settings into an array
    settingsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/settings.txt"];
    inputString = [NSString stringWithContentsOfFile:settingsPath encoding:NSUTF8StringEncoding error:nil];
    // separate string out into an array, add the new value of the slider to the array, and rewrite array to file.
    settingsArray = [[NSMutableArray alloc] initWithArray:[inputString componentsSeparatedByString:@"\n"]];
    [settingsArray removeLastObject];
    
    // Grabbing the initial value of the slider.
    int initialSliderValue = 0;
    for (NSString *setting in settingsArray) {
        if ([setting rangeOfString:@"FavoriteValue:"].location != NSNotFound)
            initialSliderValue = [[setting componentsSeparatedByString:@" "][1] integerValue];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // create the favorites slider
    favoritesSlider = [[UISlider alloc] initWithFrame:CGRectMake(190, 150, 400, 50)];
    favoritesSlider.minimumValue = 0;
    favoritesSlider.maximumValue = 100;
    favoritesSlider.value = initialSliderValue;
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
    
    UIButton *editFavoritesButton = [[UIButton alloc] init];
    editFavoritesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editFavoritesButton addTarget:self action:@selector(editFavoritesButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [editFavoritesButton setTitle:@"Edit Favorites" forState:UIControlStateNormal];
    editFavoritesButton.titleLabel.font = [UIFont systemFontOfSize:28];
    editFavoritesButton.frame = CGRectMake(270, 250, 230, 70);
    editFavoritesButton.backgroundColor = [UIColor whiteColor];
    editFavoritesButton.layer.borderColor = [UIColor blackColor].CGColor;
    editFavoritesButton.layer.borderWidth = 0.5f;
    editFavoritesButton.layer.cornerRadius = 10.0f;
    [self.view addSubview:editFavoritesButton];
    
    UIButton *iceCreamsAndMixinsButton = [[UIButton alloc] init];
    iceCreamsAndMixinsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [iceCreamsAndMixinsButton addTarget:self action:@selector(iceCreamsAndMixinsButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [iceCreamsAndMixinsButton setTitle:@"Ice Creams and Mixins" forState:UIControlStateNormal];
    iceCreamsAndMixinsButton.titleLabel.font = [UIFont systemFontOfSize:28];
    iceCreamsAndMixinsButton.frame = CGRectMake(220, 375, 330, 70);
    iceCreamsAndMixinsButton.backgroundColor = [UIColor whiteColor];
    iceCreamsAndMixinsButton.layer.borderColor = [UIColor blackColor].CGColor;
    iceCreamsAndMixinsButton.layer.borderWidth = 0.5f;
    iceCreamsAndMixinsButton.layer.cornerRadius = 10.0f;
    [self.view addSubview:iceCreamsAndMixinsButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
