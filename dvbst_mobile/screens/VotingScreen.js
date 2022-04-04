import React from 'react'

import { StyleSheet, Text, View, TextInput, Dimensions, TouchableOpacity, ScrollView, SafeAreaView } from 'react-native';
import VoteComponent from '../components/voteComponent';

const VotingScreen = (props) => {
    return (
        <SafeAreaView style={styles.container}>
            <ScrollView>
                <VoteComponent />
                <VoteComponent />
                <VoteComponent />
                <VoteComponent />
                <VoteComponent />
                <VoteComponent />
                <VoteComponent />
                <VoteComponent />
                <VoteComponent />
                <VoteComponent />
                <VoteComponent />
                <VoteComponent />
                <VoteComponent />
                <VoteComponent />
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

export default VotingScreen;