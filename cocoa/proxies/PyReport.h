/* 
Copyright 2009 Hardcoded Software (http://www.hardcoded.net)

This software is licensed under the "HS" License as described in the "LICENSE" file, 
which should be included with this package. The terms are also available at 
http://www.hardcoded.net/licenses/hs_license
*/

#import <Cocoa/Cocoa.h>

@interface PyReport : PyOutline {}
- (void)addAccount;
- (void)addAccountGroup;
- (BOOL)canDeleteSelected;
- (BOOL)canMovePath:(NSArray *)sourcePath toPath:(NSArray *)destPath;
- (void)deleteSelected;
- (void)movePath:(NSArray *)sourcePath toPath:(NSArray *)destPath;
- (void)showSelectedAccount;
- (BOOL)canShowSelectedAccount;
- (void)toggleExcluded;
- (void)expandPath:(NSArray *)path;
- (void)collapsePath:(NSArray *)path;
@end
