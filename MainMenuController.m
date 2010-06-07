//
//  MainMenuController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 5/27/10.
//  Copyright 2010 Metabrainz Foundation. All rights reserved.
//
//	Abstract: Main Menu view with basic search

#import "MainMenuController.h"
#import "TypeSelectionController.h"
#import "ServiceFacade.h"
#import "ReleaseSearchController.h"


@implementation MainMenuController
@synthesize editTableCell, search;

-(void) viewDidLoad {
    [super viewDidLoad];
	self.title = @"Musicbrainz";
	self.search = [Search alloc];
	[search setType:ArtistType];
	
	// init searchText cell
	editTableCell = [[[StringEditTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EditCell"] autorelease];
	[editTableCell setText:@"Search text"];
	[editTableCell setType:@"String"];
	
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    return 3;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
	if(section == 0) {
		numberOfRows = 1;
	} else if(section == 1) {
		numberOfRows = 4;
	} else if(section == 2) {
		numberOfRows = 1;
	}
	return numberOfRows;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	if(indexPath.section == 0) {
		cell.textLabel.text = @"Scan barcode";	
	} else if(indexPath.section == 1) {
	switch (indexPath.row) {
		case 0:
			cell = editTableCell;
			break;
		case 1:
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			cell.textLabel.text = SearchTypeToString[[search getType]];
			break;
		case 2:
			cell.textLabel.text = @"Search";
			break;
		case 3:
			cell.textLabel.text = @"Advanced Search";
			break;
		default:
			break;
	}
	} else if (indexPath.section == 2) {
		cell.textLabel.text = @"Log In";
	}
    
    // Set up the cell...
	
    return cell;
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
			// start search and open corresponding search results view
			case 2: 
			{
				// set search text
				search.searchText = [editTableCell getText];
				
				// init view controller
				ReleaseSearchController *releaseSearchController = [[ReleaseSearchController alloc] initWithStyle:UITableViewStyleGrouped];
				
				// init and start service
				ServiceFacade *service = [ServiceFacade alloc];
				service.delegate = releaseSearchController;
				[service search:search];
				
				// push view
				[self.navigationController pushViewController:releaseSearchController animated:YES];
			}
			default:
				break;
		}
	}
}

- (void)dealloc {
	[editTableCell release];
	[search release];
    [super dealloc];
}


@end

