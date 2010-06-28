//
//  ReleaseContoller.m
//  Musicbrainz
//
//  Created by Peter Katheter on 6/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

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
	UILabel *artistNameLabel = [[UILabel alloc] initWithFrame:artistFrame];
	artistNameLabel.font = [UIFont boldSystemFontOfSize:16];
	artistNameLabel.text = self.release.artist; 
	[self.view addSubview:artistNameLabel];

	// release name field
	CGRect releaseFrame = CGRectMake(5, 30, 170, 15);
	UILabel *releaseNameLabel = [[UILabel alloc] initWithFrame:releaseFrame];
	releaseNameLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
	releaseNameLabel.text = self.release.title; 
	[self.view addSubview:releaseNameLabel];

	
	// record field
	CGRect recordFrame = CGRectMake(5, 65, 180, 15);
	UILabel *recordLabel = [[UILabel alloc] initWithFrame:recordFrame];
	recordLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
	recordLabel.text = @"RecordLabel"; 
	[self.view addSubview:recordLabel];	

	// date field
	CGRect dateFrame = CGRectMake(5, 80, 180, 15);
	UILabel *dateLabel = [[UILabel alloc] initWithFrame:dateFrame];
	dateLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
	dateLabel.text = self.release.date; 
	[self.view addSubview:dateLabel];
	
	// album cover
	UIImage *cover = [UIImage imageNamed:@"albumcover.jpg"];
	UIImageView *imageView = [[[UIImageView alloc] initWithImage:cover] autorelease];
	imageView.frame = CGRectMake(190, 10, 120, 117);
	[self.view addSubview:imageView];
	
	// tracks table view
	tracksTable = [[UITableView alloc] initWithFrame:CGRectMake(220, 0, 320, 480) style:UITableViewStyleGrouped];
	tracksTable.delegate = self;
	tracksTable.dataSource = self;
	[self.view addSubview:tracksTable];
}

-(void) edit {

}
								   
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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


- (void)dealloc {
    [super dealloc];
}


@end
