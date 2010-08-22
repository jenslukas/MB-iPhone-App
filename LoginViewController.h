//
//  LoginViewController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 8/10/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Login view, enter and save account information

#import <UIKit/UIKit.h>
#import "StringEditTableCell.h"
#import "ServiceFacade.h"

@interface LoginViewController : UITableViewController <DataCompleteDelegate> {
	@private
	StringEditTableCell *usernameField;
	StringEditTableCell *passwordField;
}

@property(nonatomic, retain) StringEditTableCell *usernameField;
@property(nonatomic, retain) StringEditTableCell *passwordField;
@end
