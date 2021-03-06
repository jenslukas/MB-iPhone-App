//
//  TypeSelectionController.m
//  Musicbrainz
//
//  Created by Jens Lukas on 6/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract:	Displays the search categories (e.g. Artist, Release) and let the user
//				choose the desired one

#import "TypeSelectionController.h"


@implementation TypeSelectionController
@synthesize search;

-(void)viewDidLoad {
	[self.navigationController setNavigationBarHidden:NO];
	[self.view setBackgroundColor:[UIColor grayColor]];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    SearchTypes type;
	switch (indexPath.row) {
		case 0:
			type = ArtistType;
			break;
		case 1:
			type = ReleaseGroupType;
			break;
		case 2:
			type = LabelType;
			break;
		default:
			break;
	}

	cell.textLabel.text = SearchTypeToString[type];
	
	if([search getType] == type) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		currentType = type;
	}
    
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// unset checkmark at previous selection
	NSIndexPath *oldSelectionIndexPath = [NSIndexPath indexPathForRow:currentType inSection:0];
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:oldSelectionIndexPath];
	cell.accessoryType = UITableViewCellAccessoryNone;
	
	// set new checkmark
	[[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
	
	// set type and return to search view
	switch (indexPath.row) {
		case 0:
			[search setType:ArtistType];
			break;
		case 1:
			[search setType:ReleaseGroupType];
			break;
		case 2:
			[search setType:LabelType];
			break;			
		default:
			break;
	}
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [super dealloc];
}


@end

