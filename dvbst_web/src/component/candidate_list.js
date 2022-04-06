import { Avatar, Box, Button, Card, Grid, Typography } from '@material-ui/core'
import { makeStyles } from '@material-ui/core';
import React, { useEffect, useRef, useState } from 'react'


const useStyles = makeStyles((theme) => ({

    root: {
        flexGrow: 1,
    },
    body: {
        padding: theme.spacing(4),
        backgroundColor: "#2F313D",
        minHeight: "25vh",
    },
    my_typogrphy: {
        color: "white",
    }

}));


function CandidateList() {
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
        <div >
            <Grid
                container
                alignItems='center'
                justifyContent='center'
                spacing={5}
                style={{ height: '100vh' }}
            >
                <Grid item xs={12} className={classes.body}>


                    <Grid container justifyContent='center'  >

                        <Grid item xs={9} >
                            <Grid container direction='column' justifyContent='center'>
                                <Typography variant='h4' className={classes.my_typogrphy}>Time Remaining </Typography>
                                <Typography variant='h4' className={classes.my_typogrphy}>{timerDays} : {timerHours} : {timerMinutes} : {timerSeconds}</Typography>
                            </Grid>

                        </Grid>

                    </Grid>
                </Grid>
                <Grid item xs={12} sm={11} md={9} style={{ height: '75vh' }}>
                    <Grid
                        container
                        alignItems='center'
                        justifyContent='center'
                        spacing={5}
                    >
                        <Grid item xs={12}>
                            <Card>
                                <Box display="flex" justifyContent="Space-between">
                                    <Box m={2} display="flex">

                                        <Avatar ></Avatar>
                                        <Box ml={3} display="flex" flexDirection="column" justifyContent="space-between">
                                            <Box display="flex">

                                                <Typography variant="h5">Andrew Jhonston</Typography>
                                                <Button>View Profile</Button>
                                            </Box>
                                            <Box>

                                                <Typography style={{ fontSize: 12 }} variant="h6">Department of Software Engineering</Typography>
                                                <Typography style={{ fontSize: 12 }} variant="h6">Section 1</Typography>
                                            </Box>
                                        </Box>
                                    </Box>
                                    <Box display="flex" flexDirection="column" m={5} justifyContent="center">
                                        <Button style={{
                                            borderRadius: 5,
                                            color: "#00D05A"
                                        }}>Vote</Button>
                                    </Box>
                                </Box>
                            </Card>
                        </Grid>

                        <Grid item xs={12}>
                            <Card>
                                <Box display="flex" justifyContent="Space-between">
                                    <Box m={2} display="flex">

                                        <Avatar ></Avatar>
                                        <Box ml={3} display="flex" flexDirection="column" justifyContent="space-between">
                                            <Box display="flex">

                                                <Typography variant="h5">Andrew Jhonston</Typography>
                                                <Button>View Profile</Button>
                                            </Box>
                                            <Box>

                                                <Typography style={{ fontSize: 12 }} variant="h6">Department of Software Engineering</Typography>
                                                <Typography style={{ fontSize: 12 }} variant="h6">Section 1</Typography>
                                            </Box>
                                        </Box>
                                    </Box>
                                    <Box display="flex" flexDirection="column" m={5} justifyContent="center">
                                        <Button style={{
                                            borderRadius: 5,
                                            color: "#00D05A"
                                        }}>Vote</Button>
                                    </Box>
                                </Box>
                            </Card>
                        </Grid>

                        <Grid item xs={12}>
                            <Card>
                                <Box display="flex" justifyContent="Space-between">
                                    <Box m={2} display="flex">

                                        <Avatar ></Avatar>
                                        <Box ml={3} display="flex" flexDirection="column" justifyContent="space-between">
                                            <Box display="flex">

                                                <Typography variant="h5">Andrew Jhonston</Typography>
                                                <Button>View Profile</Button>
                                            </Box>
                                            <Box>

                                                <Typography style={{ fontSize: 12 }} variant="h6">Department of Software Engineering</Typography>
                                                <Typography style={{ fontSize: 12 }} variant="h6">Section 1</Typography>
                                            </Box>
                                        </Box>
                                    </Box>
                                    <Box display="flex" flexDirection="column" m={5} justifyContent="center">
                                        <Button style={{
                                            borderRadius: 5,
                                            color: "#00D05A"
                                        }}>Vote</Button>
                                    </Box>
                                   
                                </Box>
                            </Card>
                        </Grid>
                    </Grid>

                </Grid>

            </Grid>
        </div>
    )
}

export default CandidateList