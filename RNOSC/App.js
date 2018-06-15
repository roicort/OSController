'use strict';
import React, { Component } from 'react'; // 1
import {
  Platform,
  StyleSheet,
  Text,
  View,
  TextInput,
  Button,
  Slider,
  ActivityIndicator,
  Image,
  TouchableOpacity
} from 'react-native';

import { AppRegistry } from 'react-native';
import App from './App';

AppRegistry.registerComponent('OSController', () => App);

import { createBottomTabNavigator } from 'react-navigation';

import { Accelerometer } from 'expo';





class HomeScreen extends React.Component {
  render() {
    return (
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
        <Text>ENES Morelia OSController</Text>
      </View>
    );
  }
}

class SliderScreen extends React.Component {
  constructor(props) {
  super(props)
  this.state = { 
    Val1: 10,
    Val2: 20,
    Val3: 30,
    Val4: 40,
    Val5: 50,
    Val6: 60,
    Val7: 70,
    Val8: 80,
  }
  } 
  getVal(val){
  console.warn(val);
  } 

  render() {
    let { Val1, Val2, Val3, Val4, Val5, Val6, Val7, Val8 } = this.state;

    return (

      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
        <Text>Slider!</Text>
        <Text>S1: {Val1} S2: {Val2} S3: {Val3} S4: {Val4} S5: {Val5} S6: {Val6} S7: {Val7} S8: {Val8}</Text>
        <Slider
         style={{ width: 250 }}
         step={1}
         minimumValue={0}
         maximumValue={100}
         value={this.state.Val1}
         onValueChange={val => this.setState({ Val1: val })}
         //onSlidingComplete={ val => this.getVal(val)}
        />
        <Slider
         style={{ width: 250 }}
         step={1}
         minimumValue={0}
         maximumValue={100}
         value={this.state.Val2}
         onValueChange={val => this.setState({ Val2: val })}
         //onSlidingComplete={ val => this.getVal(val)}
        />
        <Slider
         style={{ width: 250 }}
         step={1}
         minimumValue={0}
         maximumValue={100}
         value={this.state.Val3}
         onValueChange={val => this.setState({ Val3: val })}
         //onSlidingComplete={ val => this.getVal(val)}
        />
        <Slider
         style={{ width: 250 }}
         step={1}
         minimumValue={0}
         maximumValue={100}
         value={this.state.Val4}
         onValueChange={val => this.setState({ Val4: val })}
         //onSlidingComplete={ val => this.getVal(val)}
        />
        <Slider
         style={{ width: 250 }}
         step={1}
         minimumValue={0}
         maximumValue={100}
         value={this.state.Val5}
         onValueChange={val => this.setState({ Val5: val })}
         //onSlidingComplete={ val => this.getVal(val)}
        />
        <Slider
         style={{ width: 250 }}
         step={1}
         minimumValue={0}
         maximumValue={100}
         value={this.state.Val6}
         onValueChange={val => this.setState({ Val6: val })}
         //onSlidingComplete={ val => this.getVal(val)}
        />
        <Slider
         style={{ width: 250 }}
         step={1}
         minimumValue={0}
         maximumValue={100}
         value={this.state.Val7}
         onValueChange={val => this.setState({ Val7: val })}
         //onSlidingComplete={ val => this.getVal(val)}
        />
        <Slider
         style={{ width: 250 }}
         step={1}
         minimumValue={0}
         maximumValue={100}
         value={this.state.Val8}
         onValueChange={val => this.setState({ Val8: val })}
         //onSlidingComplete={ val => this.getVal(val)}
        />                                                        
      </View>
    );
  }
}

class GyroScreen extends React.Component {
  state = {
    accelerometerData: {},
  }

  componentDidMount() {
    this._toggle();
  }

  componentWillUnmount() {
    this._unsubscribe();
  }

  _toggle = () => {
    if (this._subscription) {
      this._unsubscribe();
    } else {
      this._subscribe();
    }
  }

  _slow = () => {
    Accelerometer.setUpdateInterval(1000); 
  }

  _subscribe = () => {
    this._subscription = Accelerometer.addListener(accelerometerData => {
      this.setState({ accelerometerData });
    });
  }

  _unsubscribe = () => {
    this._subscription && this._subscription.remove();
    this._subscription = null;
  }

  render() {
    let { x, y, z } = this.state.accelerometerData;

    return (
      <View style={styles.sensor}>
        <Text>Gyro: </Text>
        <Text>x: {round(x)} y: {round(y)} z: {round(z)}</Text>

        <View style={styles.buttonContainer}>
          <TouchableOpacity onPress={this._toggle} style={styles.button}>
            <Text>Toggle</Text>
          </TouchableOpacity>
        </View>
      </View>
    );
  }
}

function round(n) {
  if (!n) {
    return 0;
  }

  return Math.floor(n * 100) / 100;
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  },
  buttonContainer: {
    flexDirection: 'row',
    alignItems: 'stretch',
    marginTop: 15,
  },
  button: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#eee',
    padding: 10,
  },
  middleButton: {
    borderLeftWidth: 1,
    borderRightWidth: 1,
    borderColor: '#ccc',
  },
  sensor: {
    marginTop: 250,
    alignItems: 'center',
    paddingHorizontal: 10,
  },
});

class TouchScreen extends React.Component {
  render() {
    return (
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
        <Text>Touch!</Text>
      </View>
    );
  }
}

function configure(val) {
  console.warn(val);
}

class SettingsScreen extends React.Component {
  render() {
    return (
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
        <TextInput
          placeholder='Enter IP'/>
        <TextInput
          placeholder='Enter Port'/>          
        <Button
          onPress={() => {}}
          color='#48BBEC'
          title='Go'
        />
      </View>
    );
  }
}



export default createBottomTabNavigator({
  Home: HomeScreen,
  Sliders: SliderScreen,
  Gyro: GyroScreen,
  Touch: TouchScreen,
  Settings: SettingsScreen,
});