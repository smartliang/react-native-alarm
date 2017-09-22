
# react-native-alarm

## Getting started

`$ npm install react-native-alarm --save`

### Mostly automatic installation

`$ react-native link react-native-alarm`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-alarm` and add `RNAlarm.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNAlarm.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.liang.RNAlarmPackage;` to the imports at the top of the file
  - Add `new RNAlarmPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-alarm'
  	project(':react-native-alarm').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-alarm/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-alarm')
  	```


## Usage
```javascript
import RNAlarm from 'react-native-alarm';

// TODO: What to do with the module?
RNAlarm;
```
  