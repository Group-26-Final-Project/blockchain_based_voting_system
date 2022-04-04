import React from 'react'

import { StyleSheet, Text, View, SafeAreaView, TextInput, Dimensions, TouchableOpacity, ScrollView } from 'react-native';
import IdeaDetail from '../components/IdeaDetail';
import SearchBar from '../components/searchbar';
import SearchFilter from '../components/searchFilter';

const IdeasScreen = (props) => {
    return (
        <SafeAreaView style={styles.container}>
            <SearchBar />
            <SearchFilter />
            <ScrollView>
                <IdeaDetail />
                <IdeaDetail />
                <IdeaDetail />
                <IdeaDetail />
                <IdeaDetail />
                <IdeaDetail />
                <IdeaDetail />
                <IdeaDetail />
                <IdeaDetail />
                <IdeaDetail />
                <IdeaDetail />
                <IdeaDetail />
                <IdeaDetail />
                <IdeaDetail />
                <IdeaDetail />
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
export default IdeasScreen;