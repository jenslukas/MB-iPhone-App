//
//  StringEditView.h
//
//  Created by Jens Lukas on 3/17/10.
//  Copyright 2010 Jens Lukas <contact@jenslukas.com>
//
//  This program is made available under the terms of the MIT License.
//
//	Abstract: UITableViewCell with integrated UITextField

@interface StringEditTableCell : UITableViewCell <UITextFieldDelegate> {
	@private
	UITextField *cellTextField; 
}
-(void)setText:(NSString *)text;
-(NSString *)getText;
-(void)setType:(NSString *)type;

@end
