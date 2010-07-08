//
//  ArtistController.m
//  Musicbrainz
//
//  Created by Jens Lukas on 7/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Detail page for artist entity

#import "ArtistController.h"

@implementation ArtistController
@synthesize artist;


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[self.navigationController setNavigationBarHidden:NO];
	
	//create frame to set bounds of the view
	CGRect frame = CGRectMake(0,0,320,480);
	self.view = [[UIView alloc] initWithFrame:frame];
	self.view.backgroundColor = [UIColor whiteColor];
	self.title = @"Overview";
	
	self.view.backgroundColor = [UIColor colorWithRed:(115.0 / 255.0) green:(109.0 / 255.0) blue:(171.0 / 255.0) alpha:1.0];
	
	//create and add "edit" button
	UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
	self.navigationItem.rightBarButtonItem = editButton;
	[editButton release];
	
	// create fields
	// artist field
	CGRect artistFrame = CGRectMake(5, 10, 180, 20);
	artistNameLabel = [[UILabel alloc] initWithFrame:artistFrame];
	artistNameLabel.font = [UIFont boldSystemFontOfSize:16];
	artistNameLabel.backgroundColor = [UIColor colorWithRed:(115.0 / 255.0) green:(109.0 / 255.0) blue:(171.0 / 255.0) alpha:1.0];
	[self.view addSubview:artistNameLabel];	
	
	// Releases table view
	releasesTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 140, 320, 280) style:UITableViewStyleGrouped];
	releasesTable.delegate = self;
	releasesTable.dataSource = self;
	releasesTable.backgroundColor = [UIColor colorWithRed:(115.0 / 255.0) green:(109.0 / 255.0) blue:(171.0 / 255.0) alpha:1.0];	
	[self.view addSubview:releasesTable];	
}

-(void) edit {
	
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
    return [self.artist.releases count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

    Release *release = [artist.releases objectAtIndex:indexPath.row];
	cell.textLabel.text	= release.title;
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void) finishedRequest:(id) results {
	self.artist = [results objectAtIndex:0];
	artistNameLabel.text = self.artist.name;

	[releasesTable reloadData];
}


- (void)dealloc {
	[self.artist release];
    [super dealloc];
}


@end
