/* 
Copyright 2009 Hardcoded Software (http://www.hardcoded.net)

This software is licensed under the "HS" License as described in the "LICENSE" file, 
which should be included with this package. The terms are also available at 
http://www.hardcoded.net/licenses/hs_license
*/

#import "MGAppDelegate.h"
#import "MGDocument.h"
#import "MGConst.h"
#import "MGUtils.h"
#import "RegistrationInterface.h"
#import "Utils.h"
#import "Dialogs.h"
#import "ValueTransformers.h"

@implementation MGAppDelegate

+ (void)initialize
{
    // Value Transformers
    HSVTAdd *vt = [[[HSVTAdd alloc] initWithValue:4] autorelease];
    [NSValueTransformer setValueTransformer:vt forName:@"vtRowHeightOffset"];
    // Register app-wide defaults
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    // Visibility
    [d setObject:b2n(NO) forKey:BalanceSheetDeltaColumnVisible];
    [d setObject:b2n(NO) forKey:BalanceSheetDeltaPercColumnVisible];
    [d setObject:b2n(YES) forKey:BalanceSheetStartColumnVisible];
    [d setObject:b2n(YES) forKey:BalanceSheetBudgetedColumnVisible];
    [d setObject:b2n(YES) forKey:NetWorthGraphVisible];
    [d setObject:b2n(YES) forKey:AssetLiabilityPieChartVisible];
    [d setObject:b2n(NO) forKey:IncomeStatementDeltaColumnVisible];
    [d setObject:b2n(NO) forKey:IncomeStatementDeltaPercColumnVisible];
    [d setObject:b2n(YES) forKey:IncomeStatementLastColumnVisible];
    [d setObject:b2n(YES) forKey:IncomeStatementBudgetedColumnVisible];
    [d setObject:b2n(YES) forKey:ProfitGraphVisible];
    [d setObject:b2n(YES) forKey:IncomeExpensePieChartVisible];
    [d setObject:b2n(YES) forKey:TransactionDescriptionColumnVisible];
    [d setObject:b2n(NO) forKey:TransactionPayeeColumnVisible];
    [d setObject:b2n(NO) forKey:TransactionChecknoColumnVisible];
    [d setObject:b2n(YES) forKey:AccountDescriptionColumnVisible];
    [d setObject:b2n(NO) forKey:AccountPayeeColumnVisible];
    [d setObject:b2n(NO) forKey:AccountChecknoColumnVisible];
    [d setObject:b2n(YES) forKey:AccountGraphVisible];
    [d setObject:b2n(YES) forKey:ScheduleDescriptionColumnVisible];
    [d setObject:b2n(NO) forKey:SchedulePayeeColumnVisible];
    [d setObject:b2n(NO) forKey:ScheduleChecknoColumnVisible];
    // Others
    [d setObject:b2n(YES) forKey:ShowRecurrenceScopeDialog];
    [d setObject:i2n(11) forKey:TableFontSize];
    
    [[NSUserDefaultsController sharedUserDefaultsController] setInitialValues:d];
    [ud registerDefaults:d];
}

- (void)awakeFromNib
{
    Class pyClass = [MGUtils classNamed:@"PyMoneyGuruApp"];
    py = [[pyClass alloc] initWithCocoa:self];
    viewOptionsWindow = [[NSWindowController alloc] initWithWindowNibName:@"ViewOptions"];
    // Some weird bug showed up, and the first document instance (which get access to MGAppDelegate)
    // through [NSApp delegate] would be created before the NIB unarchiver would set the delegate
    // This is why we set it here.
    [NSApp setDelegate:self];
}

- (void)dealloc
{
    // NSLog(@"AppDelegate dealloc");
    [viewOptionsWindow release];
    [py release];
    [super dealloc];
}

- (oneway void)release
{
    // See MGGUIController
    if ([self retainCount] == 2)
    {
        [py free];
    }
    [super release];
}

- (PyMoneyGuruApp *)py
{
    return py;
}

- (IBAction)openExampleDocument:(id)sender
{
    // The goal here is to create a document that behaves as a new document (requires save as), but
    // has the content of the example file.
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *filePath = [bundle pathForResource:@"example" ofType:@"moneyguru"];
    NSDocumentController *dc = [NSDocumentController sharedDocumentController];
    NSError *error;
    MGDocument *doc = [dc makeUntitledDocumentOfType:@"moneyGuru Document" error:&error];
    [doc readFromURL:[NSURL fileURLWithPath:filePath] ofType:@"moneyGuru Document" error:&error];
    [[doc py] adjustExampleFile];
    [dc addDocument:doc];
    [doc makeWindowControllers];
    [doc showWindows];
}

- (IBAction)openWebsite:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.hardcoded.net/moneyguru/"]];
}

- (IBAction)toggleViewOptionsVisible:(id)sender
{
    if ([[viewOptionsWindow window] isVisible])
        [[viewOptionsWindow window] orderOut:sender];
    else
        [[viewOptionsWindow window] makeKeyAndOrderFront:sender];
}

- (IBAction)unlockApp:(id)sender
{
    if ([[self py] isRegistered])
        return;
    RegistrationInterface *ri = [[RegistrationInterface alloc] initWithApp:[self py] name:APPNAME limitDescription:LIMIT_DESC];
    [ri enterCode];    
    [ri release];
}

/* delegate */

- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
    return NO;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    [RegistrationInterface showNagWithApp:[self py] name:APPNAME limitDescription:LIMIT_DESC];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud boolForKey:@"MGHadFirstLaunch"])
    {
        NSArray *recentURLs = [[NSDocumentController sharedDocumentController] recentDocumentURLs];
        if ([recentURLs count] > 0)
        {
            NSError *error;
            NSURL *url = [recentURLs objectAtIndex:0];
            NSDocumentController *documentController = [NSDocumentController sharedDocumentController];
            [documentController openDocumentWithContentsOfURL:url display:YES error:&error];
        }
        else
        {
            NSDocumentController *dc = [NSDocumentController sharedDocumentController];
            [dc openUntitledDocumentOfType:@"moneyGuru Document" display:YES];
        }
    }
    else
    {
        if ([Dialogs askYesNo:@"This is your first time running moneyGuru. Do you want to open the example file?"] == NSAlertFirstButtonReturn)
        {
            [self openExampleDocument:self];
        }
        else
        {
            NSDocumentController *dc = [NSDocumentController sharedDocumentController];
            [dc openUntitledDocumentOfType:@"moneyGuru Document" display:YES];
        }
        [ud setBool:YES forKey:@"MGHadFirstLaunch"];
    }
    // For some messed up reason, simply notifying of a 'py' change here crashes the app, so the 
    // binding cannot be done in the NIB, it has to be done manually here.
    [firstWeekdayPopup bind:@"selectedIndex" toObject:self withKeyPath:@"py.firstWeekday" options:nil];
    [aheadMonthsPopup bind:@"selectedIndex" toObject:self withKeyPath:@"py.aheadMonths" options:nil];
    [yearStartMonthPopup bind:@"selectedIndex" toObject:self withKeyPath:@"py.yearStartMonth" options:nil];
    [autoSaveIntervalField bind:@"value" toObject:self withKeyPath:@"py.autoSaveInterval" options:nil];
    [dontUnreconcileButton bind:@"value" toObject:self withKeyPath:@"py.dontUnreconcile" options:nil];
}

// Python -> Cocoa
- (void)setupAsRegistered
{
    [unlockMenuItem setTitle:@"Thanks for buying moneyGuru!"];
}
@end
