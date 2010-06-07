//
//  StringEditView.h
//
//  Created by Jens Lukas on 3/17/10.
//  Copyright 2010 Metabrainz Foundation. All rights reserved.
//
// Abstract: UITableViewCell with integrated UITextField

@interface StringEditTableCell : UITableViewCell <UITextFieldDelegate> {
	@private
	UITextField *cellTextField; 
}
-(void)setText:(NSString *)text;
-(NSString *)getText;
-(void)setType:(NSString *)type;

@end
