import React, { useState } from 'react';

import { useFonts } from 'expo-font';

import AppLoading from 'expo-app-loading';
import { StyleSheet, Text, View, Dimensions, TouchableHighlight } from 'react-native';
import CountDown from 'react-native-countdown-component';

const customFonts = {
    poppinsRegular: require('../assets/fonts/Poppins-Regular.ttf'),
    poppinsMedium: require('../assets/fonts/Poppins-Medium.ttf'),
    poppinsLight: require('../assets/fonts/Poppins-Light.ttf'),
    poppinsThin: require('../assets/fonts/Poppins-Thin.ttf'),
}
const CountdownComponent = (props) => {
    const [isLoaded] = useFonts(customFonts);

    if (!isLoaded) {
        return <AppLoading />;
    } else {
        return (
            <CountDown
                until={96435}
                size={30}
                onFinish={() => alert('Finished')}
                style={styles.countdown}
                digitStyle={styles.digit}
                digitTxtStyle={styles.digitText}
                timeLabelStyle={styles.timeLabel}
                separatorStyle={styles.separator}
                timeToShow={['D', 'H', 'M', 'S']}
                timeLabels={{ d: 'Days', h: 'Hours', m: 'Minutes', s: 'Seconds' }}
                showSeparator
            />
        )
    }
}

const styles = StyleSheet.create({
    countdown: {
        justifyContent: 'center',
    },
    separator: {
        color: '#2F313D',
        paddingBottom: 30,
        fontWeight: 'normal',
        fontFamily: 'poppinsRegular'
    },
    timeLabel: {
        color: '#2F313D80', 
        fontSize: 14,
        paddingHorizontal: 10,
        fontWeight: 'normal',
        fontFamily: 'poppinsMedium',
        letterSpacing: 0.8,
    },
    digit: {
        backgroundColor: '#FFF',
    },
    digitText: {
        color: '#2F313D',
        fontSize: 45,
        fontWeight: '400',
        fontFamily: 'poppinsLight'
    }
});

export default CountdownComponent;