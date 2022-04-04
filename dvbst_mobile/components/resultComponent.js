import React, { useState } from 'react';

import { useFonts } from 'expo-font';

import AppLoading from 'expo-app-loading';
import { StyleSheet, Text, View, Dimensions, TouchableHighlight, Image } from 'react-native';
import Icon from 'react-native-vector-icons/AntDesign';
import { borderColor } from 'react-native/Libraries/Components/View/ReactNativeStyleAttributes';

const customFonts = {
    poppinsRegular: require('../assets/fonts/Poppins-Regular.ttf'),
    poppinsBold: require('../assets/fonts/Poppins-Bold.ttf'),
    poppinsSemi: require('../assets/fonts/Poppins-SemiBold.ttf'),
}
const ResultComponent = (props) => {
    const [isLoaded] = useFonts(customFonts);
    const img = props.image;

    if (!isLoaded) {
        return <AppLoading />;
    } else {
        return (
            <View style={styles.container}>
                <View style={styles.rank}>
                    <Text style={styles.rank_one}>{props.rank}<Text style={styles.rank_two}>{props.add}</Text></Text>
                </View>
                <View style={[styles.imgContainerFirst, props.rank != 1 && styles.imgContainer]}>
                    <Image style={[styles.imageFirst, props.rank != 1 && styles.image]} source={img} />
                </View>
                <View style={styles.votes}>
                    <Text style={styles.votes_one}>{props.vote}<Text style={styles.votes_two}>Votes</Text></Text>
                </View>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        alignItems: 'center',
    },
    rank_one: {
        fontFamily: 'poppinsBold',
        fontSize: 36,
        color: '#2F313D'
    },
    rank_two: {
        fontFamily: 'poppinsBold',
        fontSize: 18,
        color: '#2F313D'
    },
    imgContainerFirst: {
        height: Dimensions.get('window').height * 0.14,
        width: Dimensions.get('window').height * 0.14,
        borderRadius: Dimensions.get('window').height * 0.14 / 2,
        marginRight: 15,
        elevation: 10
    },
    imgContainer: {
        height: Dimensions.get('window').height * 0.125,
        width: Dimensions.get('window').height * 0.125,
        borderRadius: Dimensions.get('window').height * 0.125 / 2,
        marginRight: 15,
        elevation: 10
    },
    imageFirst: {
        flex: 1,
        borderRadius: Dimensions.get('window').height * 0.14 / 2,
        resizeMode: 'cover',
        height: undefined,
        width: undefined,
        paddingHorizontal: 10,
        overflow: "hidden",
        borderWidth: 5,
        borderColor: "#00D05A",
    },
    image: {
        flex: 1,
        borderRadius: Dimensions.get('window').height * 0.125 / 2,
        resizeMode: 'cover',
        height: undefined,
        width: undefined,
        paddingHorizontal: 10,
        overflow: "hidden",
        borderWidth: 5,
        borderColor: "white",
    },
    votes: {
        paddingTop: 3
    },
    votes_one: {
        fontFamily: 'poppinsSemi',
        fontSize: 24,
        color: '#2F313D'
    },
    votes_two: {
        fontFamily: 'poppinsSemi',
        fontSize: 14,
        color: '#2F313D'
    }
});

export default ResultComponent;