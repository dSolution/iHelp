//
//  IHPCreateRequestViewController.m
//  iHelp
//
//  Created by Kevin Lin on 10/29/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "IHPCreateRequestViewController.h"
#import "IHPRequestDataStore.h"
#import "IHPRequest.h"

@interface IHPCreateRequestViewController ()

@property (nonatomic, strong) UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;
@property (weak, nonatomic) IBOutlet UITextField *durationTextField;

@property (nonatomic, weak) IBOutlet UITextField *selectedTextField;
@property (nonatomic, strong) NSArray *pickerData;
@property (weak, nonatomic) IBOutlet UISwitch *rewardSwitch;

@property (weak, nonatomic) IBOutlet UITextField *requestTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *requestDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextField *requestRewardDescriptionLabel;


@end

@implementation IHPCreateRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

// category selection
- (IBAction)setPickerViewAsFirstResponder:(id)sender {
    
    NSLog(@"Picker begin!");
    self.picker = [UIPickerView new];
    self.picker.delegate = self;
    self.picker.dataSource = self;
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

// duration selection
- (IBAction)selectRequestDuration:(id)sender {
    self.picker = [UIPickerView new];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    self.pickerData = @[@"1",
                        @"5",
                        @"10",
                        @"15",
                        @"30",
                        @"180",
                        @"365"];
    
    self.durationTextField.inputView = self.picker;
    self.selectedTextField = self.durationTextField;
    
    [self.picker becomeFirstResponder];
}

- (IBAction)saveRequestApplication:(id)sender {
    IHPRequestDataStore *dataStore = [IHPRequestDataStore sharedDataStore];
    NSManagedObjectContext *manageContext = dataStore.managedObjectContext;
    
    IHPRequest *request = [NSEntityDescription insertNewObjectForEntityForName:@"IHPRequest" inManagedObjectContext:manageContext];
    request.requestUser = dataStore.user;
    
    NSDate *today = [NSDate date];
    request.requestTitle = self.requestTitleLabel.text;
    request.requestDescription = self.requestDescriptionLabel.text;
    request.requestImageURL = @"zondaF";
    request.requestCategory = self.categoryTextField.text;
    request.requestViewCount = 0;
    request.requestReward = self.rewardSwitch.on;
    request.requestRewardDescription = self.requestRewardDescriptionLabel.text;
    request.requestDate = [today timeIntervalSinceReferenceDate];
    request.requestDuration = self.durationTextField.text.integerValue;
    request.requestStatus = @"Open";
    
    [dataStore saveContext];
    [dataStore refreshAllRequests];
    
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
