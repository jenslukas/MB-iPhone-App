//
//  DonateViewController.h
//  Musicbrainz
//
//  Created by Peter Katheter on 8/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPal.h"

@interface DonateViewController : UITableViewController <PayPalMEPDelegate> {
	NSString *amount;
}
@end
