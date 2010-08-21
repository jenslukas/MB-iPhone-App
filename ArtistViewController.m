//
//  ArtistViewController.m
//  Musicbrainz
//
//  Created by Jens Lukas on 7/24/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Detail page for artist entity


#import "ArtistViewController.h"
#import "ReleaseGroup.h"
#import "ReleaseSearchController.h"
#import "TagListViewController.h"
#import "RatingViewController.h"

@implementation ArtistViewController
@synthesize artist;

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

	self.title = @"Artist";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	[self.view addSubview:activityView];
	activityView.center = CGPointMake(160, 180);
	[activityView startAnimating];	
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
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if(self.artist == nil) {
		return 0;
	}
	if(section == 0) {
		return 3;
	} else {
		return [self.artist.releaseGroups count];
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];

	// TODO Figure out way to improve memory usage with reusing cells (not used at the moment due to UI glitches)
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	//	if (cell == nil) {
	//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	//    }
    
	// General artist information
	if (indexPath.section == 0) {
		switch (indexPath.row) {
			case 0:
				cell.detailTextLabel.text = @"Artist";
				cell.textLabel.text = self.artist.name;
				break;
			case 1: {
				NSString *tags = [[self.artist.tags valueForKey:@"description"] componentsJoinedByString:@", "];
				cell.textLabel.text = tags;
				cell.detailTextLabel.text = @"Tags";
				break;
			}				
			case 2: {
				// add stars
				UIImage *unratedStar = [UIImage imageNamed:@"unratedStar.png"];
				UIImage *ratedStar = [UIImage imageNamed:@"ratedStar.png"];
				UIImageView *starView;

				for (int i = 1; i <= 5; i++) {
					if(i <= [self.artist.rating intValue]) {
						starView = [[[UIImageView alloc] initWithImage:ratedStar] autorelease];						
					} else {
						starView = [[[UIImageView alloc] initWithImage:unratedStar] autorelease];												
					}

					starView.frame = CGRectMake(5+((i-1)*40), 5, 35, 35);
					[cell.contentView addSubview:starView];				
				}

				NSString *ratingText;
				ratingText = @"Average rating: ";
				ratingText = [[[ratingText autorelease] stringByAppendingString:[self.artist.rating stringValue]] retain];
				ratingText = [[[ratingText autorelease] stringByAppendingString:@", rated "] retain];
				ratingText = [[[ratingText autorelease] stringByAppendingString:[NSString stringWithFormat:@"%d", self.artist.votes]] retain];
				ratingText = [[[ratingText autorelease] stringByAppendingString:@" times"] retain];
				
				// add rating text
				UILabel *ratingLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 260, 17)];
				ratingLabel.text = ratingText;
				ratingLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
				[cell.contentView addSubview:ratingLabel];
				
				break;
			}
			default:
				break;
		}
	} else if (indexPath.section == 1) {
		ReleaseGroup *releaseGroup = [self.artist.releaseGroups objectAtIndex:indexPath.row];
		cell.textLabel.text = releaseGroup.title;
	}
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	// return different height for rating cell otherwise default height
	if(indexPath.section == 0 && indexPath.row == 2) {
		return 65;
	}
	return 44;
}

-(NSString *)tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger) section {
	NSString *sectionTitle;
	if(section == 0) {
		sectionTitle = @"General information";
	} else if(section == 1) {
		sectionTitle = @"Release Groups";
	}
	return sectionTitle;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if(indexPath.section == 0) {
		if(indexPath.row == 1) {
			TagListViewController *tagListViewController = [[TagListViewController alloc] initWithStyle:UITableViewStyleGrouped];
			tagListViewController.entity = self.artist;
			
			[self.navigationController pushViewController:tagListViewController animated:YES];
			[tagListViewController release];
		} else if(indexPath.row == 2) {
			RatingViewController *ratingViewController = [[RatingViewController alloc] initWithStyle:UITableViewStyleGrouped];
			ratingViewController.entity = self.artist;
			[self.navigationController pushViewController:ratingViewController animated:YES];
		}
	} else if(indexPath.section == 1) {
		// show search results page for selected release group
		ReleaseGroup *releaseGroup = [self.artist.releaseGroups objectAtIndex:indexPath.row];
		ReleaseSearchController *releaseSearchController = [[ReleaseSearchController alloc] initWithStyle:UITableViewStyleGrouped];
	
		// get list of release for release group
		ServiceFacade *serviceFacade = [ServiceFacade alloc];
		serviceFacade.delegate = releaseSearchController;
		[serviceFacade getReleaseGroup:releaseGroup.mbid];
	
		[self.navigationController pushViewController:releaseSearchController animated:YES];
		[releaseSearchController release];
	}
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
- (void) finishedRequest:(ServiceResponse *)response {
	[activityView stopAnimating];
	self.artist = [response.data objectAtIndex:0];
	[self.tableView reloadData];
}

@end

