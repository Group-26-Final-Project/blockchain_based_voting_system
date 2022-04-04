import React from 'react'

import { StyleSheet, Text, View, TextInput, Dimensions, TouchableOpacity, SafeAreaView } from 'react-native';
import ResultComponent from '../components/resultComponent';
import ResultFilter from '../components/resultFilter';
import ResultRankings from '../components/resultRankings';

const ResultScreen = (props) => {
    return (
        <SafeAreaView style={styles.container}>
            <ResultComponent rank={1} add='st' vote={80} image={require('../assets/portrait3.jpg')}/>
            <View style={styles.secthi}>
                <ResultComponent rank={2} add='nd' vote={69} image={require('../assets/portrait2.jpg')}/>
                <ResultComponent rank={3} add='rd' vote={41} image={require('../assets/portrait.jpg')}/>
            </View>
            <ResultFilter />
            <ResultRankings/>
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        paddingHorizontal: 10,
        paddingTop: 40,
        backgroundColor: '#fff',
        flex: 1,
        alignSelf: 'auto'
    },
    secthi: {
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-evenly'
    },
});

export default ResultScreen;