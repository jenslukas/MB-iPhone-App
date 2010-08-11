//
//  LabelViewController.m
//  Musicbrainz
//
//  Created by Jens Lukas on 7/27/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: Detail page for label entity

#import "LabelViewController.h"
#import "TagListViewController.h"


@implementation LabelViewController
@synthesize label;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Label";	
	parsed = NO;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	[self.view addSubview:activityView];
	activityView.center = CGPointMake(160, 180);
	[activityView startAnimating];	
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

	switch(indexPath.row) {
		case 0:
			cell.detailTextLabel.text = @"Title";
			cell.textLabel.text = self.label.name;
			break;
		case 1:
			cell.detailTextLabel.text = @"Type";
			cell.textLabel.text = self.label.type;
			break;
		case 2: {
			NSString *tags = [[self.label.tags valueForKey:@"description"] componentsJoinedByString:@", "];			
			cell.detailTextLabel.text = @"Tags";
			cell.textLabel.text = tags;
			break;
		}
		case 3: {
			// add stars
			UIImage *unratedStar = [UIImage imageNamed:@"unratedStar.png"];
			UIImage *ratedStar = [UIImage imageNamed:@"ratedStar.png"];
			UIImageView *starView;
			
			for (int i = 1; i <= 5; i++) {
				if(i <= [self.label.rating intValue]) {
					starView = [[[UIImageView alloc] initWithImage:ratedStar] autorelease];						
				} else {
					starView = [[[UIImageView alloc] initWithImage:unratedStar] autorelease];												
				}
				
				starView.frame = CGRectMake(5+((i-1)*40), 5, 35, 35);
				[cell.contentView addSubview:starView];				
			}
			
			NSString *ratingText;
			ratingText = @"Average rating: ";
			ratingText = [[[ratingText autorelease] stringByAppendingString:[self.label.rating stringValue]] retain];
			ratingText = [[[ratingText autorelease] stringByAppendingString:@", rated "] retain];
			ratingText = [[[ratingText autorelease] stringByAppendingString:[NSString stringWithFormat:@"%d", self.label.votes]] retain];
			ratingText = [[[ratingText autorelease] stringByAppendingString:@" times"] retain];
			
			// add rating text
			UILabel *ratingLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 260, 17)];
			ratingLabel.text = ratingText;
			ratingLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
			[cell.contentView addSubview:ratingLabel];
			
			break;
		}
			
	}
	
    return cell;
}

-(NSString *)tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger) section {
	return @"General information";
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if(indexPath.section == 0) {
		if(indexPath.row == 3) {
			TagListViewController *tagListViewController = [[TagListViewController alloc] initWithStyle:UITableViewStyleGrouped];
			tagListViewController.entity = self.label;
			
			[self.navigationController pushViewController:tagListViewController animated:YES];
			[tagListViewController release];
		}
	}
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	// return different height for rating cell otherwise default height
	if(indexPath.section == 0 && indexPath.row == 3) {
		return 65;
	}
	return 44;
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

-(void) finishedRequest:(id)results {
	[activityView stopAnimating];
	self.label = [results objectAtIndex:0];
	parsed = YES;
	[self.tableView reloadData];
}

- (void)dealloc {
    [super dealloc];
}


@end

