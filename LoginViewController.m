//
//  LoginViewController.m
//  Musicbrainz
//
//  Created by Jens Lukas on 8/10/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Login view, enter and save account information


#import "LoginViewController.h"
#import "AccountInformation.h"

@implementation LoginViewController
@synthesize usernameField, passwordField;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Login";
	[self.navigationController setNavigationBarHidden:NO];		
	
	// init login cells
	usernameField = [[StringEditTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EditCell"];
	usernameField.cellTextField.placeholder = @"Username";
	[usernameField setType:@"String"];

	passwordField = [[StringEditTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PasswordCell"];
	passwordField.cellTextField.placeholder = @"Password";
	[passwordField setType:@"String"];	
}


#pragma mark -
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	NSInteger numberOfRows;
	if(section == 0) {
		numberOfRows = 2;
	} else {
		numberOfRows = 1;
	}
    return numberOfRows;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if(indexPath.section == 0) {
	switch (indexPath.row) {
		case 0: {
			return usernameField;
			break;
		}
		case 1: {
			return passwordField;
			break;
		}			
		default:
			break;
	}
	} else {
		static NSString *CellIdentifier = @"LoginButton"; 
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}		
		cell.textLabel.text = @"Login";
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		return cell;
	}
	return nil;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// TODO check login
	if(indexPath.row == 2) {
		AccountInformation *account = [AccountInformation alloc];
		[account setAccountInformation:[usernameField getText] withPassword:[passwordField getText]];
		[self.navigationController popViewControllerAnimated:YES];
	} 
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
	[usernameField release];
	[passwordField release];
    [super dealloc];
}


@end

