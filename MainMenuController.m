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
#import "ServiceFacade.h"

// PayPal imports
#import "PayPal.h"
#import "MEPAmounts.h"
#import "MEPAddress.h"
#import "PayPalMEPPayment.h"


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
	[editTableCell setText:@"Search text"];
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
		numberOfRows = 4;
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
			int searchType = [search getType];
			cell.textLabel.text = SearchTypeToString[searchType];
			break;
		case 2:
			cell.textLabel.text = @"Search";
			break;
		case 3: {
			/*
			UILabel *advancedSearchLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 200, 27)];
			advancedSearchLabel.font = [UIFont boldSystemFontOfSize:16];
			advancedSearchLabel.text = @"Advanced Search";

			advancedSearchSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(200, 8, 95, 27)];

			[cell.contentView addSubview:advancedSearchLabel];
			[cell.contentView addSubview:advancedSearchSwitch];
			//cell.textLabel.text = @"Advanced Search";
			*/
			UISwitch *advancedSwitch = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
			[cell addSubview:advancedSwitch];
			cell.textLabel.text = @"Advanced Search";
			cell.accessoryView = advancedSwitch;
			 break;
		}
		default:
			break;
	}
	} else if (indexPath.section == 2) {
		cell.textLabel.text = @"Log In";
	} else if(indexPath.section == 3) {
		cell.textLabel.text = @"Donate";
	}
    
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
				// set search info
				search.searchText = [editTableCell getText];
				search.detailSearch = NO;
				
				
				// init view controller depending on search type
				id searchController;
				
				switch([search getType]) {
					case ArtistType:
						searchController = [[ArtistSearchController alloc] initWithStyle:UITableViewStyleGrouped];
						break;
					case ReleaseGroupType:
						searchController = [[ReleaseGroupSearchController alloc] initWithStyle:UITableViewStyleGrouped];
						break;
					case LabelType:
						searchController = [[LabelSearchController alloc] initWithStyle:UITableViewStyleGrouped];
						break;			
				}
				
				// init and start service
				ServiceFacade *service = [[ServiceFacade alloc] autorelease];
				service.delegate = searchController;
				[service search:search];
				
				
				// push view
				[self.navigationController pushViewController:searchController animated:YES];
			}
			default:
				break;
		}
	} else if(indexPath.section == 3) {
			// PayPal integration
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

-(void) donate {
	PayPal *pp = [PayPal getInstance]; 
	[pp DisableShipping]; 
	PayPalMEPPayment *payment =[[PayPalMEPPayment alloc] init]; 
	payment.paymentCurrency=@"USD"; 
	payment.paymentAmount=[NSString stringWithString:@"10.0"]; 
	payment.itemDesc = @"Musicbrainz Donation"; 
	payment.recipient = @"jenslu"; 
	payment.merchantName = @"Jens Lukas"; 
	[pp Checkout:payment]; 
	[payment release];
}

- (void)dealloc {
	[editTableCell release];
	[search release];
    [super dealloc];
}


@end

