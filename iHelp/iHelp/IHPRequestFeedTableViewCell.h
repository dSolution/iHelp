//
//  IHPRequestFeedTableViewCell.h
//  iHelp
//
//  Created by Kevin Lin on 10/27/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IHPRequestFeedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *requestTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *requestViewCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *requestImageView;
@property (weak, nonatomic) IBOutlet UILabel *requestStatusLabel;

@end
