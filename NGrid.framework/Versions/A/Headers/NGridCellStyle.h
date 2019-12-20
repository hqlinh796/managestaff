/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridCellStyle.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridBrush.h"
#import "NGridConditionalFormattingSettingsProtocol.h"

/**
 * NGrid cell image alignment options.
 * Cell does not check collision of values, so if you specify both Top and Bottom, only Top will be used.
 */
typedef NS_ENUM(NSInteger, NGridImageAlignment) {
	/**
     * Align image along the top edge of the cell.
     */
	NImageVerticalAlignmentTop = 1,
    
	/**
     * Align image along the bottom edge of the cell.
     */
	NImageVerticalAlignmentBottom = 2,
    
	/**
     * Align image along the vertical middle line of the cell.
     */
	NImageVerticalAlignmentCenter = 4,
    
	/**
     * Align image along the left edge of the cell.
     */
	NImageHorizontalAlignmentLeft = 8,
    
	/**
     * Align image along the right edge of the cell.
     */
	NImageHorizontalAlignmentRight = 16,
    
	/**
     * Align image along the horizontal middle line of the cell.
     */
	NImageHorizontalAlignmentCenter = 32,
    
	/**
     * Align image along the left edge of the text in the cell.
     */
    NImageHorizontalAlignmentTextLeft = 64,
    
	/**
     * Align image along the right edge of the text in the cell.
     */
    NImageHorizontalAlignmentTextRight = 128
    
};

/**
 * Image ordering options.
 */
typedef NS_ENUM(NSInteger, NGridImageZOrder) {
	/**
     * Default z order (z = 0).
     */
	NImageZOrderDefault = 0,
    
	/**
     * Z order > 0.
     */
	NImageZOrderFront = 1,
    
	/**
     * Z order < 0.
     */
	NImageZOrderBack = 2
    
};

/**
 * Growth indicator options.
 */
typedef NS_ENUM(NSInteger, NGridGrowthIndicatorType) {
	/**
     * No type.
     */
    NGridGrowthIndicatorTypeNone,
    
	/**
     * By rows.
     */
    NGridGrowthIndicatorTypeByRows,
    
	/**
     * By columns.
     */
    NGridGrowthIndicatorTypeByColumns
    
};

/**
 * The NGridCellStyle class is a container for all available style settings.
 */
@interface NGridCellStyle : NSObject <NSCoding, NSCopying>

/**
 * Background color of the cell.
 */
@property (nonatomic, retain) UIColor *backgroundColor;

/**
 * Background color of cell for highlighted cells.
 */
@property (nonatomic, retain) UIColor *highlightBackgroundColor;

/**
 * Background of the cell that is touched.
 */
@property (nonatomic, retain) UIColor *touchHighlightColor;

/**
 * Alignment of the expander image.
 * Used in expandable cells.
 */
@property (nonatomic, assign) NGridImageAlignment expanderImageAlignment;

/**
 * Top padding of the cell's content in pixels.
 */
@property (nonatomic, assign) CGFloat topPadding;

/**
 * Bottom padding of the cell's content in pixels.
 */
@property (nonatomic, assign) CGFloat bottomPadding;

/**
 * Left padding of the cell's content in pixels.
 */
@property (nonatomic, assign) CGFloat leftPadding;

/**
 * Right padding of the cell's content in pixels.
 */
@property (nonatomic, assign) CGFloat rightPadding;

/**
 * Expander image for the expanded state.
 * Used in expandable cells.
 */
@property (nonatomic, retain) UIImage *expandedImage;

/**
 * Expander image for the collapsed state.
 * Used in expandable cells.
 */
@property (nonatomic, retain) UIImage *collapsedImage;

/**
 * Expander image for the collapsed state in right-to-left mode.
 * Used in expandable cells.
 */
@property (nonatomic, retain) UIImage *collapsedRTLImage;

/**
 * Margins of the expander image in pixels.
 * Used in expandable cells.
 */
@property (nonatomic, assign) CGFloat expanderImageMargin;

/**
 * Common border width in pixels.
 * Setting up this property overrides previously set left, right, top and bottom border widths.
 */
@property (nonatomic, assign) CGFloat borderWidth;

/**
 * Width of the left border in pixels.
 */
@property (nonatomic, assign) CGFloat leftBorderWidth;

/**
 * Width of the right border in pixels.
 */
@property (nonatomic, assign) CGFloat rightBorderWidth;

/**
 * Width of the top border in pixels.
 */
@property (nonatomic, assign) CGFloat topBorderWidth;

/**
 * Width of the bottom border in pixels.
 */
@property (nonatomic, assign) CGFloat bottomBorderWidth;

/**
 * Color of the left border.
 */
@property (nonatomic, retain) UIColor *leftBorderColor;

/**
 * Color of the right border.
 */
@property (nonatomic, retain) UIColor *rightBorderColor;

/**
 * Color of the top border.
 */
@property (nonatomic, retain) UIColor *topBorderColor;

/**
 * Color of the bottom border.
 */
@property (nonatomic, retain) UIColor *bottomBorderColor;

/**
 * Property to store dash pattern for the left border.
 * Expects array of NSNumber values for black and white part lengths.
 */
@property (nonatomic, retain) NSArray *leftBorderDash;

/**
 * Property to store dash patter for the right border.
 * Expects array of NSNumber values for black and white part lengths.
 */
@property (nonatomic, retain) NSArray *rightBorderDash;

/**
 * Property to store dash patter for the top border.
 * Expects array of NSNumber values for black and white part lengths.
 */
@property (nonatomic, retain) NSArray *topBorderDash;

/**
 * Property to store dash patter for the bottom border.
 * Expects array of NSNumber values for black and white part lengths.
 */
@property (nonatomic, retain) NSArray *bottomBorderDash;

/**
 * Font of the cell text.
 */
@property (nonatomic, retain) UIFont *font;

/**
 * Font of the cell text for highlighted cells.
 */
@property (nonatomic, retain) UIFont *highlightFont;

/**
 * Color of the cell text.
 */
@property (nonatomic, retain) UIColor *textColor;

/**
 * Color of the cell text for highlighted cells.
 */
@property (nonatomic, retain) UIColor *highlightTextColor;

/**
 * Alignment of the cell text.
 */
@property (nonatomic, assign) NSTextAlignment textAlignment;

/**
 * Line break mode of the cell text.
 */
@property (nonatomic, assign) NSLineBreakMode lineBreakMode;

/**
 * Indent level of the cell text.
 * In right-to-left mode - indent from the right border, otherwise - from the left border.
 */
@property (nonatomic, assign) NSInteger indent;

/**
 * Indent size in pixels.
 */
@property (nonatomic, assign) CGFloat indentSize;

/**
 * A Boolean value that determines whether the cell background should be different for even and odd rows.
 *
 * If property set to YES then each odd rows will have first color as background color,
 * and each even - second color.
 */
@property (nonatomic, assign) BOOL backgroundColorInterchange;

/**
 * Background color for the odd rows.
 * Used in color interchange mode.
 */
@property (nonatomic, retain) UIColor *firstInterchangedColor;

/**
 * Background color for the even rows.
 * Used in color interchange mode.
 */
@property (nonatomic, retain) UIColor *secondInterchangedColor;

/**
 * Image alignment of the image used for conditional formatting.
 */
@property (nonatomic, assign) NGridImageAlignment imageAlignment;

/**
 * Image z order of the image used for conditional formatting.
 */
@property (nonatomic, assign) NGridImageZOrder imageZOrder;

/**
 * Name of the style.
 */
@property (nonatomic, retain) NSString *styleName;

/**
 * A Boolean value that determines whether the cell text should be bold if cell has children.
 */
@property (nonatomic, assign) BOOL boldForParent;

/**
 * Brush to draw the background of the touched cell.
 */
@property (nonatomic, retain) NGridBrush *clickableCellBackgroundBrush;

/**
 * Brush to draw the background of the cell.
 */
@property (nonatomic, retain) NGridBrush *backgroundBrush;

/**
 * Type of the growth indicator.
 */
@property (nonatomic, assign) NGridGrowthIndicatorType growthIndicatorType;

/**
 * Image containing "less" sign for the growth indicator.
 */
@property (nonatomic, retain) UIImage *growthIndicatorImageLess;

/**
 * Image containing "greater" sign for the growth indicator.
 */
@property (nonatomic, retain) UIImage *growthIndicatorImageGreater;

/**
 * Settings of the conditional formatting.
 */
@property (nonatomic, retain) NSObject<NGridConditionalFormattingSettingsProtocol> *conditionalFormattingSettings;

/**
 * Color of the sparkline line.
 */
@property (nonatomic, retain) UIColor *sparklineLineColor;

/**
 * Color of the marker indicating maximal value on the sparkline.
 */
@property (nonatomic, retain) UIColor *sparklineTopColor;

/**
 * Color of the marker indicating minimal value on the sparkline.
 */
@property (nonatomic, retain) UIColor *sparklineBottomColor;

/**
 * Background color of the sparkline.
 */
@property (nonatomic, retain) UIColor *sparklineBackgroundColor;

/**
 * Background brush of the sparkline.
 */
@property (nonatomic, retain) NGridBrush *sparklineBackgroundBrush;

/**
 * Attributes of the cell text.
 */
@property (nonatomic, retain) NSDictionary *stringAttributes;

/**
 * Attributes of the highlighted cell text.
 */
@property (nonatomic, retain) NSDictionary *highlightedStringAttributes;

/**
 * Creates empty style.
 */
+ (NGridCellStyle *)emptyStyle;

/**
 * Creates default style.
 * Default style contains default settings and may be used as simple base of custom styles.
 */
+ (NGridCellStyle *)defaultStyle;

/**
 * Sets border color for all borders.
 * @param color New border color.
 */
- (void)setBorderColor:(UIColor *)color;

/**
 * Merges current style with another one.
 * All settings merge conflicts are resolved by overriding value from current style by value from given style.
 * @param style Style to merge with.
 */
- (void)mergeWith:(NGridCellStyle *)style;

/**
 * Removes cell background color setting.
 */
- (void)removeBackgroundColor;

/**
 * Removes highlighted cell background color setting.
 */
- (void)removeHighlightBackgroundColor;

/**
 * Removes touched cell background color setting.
 */
- (void)removeTouchHighlightColor;

/**
 * Removes expander image alignment setting.
 */
- (void)removeExpanderImageAlignment;

/**
 * Removes cell content top padding setting.
 */
- (void)removeTopPadding;

/**
 * Removes cell content bottom padding setting.
 */
- (void)removeBottomPadding;

/**
 * Removes cell content left padding setting.
 */
- (void)removeLeftPadding;

/**
 * Removes cell content right padding setting.
 */
- (void)removeRightPadding;

/**
 * Removes expander expanded image setting.
 */
- (void)removeExpandedImage;

/**
 * Removes expander collapsed image setting.
 */
- (void)removeCollapsedImage;

/**
 * Removes expander collapsed in right-to-left mode image setting.
 */
- (void)removeCollapsedRTLImage;

/**
 * Removes expander image margin setting.
 */
- (void)removeExpanderImageMargin;

/**
 * Removes cell border width setting.
 */
- (void)removeBorderWidth;

/**
 * Removes cell left border width setting.
 */
- (void)removeLeftBorderWidth;

/**
 * Removes cell right border width setting.
 */
- (void)removeRightBorderWidth;

/**
 * Removes cell top border width setting.
 */
- (void)removeTopBorderWidth;

/**
 * Removes cell bottom border width setting.
 */
- (void)removeBottomBorderWidth;

/**
 * Removes cell left border color setting.
 */
- (void)removeLeftBorderColor;

/**
 * Removes cell right border color setting.
 */
- (void)removeRightBorderColor;

/**
 * Removes cell top border color setting.
 */
- (void)removeTopBorderColor;

/**
 * Removes cell bottom border color setting.
 */
- (void)removeBottomBorderColor;

/**
 * Removes cell left border dash setting.
 */
- (void)removeLeftBorderDash;

/**
 * Removes cell right border dash setting.
 */
- (void)removeRightBorderDash;

/**
 * Removes cell top border dash setting.
 */
- (void)removeTopBorderDash;

/**
 * Removes cell bottom border dash setting.
 */
- (void)removeBottomBorderDash;

/**
 * Removes cell text font setting.
 */
- (void)removeFont;

/**
 * Removes highlighted cell text font setting.
 */
- (void)removeHighlightFont;

/**
 * Removes cell text color setting.
 */
- (void)removeTextColor;

/**
 * Removes highlighted cell text color setting.
 */
- (void)removeHighlightTextColor;

/**
 * Removes cell text alignment setting.
 */
- (void)removeTextAlignment;

/**
 * Removes cell text line break mode setting.
 */
- (void)removeLineBreakMode;

/**
 * Removes cell text indent setting.
 */
- (void)removeIndent;

/**
 * Removes cell text indent size setting.
 */
- (void)removeIndentSize;

/**
 * Removes cell background color interchange setting.
 */
- (void)removeBackgroundColorInterchange;

/**
 * Removes first cell interchanged color setting.
 */
- (void)removeFirstInterchangedColor;

/**
 * Removes second cell interchanged color setting.
 */
- (void)removeSecondInterchangedColor;

/**
 * Removes conditional formatting image alignment setting.
 */
- (void)removeImageAlignment;

/**
 * Removes conditional formatting image z order setting.
 */
- (void)removeImageZOrder;

/**
 * Removes style name setting.
 */
- (void)removeStyleName;

/**
 * Removes bold-for-parent mode status setting.
 */
- (void)removeBoldForParent;

/**
 * Removes clickable cell background brush setting.
 */
- (void)removeClickableCellBackgroundBrush;

/**
 * Removes cell background brush setting.
 */
- (void)removeBackgroundBrush;

/**
 * Removes conditional format.
 */
- (void)removeConditionalFormat;

/**
 * Removes growth indicator type.
 */
- (void)removeGrowthIndicatorType;

/**
 * Removes less image to growth indicator.
 */
- (void)removeGrowthIndicatorImageLess;

/**
 * Removes greater image to growth indicator.
 */
- (void)removeGrowthIndicatorImageGreater;

/**
 * Removes sparkline line color.
 */
- (void)removeSparklineLineColor;

/**
 * Removes sparkline top color.
 */
- (void)removeSparklineTopColor;

/**
 * Removes sparkline bottom color.
 */
- (void)removeSparklineBottomColor;

/**
 * Removes sparkline background color.
 */
- (void)removeSparklineBackgroundColor;

/**
 * Removes sparkline background brush.
 */
- (void)removeSparklineBackgroundBrush;

@end
