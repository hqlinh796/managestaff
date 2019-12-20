/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridCellType.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

/**
 * NGrid cell type options.
 */
typedef NS_ENUM(NSInteger, NGridCellType) {
    /**
     * This option indicates that the cell is used as a regular cell.
     */
    NGridCellTypeRegular = 1 << 0,
    
    /**
     * The option for row header cells.
     */
    NGridCellTypeRowHeader = 1 << 1,
    
    /**
     * The option for column header cells.
     */
    NGridCellTypeColumnHeader = 1 << 2,
    
    /**
     * This option is used to indicate that the cell is placed in the corner of the table.
     */
    NGridCellTypeCornerHeader = NGridCellTypeRowHeader | NGridCellTypeColumnHeader,
};
