/* 
Copyright 2009 Hardcoded Software (http://www.hardcoded.net)

This software is licensed under the "HS" License as described in the "LICENSE" file, 
which should be included with this package. The terms are also available at 
http://www.hardcoded.net/licenses/hs_license
*/

#import <Cocoa/Cocoa.h>
#import "MGOutlinePrint.h"
#import "MGDoubleView.h"

@interface MGSheetPrint : MGOutlinePrint
{
    NSView *graphView;
    MGDoubleView *pieViews;
    int piePage;
    int graphPage;
    BOOL graphVisible;
    BOOL pieVisible;
}
- (id)initWithPyParent:(id)pyParent outlineView:(NSOutlineView *)aOutlineView 
    graphView:(NSView *)aGraphView pieViews:(MGDoubleView *)aPieViews;
@end