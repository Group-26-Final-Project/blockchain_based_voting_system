import { Grid, makeStyles, Typography } from '@material-ui/core';
import React, { useEffect, useRef, useState } from 'react'
import Voting_Svg from '../../Voting_Svg';
import Navbar from '../Navbar'


const useStyles = makeStyles((theme) => ({
    root: {
        flexGrow: 1,
    },
    body: {
        padding: theme.spacing(4),
        backgroundColor: "#2F313D",
        minHeight: "100vh"
    },
    my_typogrphy: {
        color: "white"
    }

}));


function Before_Voting() {

    const [timerDays, setTimerDays] = useState('00')
    const [timerHours, setTimerHours] = useState('00')
    const [timerMinutes, setTimerMinutes] = useState('00')
    const [timerSeconds, setTimerSeconds] = useState('00')

    let interval = useRef()

    const startTimer = () => {
        const countdownDate = new Date('Apr 24 , 2022 00:00:00').getTime()

        interval = setInterval(() => {
            const now = new Date().getTime()
            const distance = countdownDate - now

            const days = Math.floor(distance / (1000 * 60 * 60 * 24))
            const hours = Math.floor((distance % (1000 * 60 * 60 * 24) / (1000 * 60 * 60)))
            const minutes = Math.floor((distance % (1000 * 60 * 60) / (1000 * 60)))
            const seconds = Math.floor((distance % (1000 * 60) / (1000)))

            if (distance < 0) {
                clearInterval(interval.current)
            } else {
                setTimerDays(days)
                setTimerHours(hours)
                setTimerMinutes(minutes)
                setTimerSeconds(seconds)
            }

        }, 1000)
    }

    useEffect(() => {
        startTimer()
        return () => {
            clearInterval(interval.current)
        }
    })
    

    const classes = useStyles()
    return (
        <Grid container className={classes.body}>
            {/* <Navbar /> */}
            <Grid container direction='row'>
                <Grid xs={6} container justifyContent='flex-end' alignContent='flex-start'>

                    <Typography className={classes.my_typogrphy} color="white" variant='h1'  >
                        Voting <span style={{ color: "#00D05A", fontFamily: "Poppins", fontWeight: "SemiBold" }}>
                            opens</span> in <br />{timerDays} : {timerHours} : {timerMinutes} : {timerSeconds}
                    </Typography>   
                    <Typography variant='h4'> Days : Hours : Mintues : Seconds</Typography>
                </Grid>
                <Grid container xs={6} alignContent="center" justifyContent='center'>
                    <Voting_Svg />
                </Grid>
            </Grid>
        </Grid>
    )
}

export default Before_Voting