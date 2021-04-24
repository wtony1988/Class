//
//  Global.h
//
//  Created by Michael on 10/1/16.
//

#ifndef Global_h
#define Global_h

#define DEGREES_TO_RADIANS(x) (M_PI * x / 180.0) 

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define GOOGLE_MAP_API_KEY      @"AIzaSyBK5rykGMTYy10kSJKbycStodfkEsbbp8s"

#define NONE_SELECTED    -1

#define TEACHER_ROLE        0
#define STUDENT_ROLE        1

#define SEARCH_MODE_LIST    0
#define SEARCH_MODE_MAP     1

#define MIN_HOURS           0.5
#define MAX_HOURS           5.0
#define MAX_PRICE           500.0

#define AGE_MIN             16
#define AGE_MAX             70

#define INPUT_TYPE_STRING           0
#define INPUT_TYPE_EMAIL            1
#define INPUT_TYPE_PASSWORD         2
#define INPUT_TYPE_DATE             3
#define INPUT_TYPE_PRICE            4

#define INPUT_TYPE_COUNTRY          5
#define INPUT_TYPE_LANGUAGE         6
#define INPUT_TYPE_PROFICIENCY      7

#define INPUT_TYPE_TEACHER_EXPERTISE    8
#define INPUT_TYPE_DURATION             9
#define INPUT_TYPE_MAP_LOCATION         10

#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height

#define INPUT_CELL_HEIGHT               80.0
#define PICKER_CELL_HEIGHT              80.0
#define RANGE_CELL_HEIGHT               100.0
#define MAP_LOCATION_CELL_HEIGHT        400.0


#define COLOR_CLASS_BORDER              [UIColor colorWithRed:112.0/255.0 green:229.0/255.0 blue:206.0/255.0 alpha:1.0]
#define COLOR_CLASS_BLACK               [UIColor colorWithRed:27.0/255.0 green:33.0/255.0 blue:50.0/255.0 alpha:1.0]
#define COLOR_CLASS_GRAY                [UIColor colorWithRed:126.0/255.0 green:126.0/255.0 blue:153.0/255.0 alpha:1.0]
#define COLOR_CLASS_LIGHT_GRAY          [UIColor colorWithRed:154.0/255.0 green:154.0/255.0 blue:178.0/255.0 alpha:1.0]
#define COLOR_CLASS_GRAY_BORDER         [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0]
#define COLOR_CLASS_RED                 [UIColor colorWithRed:229.0/255.0 green:114.0/255.0 blue:117.0/255.0 alpha:1.0]
#define COLOR_CLASS_DARK_ORANGE         [UIColor colorWithRed:218.0/255.0 green:124.0/255.0 blue:69.0/255.0 alpha:1.0]

#define COLOR_CLASS_CYAN                [UIColor colorWithRed:0.0/255.0 green:189.0/255.0 blue:209.0/255.0 alpha:1.0]
#define COLOR_CLASS_LIGHT_CYAN          [UIColor colorWithRed:97.0/255.0 green:193.0/255.0 blue:203.0/255.0 alpha:1.0]
#define COLOR_CLASS_DARK_CYAN           [UIColor colorWithRed:29.0/255.0 green:166.0/255.0 blue:181.0/255.0 alpha:1.0]
#define COLOR_CLASS_CYAN_SELECTED       [UIColor colorWithRed:23.0/255.0 green:133.0/255.0 blue:145.0/255.0 alpha:1.0]


#define COLOR_CLASS_PURPLE              [UIColor colorWithRed:152.0/255.0 green:74.0/255.0 blue:161.0/255.0 alpha:1.0]
#define COLOR_CLASS_DARK_PURPLE         [UIColor colorWithRed:139.0/255.0 green:64.0/255.0 blue:178.0/255.0 alpha:1.0]
#define COLOR_CLASS_LIGHT_PURPLE        [UIColor colorWithRed:174.0/255.0 green:122.0/255.0 blue:201.0/255.0 alpha:1.0]
#define COLOR_CLASS_PURPLE_SELECTED     [UIColor colorWithRed:111.0/255.0 green:51.0/255.0 blue:142.0/255.0 alpha:1.0]

typedef enum {
    DEVICE_IPHONE_35INCH = 4,
    DEVICE_IPHONE_40INCH,
    DEVICE_IPHONE_47INCH,
    DEVICE_IPHONE_55INCH
} DEVICE_TYPE;

typedef enum {
    IOS_7 = 3,
    IOS_6 = 2,
    IOS_5 = 1,
    IOS_4 = 0,
} IOS_VERSION;

typedef enum {
    LESSON_REQUESTED = 0,
    LESSON_CONFIRMED,
    LESSON_CANCELED,
    LESSON_REJECTED
} LESSON_STATE;

#endif /* Global_h */


