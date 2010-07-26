//
//  TrackViewController.m
//  Musicbrainz
//
//  Created by Jens Lukas on 7/27/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Detail page for track entity


#import "TrackViewController.h"

@implementation TrackViewController
@synthesize track;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	parsed = NO;
	self.title = @"Track";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
} 

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(parsed) {
		return 4;	
	} else {
		return 0;
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	
	// General track information
	switch (indexPath.row) {
		case 0:
			cell.detailTextLabel.text = @"Title";
			cell.textLabel.text = self.track.title;
			break;
		case 1:
			cell.detailTextLabel.text = @"Length";
			NSInteger minutes = self.track.length / 1000 / 60;
			NSInteger seconds = (self.track.length / 1000) - (minutes*60);
			cell.textLabel.text = [NSString stringWithFormat:@"%d:%d", minutes, seconds];
			break;
		case 2: {
			NSString *tags = [[self.track.tags valueForKey:@"description"] componentsJoinedByString:@", "];
			cell.textLabel.text = tags;
			cell.detailTextLabel.text = @"Tags";
			break;
		}				
		case 3: {
			// add stars
			UIImage *unratedStar = [UIImage imageNamed:@"unratedStar.png"];
			UIImage *ratedStar = [UIImage imageNamed:@"ratedStar.png"];
			UIImageView *starView;
			
			for (int i = 1; i <= 5; i++) {
				if(i <= [self.track.rating intValue]) {
					starView = [[[UIImageView alloc] initWithImage:ratedStar] autorelease];						
				} else {
					starView = [[[UIImageView alloc] initWithImage:unratedStar] autorelease];												
				}
				
				starView.frame = CGRectMake(5+((i-1)*40), 5, 35, 35);
				[cell.contentView addSubview:starView];				
			}
				
			NSString *ratingText;
			ratingText = @"Average rating: ";
			ratingText = [[[ratingText autorelease] stringByAppendingString:[self.track.rating stringValue]] retain];
			ratingText = [[[ratingText autorelease] stringByAppendingString:@", rated "] retain];
			ratingText = [[[ratingText autorelease] stringByAppendingString:[NSString stringWithFormat:@"%d", self.track.votes]] retain];
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
	
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	// return different height for rating cell otherwise default height
	if(indexPath.section == 0 && indexPath.row == 3) {
		return 65;
	}
	return 44;
}

-(NSString *)tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger) section {
	return @"General information";
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
	self.track = [results objectAtIndex:0];
	parsed = YES;
	[self.tableView reloadData];
}

@end

