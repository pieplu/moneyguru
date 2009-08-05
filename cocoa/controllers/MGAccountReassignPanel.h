/* 
Copyright 2009 Hardcoded Software (http://www.hardcoded.net)

This software is licensed under the "HS" License as described in the "LICENSE" file, 
which should be included with this package. The terms are also available at 
http://www.hardcoded.net/licenses/hs_license
*/

#import <Cocoa/Cocoa.h>
#import "MGDocument.h"
#import "MGWindowController.h"
#import "PyAccountReassignPanel.h"

@interface MGAccountReassignPanel : MGWindowController {
    IBOutlet NSPopUpButton *accountSelector;
}
- (id)initWithDocument:(MGDocument *)aDocument;
- (PyAccountReassignPanel *)py;
/* Public */
- (void)load;
/* Actions */
- (IBAction)cancel:(id)sender;
- (IBAction)ok:(id)sender;
@end