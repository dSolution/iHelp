//
//  IHPFeedTableViewController.h
//  iHelp
//
//  Created by Kevin Lin on 10/27/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IHPUser.h"
#import "IHPRequest.h"
#import "IHPRequestDataStore.h"
#import "IHPRequestFeedTableViewCell.h"
#import "IHPRequestFeedDetailViewController.h"

@interface IHPFeedTableViewController : UITableViewController

@property (nonatomic, strong)IHPRequestDataStore *dataStore;

@end
