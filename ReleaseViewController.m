//
//  ReleaseViewController.m
//  Musicbrainz
//
//  Created by Peter Katheter on 7/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ReleaseViewController.h"


@implementation ReleaseViewController
@synthesize release;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Release";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
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
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	if(indexPath.section == 1) {
		switch (indexPath.row) {
			case 0:
				cell.detailTextLabel.text = @"Artist";
				cell.textLabel.text = self.release.artist;
				break;
			case 1: {
				UIImage *star = [UIImage imageNamed:@"ratedStar.png"];
				UIImageView *imageView = [[[UIImageView alloc] initWithImage:star] autorelease];
				imageView.frame = CGRectMake(0, 0, 50, 50);
				[cell.contentView addSubview:imageView];
				break;
			}
			default:
				break;
		}
	}
	
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return 180;
	
    return 0;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	// create and set text for fields
	// release name field
	CGRect releaseFrame = CGRectMake(5, 30, 170, 15);
	releaseNameLabel = [[UILabel alloc] initWithFrame:releaseFrame];
	releaseNameLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
	//releaseNameLabel.backgroundColor = [UIColor colorWithRed:(115.0 / 255.0) green:(109.0 / 255.0) blue:(171.0 / 255.0) alpha:1.0];
	
	// record field
	CGRect recordFrame = CGRectMake(5, 65, 180, 15);
	recordLabel = [[UILabel alloc] initWithFrame:recordFrame];
	recordLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
	//recordLabel.backgroundColor = [UIColor colorWithRed:(115.0 / 255.0) green:(109.0 / 255.0) blue:(171.0 / 255.0) alpha:1.0];
	
	// date field
	CGRect dateFrame = CGRectMake(5, 80, 180, 15);
	dateLabel = [[UILabel alloc] initWithFrame:dateFrame];
	dateLabel.backgroundColor = [UIColor colorWithRed:(115.0 / 255.0) green:(109.0 / 255.0) blue:(171.0 / 255.0) alpha:1.0];
	//dateLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
	
	// album coverUILabel *dateLabel
	UIImage *cover = [UIImage imageNamed:@"albumcover.jpg"];
	UIImageView *imageView = [[[UIImageView alloc] initWithImage:cover] autorelease];
	imageView.frame = CGRectMake(190, 10, 120, 117);
	
  	UIView* customView = [[[UIView alloc] 
						   initWithFrame:CGRectMake(10.0, 0.0, 300.0, 180.0)]
						  autorelease];
  	customView.backgroundColor = [UIColor colorWithRed:.6 green:.6 blue:1 alpha:.9];

	[customView addSubview:imageView];
	[customView addSubview:dateLabel];
	[customView addSubview:recordLabel];	
	[customView addSubview:releaseNameLabel];	
		
	return customView;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
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
    [super dealloc];
}

#pragma mark -
#pragma mark DataCompleteDelegate implementation
-(void) finishedRequest:(id)results {
	self.release = [results objectAtIndex:0];
	artistNameLabel.text = self.release.artist; 
	releaseNameLabel.text = self.release.title; 	
	recordLabel.text = @"RecordLabel"; 	
	dateLabel.text = self.release.date; 
	[tracksTable reloadData];	
}

@end

