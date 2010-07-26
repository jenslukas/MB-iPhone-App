//
//  ReleaseSearchController.m
//  Musicbrainz
//
//  Created by Jens Lukas on 7/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Displays the results of the Release Search

#import "ReleaseSearchController.h"
#import "ReleaseViewController.h"
#import "Release.h"


@implementation ReleaseSearchController
@synthesize releases;
- (void)viewDidLoad {
    [super viewDidLoad];
	[self.navigationController setNavigationBarHidden:NO];	
	self.title = @"Release Search";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    return [releases count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    Release *release = [releases objectAtIndex:indexPath.row];
	cell.textLabel.text	= release.title;
	cell.detailTextLabel.text = release.artist;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// show detail page for selected release
	Release *release = [releases objectAtIndex:indexPath.row];
	
	ReleaseViewController *releaseController = [[ReleaseViewController alloc] initWithStyle:UITableViewStyleGrouped];
	
	// get details for release
	ServiceFacade *serviceFacade = [ServiceFacade alloc];
	serviceFacade.delegate = releaseController;
	[serviceFacade getRelease:release];
	
	[self.navigationController pushViewController:releaseController	animated:YES];
	[releaseController release];
}


- (void)dealloc {
    [super dealloc];
}

- (void) finishedRequest:(NSArray *) results {
	self.releases = [NSArray arrayWithArray:results];
	[self.tableView reloadData];
}

@end

