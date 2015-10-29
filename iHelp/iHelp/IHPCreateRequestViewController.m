//
//  IHPCreateRequestViewController.m
//  iHelp
//
//  Created by Kevin Lin on 10/29/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "IHPCreateRequestViewController.h"

@interface IHPCreateRequestViewController ()

@property (nonatomic, strong) UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;
@property (weak, nonatomic) IBOutlet UITextField *durationTextField;

@property (nonatomic, weak) IBOutlet UITextField *selectedTextField;
@property (nonatomic, strong) NSArray *pickerData;
@property (weak, nonatomic) IBOutlet UISwitch *rewardSwitch;

@end

@implementation IHPCreateRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.picker = [UIPickerView new];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    
}
- (IBAction)setPickerViewAsFirstResponder:(id)sender {
    
    NSLog(@"Picker begin!");
    
    self.pickerData = @[@"Animals and Pets",
                        @"Antique",
                        @"Arts",
                        @"Beauty Products",
                        @"Books",
                        @"Cameras",
                        @"Cars",
                        @"Design",
                        @"DIY and Crafts",
                        @"Fashions",
                        @"Foods and Drinks",
                        @"Health and Fitness",
                        @"Services",
                        @"Sports",
                        @"Technology",
                        @"Travel"];
    
    self.categoryTextField.inputView = self.picker;
    self.selectedTextField = self.categoryTextField;
    
    [self.picker becomeFirstResponder];
    
}
- (IBAction)selectRequestDuration:(id)sender {
    self.pickerData = @[@"1 Day",
                        @"5 Days",
                        @"10 Days",
                        @"15 Days",
                        @"1 Month",
                        @"6 Months",
                        @"1 Year",
                        @"No end date"];
    
    self.durationTextField.inputView = self.picker;
    self.selectedTextField = self.durationTextField;
    
    [self.picker becomeFirstResponder];
}
- (IBAction)saveRequestApplication:(id)sender {
    self.tabBarController.selectedIndex = 0;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerData.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.pickerData[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectedTextField.text = self.pickerData[row];
}

@end
