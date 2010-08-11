//
//  ReleaseController.h
//  Musicbrainz
//
//  Created by Jens Lukas on 7/4/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Detail page for release entity

#import "ReleaseContoller.h"
#import "Track.h"

@implementation ReleaseContoller
@synthesize release;

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[self.navigationController setNavigationBarHidden:NO];
	
	//create frame to set bounds of the view
	CGRect frame = CGRectMake(0,0,320,480);
	self.view = [[UIView alloc] initWithFrame:frame];
	self.view.backgroundColor = [UIColor whiteColor];
	self.title = @"Overview";
	
	self.view.backgroundColor = [UIColor colorWithRed:(115.0 / 255.0) green:(109.0 / 255.0) blue:(171.0 / 255.0) alpha:1.0];
	
	//create and add sync button
	UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
	self.navigationItem.rightBarButtonItem = editButton;
	[editButton release];
	
	// create and set text for fields
	// artist field
	CGRect artistFrame = CGRectMake(5, 10, 180, 20);
	artistNameLabel = [[UILabel alloc] initWithFrame:artistFrame];
	artistNameLabel.font = [UIFont boldSystemFontOfSize:16];
	artistNameLabel.backgroundColor = [UIColor colorWithRed:(115.0 / 255.0) green:(109.0 / 255.0) blue:(171.0 / 255.0) alpha:1.0];
	[self.view addSubview:artistNameLabel];

	// release name field
	CGRect releaseFrame = CGRectMake(5, 30, 170, 15);
	releaseNameLabel = [[UILabel alloc] initWithFrame:releaseFrame];
	releaseNameLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
	releaseNameLabel.backgroundColor = [UIColor colorWithRed:(115.0 / 255.0) green:(109.0 / 255.0) blue:(171.0 / 255.0) alpha:1.0];
	[self.view addSubview:releaseNameLabel];

	
	// record field
	CGRect recordFrame = CGRectMake(5, 65, 180, 15);
	recordLabel = [[UILabel alloc] initWithFrame:recordFrame];
	recordLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
	recordLabel.backgroundColor = [UIColor colorWithRed:(115.0 / 255.0) green:(109.0 / 255.0) blue:(171.0 / 255.0) alpha:1.0];
	[self.view addSubview:recordLabel];	

	// date field
	CGRect dateFrame = CGRectMake(5, 80, 180, 15);
	dateLabel = [[UILabel alloc] initWithFrame:dateFrame];
	dateLabel.backgroundColor = [UIColor colorWithRed:(115.0 / 255.0) green:(109.0 / 255.0) blue:(171.0 / 255.0) alpha:1.0];
	dateLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
	[self.view addSubview:dateLabel];
	
	// album coverUILabel *dateLabel
	UIImage *cover = [UIImage imageNamed:@"albumcover.jpg"];
	UIImageView *imageView = [[[UIImageView alloc] initWithImage:cover] autorelease];
	imageView.frame = CGRectMake(190, 10, 120, 117);
	[self.view addSubview:imageView];
	
	// tracks table view
	tracksTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 140, 320, 280) style:UITableViewStyleGrouped];
	tracksTable.delegate = self;
	tracksTable.dataSource = self;
	tracksTable.backgroundColor = [UIColor colorWithRed:(115.0 / 255.0) green:(109.0 / 255.0) blue:(171.0 / 255.0) alpha:1.0];	
	[self.view addSubview:tracksTable];
}

-(void) edit {

}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [release.tracks count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    Track *track = [release.tracks objectAtIndex:indexPath.row];
	cell.textLabel.text	= track.title;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void) finishedRequest:(id) results {
	[activityView stopAnimating];	
	self.release = [results objectAtIndex:0];
	artistNameLabel.text = self.release.artist; 
	releaseNameLabel.text = self.release.title; 	
	recordLabel.text = @"RecordLabel"; 	
	dateLabel.text = self.release.date; 
	[tracksTable reloadData];
}


- (void)dealloc {
	[self.release release];
    [super dealloc];
}


@end
