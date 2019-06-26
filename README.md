# compfest-go-eat
Second Stage Assignment of Software Engineering Academy Compfest-GoJek
This apps based on Command Line Interface (CLI) that have some features.

1. Show Maps
   Find your own self by displaying maps which contains driver, store and you !
2. Order Food
   Let me know what foods do you like and we will deliver it as fast as possible when you are starving
3. View Hisory
   Remember you bills and collect your debt to your friends :laughing:

## Instalation

This apps run in ruby. You should install ruby to make this apps works. (Please refer to this link for installing ruby using RVM) [https://rvm.io/rvm/install]

## Run Apps

This apps can be run using various method. 
- The first one, you can run this apps directly using command `ruby`
  ```bash
  ruby main.rb
  ```
 - The second one, you can run this apps using command `ruby` and 3 arguments. The argument represented as size of map, user custom position (x), user custom position (y). Example
   ```bash
   ruby main.rb 20 3 4
   ```
   Those command means that this apps running with size of map is 20 unit distances. Then, we define user costum positions at coordinate (3,4)

## Design Decision

This apps is designed by separating code based on function and object. There are some classes that built :

- Class Main
  This class are the core of the apps. This class relate another classes and become main control (main menu)

- Class Maps
  This class handle function about maps. This class related to another class such Driver, Me, and Store. Some functions that handle by this class such as generate maps, visualize maps, generate route, etc.

- Class Driver
  This class handle some attributes of driver such as symbol, ratings, positions. And this class also handle function that relate to driver, such as giving rating.

- Class Store
  This class store some attributes that related to store such as symbol, store_name, menu, and positions.

- Class Me
  This class store some attributes that related to user (me)

There are some attributes that using private mode and public mode. This style is used for prevent other classes access attributes in another class. So, it will keep private and can not modified by another classes. This makes class become independent objects.

Those designs are made to make developer easier to maintenance the apps by separating code by their object and functionality. Those design inspired by (SOLID PRINCIPLES) [https://medium.com/@dhkelmendi/solid-principles-made-easy-67b1246bcdf]