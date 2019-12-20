/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridAutoresizeSettings.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 * The NGridAutoresizeSettings class describes grid autoresize settings.
 */
@interface NGridAutoresizeSettings : NSObject

/**
 * The maximum acceptable size for the string. This value is used to calculate where line breaks.
 * If width or height equals to 0.0, method ignores corresponding constraints.
 */
@property (assign) CGSize constraintSize;

/**
 * A Boolean value that determines whether column widths are affected by resize.
 */
@property (assign) BOOL resizeWidth;

/**
 * A Boolean value that determines whether row heights are affected by resize.
 */
@property (assign) BOOL resizeHeight;

/**
 * An array of rows to resize. If this array is not nil then only specified rows will be resized.
 */
@property (retain) NSArray *rowsToResize;

/**
 * An array of columns to resize. If this array is not nil then only specified columns will be resized.
 */
@property (retain) NSArray *columnsToResize;

/**
 * A Boolean value that determines whether resize algorithm walks over all cells.
 * By default this value is set to NO to speed up resizing. In this case resize algorithm walks only through the header cells.
 */
@property (assign) BOOL walkThroughAllCells;

/**
 * Creates the default resize settings.
 */
+ (NGridAutoresizeSettings *)defaultSettings;

@end
