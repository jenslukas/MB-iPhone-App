//
//  ReleaseViewController.m
//  Musicbrainz
//
//  Created by Jens Lukas on 7/24/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Detail page for release entity


#import "ReleaseViewController.h"
#import "Track.h"


@implementation ReleaseViewController
@synthesize releaseGroup, selectedReleaseIndex;

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
	parsed = NO;
	self.title = @"Release";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(parsed) {
		if(section == 0) {
			return 5;
		} else if(section == 1) {
			Release *release = [self.releaseGroup.releases objectAtIndex:selectedReleaseIndex];
			return [release.tracks count];
		}
	}
	return 0;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    	
	// TODO
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];

	Release *release = [self.releaseGroup.releases objectAtIndex:self.selectedReleaseIndex];
	if(indexPath.section == 0) {
		switch (indexPath.row) {
			case 0:
				cell.detailTextLabel.text = @"Release";
				cell.textLabel.text = release.title;
				break;
			case 1:
				cell.detailTextLabel.text = @"Artist";
				cell.textLabel.text = release.artist;
				break;
			case 2:
				cell.detailTextLabel.text = @"Date";
				cell.textLabel.text = release.date;
				break;
			case 3: {
				NSString *tags = [[self.releaseGroup.tags valueForKey:@"description"] componentsJoinedByString:@", "];
				cell.textLabel.text = tags;
				cell.detailTextLabel.text = @"Tags";
				break;
			}				
			case 4: {
				// add stars
				UIImage *unratedStar = [UIImage imageNamed:@"unratedStar.png"];
				UIImage *ratedStar = [UIImage imageNamed:@"ratedStar.png"];
				UIImageView *starView;
				
				for (int i = 1; i <= 5; i++) {
					if(i <= [self.releaseGroup.rating intValue]) {
						starView = [[[UIImageView alloc] initWithImage:ratedStar] autorelease];						
					} else {
						starView = [[[UIImageView alloc] initWithImage:unratedStar] autorelease];												
					}
					
					starView.frame = CGRectMake(5+((i-1)*40), 5, 35, 35);
					[cell.contentView addSubview:starView];				
				}
				
				NSString *ratingText;
				ratingText = @"Average rating: ";
				ratingText = [[[ratingText autorelease] stringByAppendingString:[self.releaseGroup.rating stringValue]] retain];
				ratingText = [[[ratingText autorelease] stringByAppendingString:@", rated "] retain];
				ratingText = [[[ratingText autorelease] stringByAppendingString:[NSString stringWithFormat:@"%d", self.releaseGroup.votes]] retain];
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
	} else if(indexPath.section == 1) {
		Track *track = [release.tracks objectAtIndex:indexPath.row];
		cell.textLabel.text = track.title;
	}
	
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	// return different height for rating cell otherwise default height
	if(indexPath.section == 0 && indexPath.row == 4) {
		return 65;
	}
	return 44;
}

-(NSString *)tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger) section {
	NSString *sectionTitle;
	if(section == 0) {
		sectionTitle = @"General information";
	} else if(section == 1) {
		sectionTitle = @"Tracks";
	}
	return sectionTitle;
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
	[self.releaseGroup.releases replaceObjectAtIndex:selectedReleaseIndex withObject:[results objectAtIndex:0]];
	parsed = YES;
	[self.tableView reloadData];	
}

@end