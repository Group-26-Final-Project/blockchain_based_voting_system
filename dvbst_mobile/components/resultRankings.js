import React, { useState } from 'react';

import { useFonts } from 'expo-font';

import AppLoading from 'expo-app-loading';
import { StyleSheet, View } from 'react-native';
import { Table, TableWrapper, Row, Rows } from 'react-native-table-component';

const customFonts = {
    poppinsRegular: require('../assets/fonts/Poppins-Regular.ttf'),
    poppinsBold: require('../assets/fonts/Poppins-Bold.ttf'),
    poppinsSemi: require('../assets/fonts/Poppins-SemiBold.ttf'),
    poppinsLight: require('../assets/fonts/Poppins-Light.ttf'),
}
const CONTENT = {
    tableHead: ['', 'Votes', 'Full Name'],
    tableData: [
        ['1', '80', 'Daniel Terefe'],
        ['2', '69', 'Kaleb Mesfin'],
        ['3', '41', 'Hanna Samuel']
    ],
};
const ResultRankings = (props) => {
    const [isLoaded] = useFonts(customFonts);

    if (!isLoaded) {
        return <AppLoading />;
    } else {
        return (
            <View style={styles.container}>
                <Table>
                    <Row
                        data={CONTENT.tableHead}
                        flexArr={[1, 2, 4]}
                        style={styles.head}
                        textStyle={styles.textHead}
                    />
                    <TableWrapper style={styles.wrapper}>
                        <Rows
                            data={CONTENT.tableData}
                            flexArr={[1, 2, 4]}
                            style={styles.row}
                            textStyle={styles.text}
                        />
                    </TableWrapper>
                </Table>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: { flex: 1, padding: 16, paddingTop: 10, backgroundColor: '#fff' },
    head: { height: 50, backgroundColor: '#D3E8E6B3' },
    wrapper: { flexDirection: 'row' },
    title: { flex: 1, alignSelf: 'flex-start', backgroundColor: '#2ecc71' },
    row: { height: 40, paddingTop: 10 },
    text: { textAlign: 'left', paddingLeft: 30, fontFamily: 'poppinsLight' },
    textHead: {
        textAlign: 'left', paddingLeft: 30, fontFamily: 'poppinsRegular', fontSize: 16
    },
});

export default ResultRankings;