//
//  IHPRequestFeedDetailViewController.m
//  iHelp
//
//  Created by Kevin Lin on 10/27/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "IHPRequestFeedDetailViewController.h"

@interface IHPRequestFeedDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailRewardLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailStatusLabel;

@end

@implementation IHPRequestFeedDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailTitleLabel.text = self.request.requestTitle;
    self.detailImageView.image = [UIImage imageNamed:self.request.requestImageURL];
    self.detailStatusLabel.text = self.request.requestStatus;
    self.detailDateLabel.text = [self timeFormattedText:self.request.requestDate];
    self.detailDescriptionLabel.text = self.request.requestDescription;
    self.detailRewardLabel.text = self.request.requestRewardDescription;
    self.detailRewardLabel.text = self.request.requestRewardDescription;
    //    self..text = [NSString stringWithFormat:@"%lu", (NSUInteger)eachRequest.requestViewCount];
    
    
    
    self.tabBarController.tabBar.hidden = YES;
}

- (NSString *)timeFormattedText:(NSTimeInterval)timeInterval{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.timeStyle = NSDateFormatterNoStyle;
    dateFormat.dateStyle = NSDateFormatterMediumStyle;
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormat setLocale:usLocale];
    
    return [dateFormat stringFromDate:date];
}


@end
