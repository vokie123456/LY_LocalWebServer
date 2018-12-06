//
//  Config.h
//  LY_LocalWebServer
//
//  Created by grx on 2018/12/6.
//  Copyright © 2018年 grx. All rights reserved.
//

#ifndef Config_h
#define Config_h

#define BYBASEURL  @"http://h5api.pk2game.com/api/activate.php" 
#define BYImageUploadURL @""

//MD5加密Key
#define MD5_key @"192006250b4c09247ec02edce69f6a2d"
#define DESKEY @"Pn4DKuR4"


/*! 颜色 */
#define ColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define ColorWithRGB(r,g,b) ColorWithRGBA(r,g,b,1)
#define ColorWithHexRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]
#define ColorWithHexRGB(rgbValue) ColorWithHexRGBA(rgbValue,1.0)
#define UIColorWhite [UIColor whiteColor]
#define UIColorClear [UIColor clearColor]
#define UIColorBlueMain ColorWithRGBA(73,195,241,1)
/*! 按钮文字蓝色 */
#define UIBtnTextBlueTheme ColorWithHexRGB(0x31AEEC)

#endif /* Config_h */
