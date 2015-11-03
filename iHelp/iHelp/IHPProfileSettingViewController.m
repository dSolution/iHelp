//
//  IHPProfileSettingViewController.m
//  iHelp
//
//  Created by Kevin Lin on 11/2/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "IHPProfileSettingViewController.h"

@interface IHPProfileSettingViewController () <UITextFieldDelegate>

@property (nonatomic, strong) NSLayoutConstraint *currentFieldConstraint;

@property (weak, nonatomic) IBOutlet UISegmentedControl *genderPicker;
@property (weak, nonatomic) IBOutlet UITextField *lastnameField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *interestsField;
@property (weak, nonatomic) IBOutlet UITextField *introField;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (nonatomic) CGFloat initialHeightConstant;
@property (nonatomic) CGFloat keyboardHeight;

@property (nonatomic, strong) UITextField *activeField;
@property (weak, nonatomic) IBOutlet UIScrollView *currentScrollView;

@end

@implementation IHPProfileSettingViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.initialHeightConstant = [[UIScreen mainScreen] bounds].size.height;
    
    [self.currentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    //[self.view layoutIfNeeded];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.interestsField.delegate = self;
    self.introField.delegate = self;
    self.lastnameField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHideOrSHow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHideOrSHow:) name:UIKeyboardWillHideNotification object:nil];

}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.activeField = textField;
    
    CGFloat textFieldHeight = textField.frame.size.height;
    
    CGPoint location = [textField convertPoint:textField.center toView:self.scrollView];
    CGFloat yPoint = self.scrollView.frame.size.height - self.keyboardHeight;
    
    CGFloat yPosition = location.y + (textFieldHeight/2);
    
    NSLog(@"yPoint: %f, yPosition: %f", yPoint, yPosition);
    CGPoint scrollOffset = CGPointMake(0, (yPosition - yPoint));
    
    if (yPosition > yPoint) {
        NSLog(@"GETTING CALLED@!@@@\n\n");
        [self.currentScrollView setContentOffset:scrollOffset animated:YES];
    }
}

-(void)keyBoardHideOrSHow:(NSNotification *)note{
    CGRect keyBoardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if ([note.name isEqualToString:UIKeyboardWillHideNotification]) {
        keyBoardFrame = CGRectZero;
    }
    
    UIViewAnimationCurve curve = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.keyboardHeight = keyBoardFrame.size.height;
    [UIView animateWithDuration:duration animations:^{
        [UIView setAnimationCurve:curve];
        self.contentViewHeight.constant = self.initialHeightConstant + self.keyboardHeight;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)saveSettings:(id)sender {
}

- (IBAction)cancelSettings:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
