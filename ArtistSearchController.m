//
//  ArtistSearchController.m
//  Musicbrainz
//
//  Created by Jens Lukas on 6/23/10.
//  Copyright 2010 Metabrainz Foundation. All rights reserved.
//
// Abstract: Displays the results of the Artist Search

#import "ArtistSearchController.h"
#import "ArtistController.h"
#import "Artist.h"


@implementation ArtistSearchController
@synthesize artists;
- (void)viewDidLoad {
    [super viewDidLoad];
	[self.navigationController setNavigationBarHidden:NO];	
	self.title = @"Artist Search";
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
    return [artists count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    Artist *artist = [artists objectAtIndex:indexPath.row];
	cell.textLabel.text	= artist.name;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// show detail page for selected artist
	Artist *artist = [artists objectAtIndex:indexPath.row];
	
	ArtistController *artistController = [[ArtistController alloc] init];
	
	// get details for release
	ServiceFacade *serviceFacade = [ServiceFacade alloc];
	serviceFacade.delegate = artistController;
	[serviceFacade getArtist:artist];
	
	[self.navigationController pushViewController:artistController	animated:YES];
	[artistController release];	
}


- (void)dealloc {
    [super dealloc];
}

- (void) finishedRequest:(NSArray *) results {
	self.artists = [NSArray arrayWithArray:results];
	[self.tableView reloadData];
}

@end

