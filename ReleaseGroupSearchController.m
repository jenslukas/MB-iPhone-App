//
//  ReleaseGroupSearchController.m
//  Musicbrainz
//
//  Created by Jens Lukas on 7/27/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Displays the results of the release group search

#import "ReleaseGroupSearchController.h"
#import "ReleaseGroup.h"
#import "ReleaseSearchController.h"

@implementation ReleaseGroupSearchController
@synthesize releaseGroups;

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.navigationController setNavigationBarHidden:NO];	
	self.title = @"Release group search";
	
	activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	[self.view addSubview:activityView];
	activityView.center = CGPointMake(160, 180);
	[activityView startAnimating];	
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [releaseGroups count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    ReleaseGroup *releaseGroup = [releaseGroups objectAtIndex:indexPath.row];
	cell.textLabel.text	= releaseGroup.title;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// show detail page for selected artist
	ReleaseGroup *releaseGroup = [releaseGroups objectAtIndex:indexPath.row];
	
	ReleaseSearchController *releaseSearchController = [[ReleaseSearchController alloc] initWithStyle:UITableViewStyleGrouped];
	
	// get details for release
	ServiceFacade *serviceFacade = [ServiceFacade alloc];
	serviceFacade.delegate = releaseSearchController;
	[serviceFacade getReleaseGroup:releaseGroup.mbid];
	
	[self.navigationController pushViewController:releaseSearchController	animated:YES];
	[releaseSearchController release];	
}


- (void) finishedRequest:(ServiceResponse *)response {
	[activityView stopAnimating];
	self.releaseGroups = [NSArray arrayWithArray:response.data];
	[self.tableView reloadData];
}

- (void)dealloc {
	self.releaseGroups = nil;
	[self.releaseGroups release];
    [super dealloc];
}

@end


