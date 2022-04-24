import React from 'react'

import { StyleSheet, Text, View, SafeAreaView, TextInput, Dimensions, TouchableOpacity, ScrollView } from 'react-native';
import CandidateBio from '../components/candidateBio';
import CandidateDetail from '../components/candidateDetail';

const CandidatesScreen = (props) => {
    return (
        <SafeAreaView style={styles.container}>
            <ScrollView>
                <CandidateBio image={require('../assets/portrait3.jpg')} />
                <CandidateDetail />
            </ScrollView>
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        paddingHorizontal: 10,
        paddingTop: 40,
        backgroundColor: '#fff',
        flex: 1
    }
});
export default CandidatesScreen;