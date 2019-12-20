/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridCellWithSparkline.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import "NGridDecoratedCell.h"
#import "NGridSparklineData.h"

/**
 * The NGridCellWithSparkline class provides an extension for <NGridDecoratedCell> to draw sparklines as the cell content.
 */
@interface NGridCellWithSparkline : NGridDecoratedCell

/**
 * The data to draw sparklines.
 *
 * Should be set before drawing.
 * See <NGridRowData> specifications.
 */
@property (retain) NGridSparklineData *rowData;

@end
