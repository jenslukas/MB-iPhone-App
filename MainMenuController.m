//
//  MainMenuController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Main Menu view with basic search

#import "MainMenuController.h"
#import "TypeSelectionController.h"
#import "DonateViewController.h"
#import "LoginViewController.h"
#import "ServiceFacade.h"


#import "ReleaseGroupSearchController.h"
#import "ArtistSearchController.h"
#import "LabelSearchController.h"

@implementation MainMenuController
@synthesize editTableCell, search;

-(void) viewDidLoad {
    [super viewDidLoad];
	self.title = @"Musicbrainz";
	self.search = [Search alloc];
	[search setType:ArtistType];
	[self.view setBackgroundColor:[UIColor grayColor]];
	
	// hide navigation bar
	[self.navigationController setNavigationBarHidden:YES];
	
	// init searchText cell
	editTableCell = [[[StringEditTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EditCell"] autorelease];
	editTableCell.delegate = self;
	editTableCell.cellTextField.placeholder = @"Search text";
	[editTableCell setType:@"String"];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	// hide navigation bar
	[self.navigationController setNavigationBarHidden:YES animated:YES];	
	
	[self.tableView reloadData];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

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
    return 4;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
	if(section == 0) {
		numberOfRows = 1;
	} else if(section == 1) {
		numberOfRows = 3;
	} else if(section == 2) {
		numberOfRows = 1;
	} else if(section == 3) {
		numberOfRows = 1;
	}
	return numberOfRows;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	if(indexPath.section == 0) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}		
		cell.textLabel.text = @"Scan barcode";	
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		return cell;
	} else if(indexPath.section == 1) {
	switch (indexPath.row) {
		case 0: {
			StringEditTableCell *cell;
			cell = editTableCell;
			return cell;
			break;
		}
		case 1: {
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			}			
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			int searchType = [search getType];
			cell.textLabel.text = SearchTypeToString[searchType];
			return cell;			
			break;
		}
		case 2: {
			UITableViewCell	*cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Switch"] autorelease];
			UILabel *advancedSearchLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 200, 27)];
			advancedSearchLabel.font = [UIFont boldSystemFontOfSize:16];
			advancedSearchLabel.text = @"Advanced Search";

			advancedSearchSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(200, 8, 95, 27)];

			[cell.contentView addSubview:advancedSearchLabel];
			cell.textLabel.text = @"Advanced Search";
			cell.accessoryView = advancedSearchSwitch;
			return cell;
			break;
		}
		default:
			break;
	}
	} else if (indexPath.section == 2) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}					
		cell.textLabel.text = @"Log In";
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		return cell;
	} else if(indexPath.section == 3) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}					
		cell.textLabel.text = @"Donate";
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		return cell;
	}
    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if(indexPath.section == 0) {
		// open barcode scanner
	} else if(indexPath.section == 1) {
		
		// search stuff
		switch (indexPath.row) {
			// open search type selection
			case 1:
			{
				TypeSelectionController *typeSelectionController = [[TypeSelectionController alloc] initWithStyle:UITableViewStyleGrouped];
				typeSelectionController.search = search;
				[self.navigationController pushViewController:typeSelectionController animated:YES];
				[typeSelectionController release];
				break;
			}
			default:
				break;
		}
	} else if (indexPath.section == 2) {
		LoginViewController *loginViewController = [[LoginViewController alloc] initWithStyle:UITableViewStyleGrouped];
		[self.navigationController pushViewController:loginViewController animated:YES];
	} else if(indexPath.section == 3) {
		DonateViewController *donateViewController = [[DonateViewController alloc] initWithStyle:UITableViewStyleGrouped];
		[self.navigationController pushViewController:donateViewController animated:YES];
	}
}

// table header with MB logo
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	// Create header view
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
	[view autorelease];
	
	if(section == 0) {
		// load Image
		UIImage *logo = [UIImage imageNamed:@"MusicBrainzLogo.png"];
		UIImageView *imageView = [[[UIImageView alloc] initWithImage:logo] autorelease];
		imageView.frame = CGRectMake(73, 5, 174, 120);
		// add image to view
		[view addSubview:imageView];		
	}
	return view;	
}

// section height (relevant for the MB logo)
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	CGFloat height = 0;
	if(section == 0) {
		height = 130;
	}
	return height;
}

- (void)dealloc {
	[editTableCell release];
	[search release];
    [super dealloc];
}

-(void) keyPressed {
	// start search and open corresponding search results view
	// set search info
	search.searchText = [editTableCell getText];
	search.detailSearch = NO;
		
	// init view controller depending on search type
	id searchController;
		
	switch([search getType]) {
		case ArtistType:
			searchController = [[ArtistSearchController alloc] initWithStyle:UITableViewStylePlain];
			break;
		case ReleaseGroupType:
			searchController = [[ReleaseGroupSearchController alloc] initWithStyle:UITableViewStylePlain];
			break;
		case LabelType:
			searchController = [[LabelSearchController alloc] initWithStyle:UITableViewStylePlain];
			break;			
	}
	
	// init and start service
	ServiceFacade *service = [[ServiceFacade alloc] autorelease];
	service.delegate = searchController;
	[service search:search];
	
		
	// push view
	[self.navigationController pushViewController:searchController animated:YES];
}

@end

