import { alpha, Box, Button, Card, CardActionArea, CardActions, CardContent, CardMedia, FormControl, Grid, InputBase, InputLabel, makeStyles, MenuItem, Select, TextField, Typography } from '@material-ui/core'
import React from 'react'
import SearchIcon from '@material-ui/icons/Search';
import { ArrowDropDown, ArrowDropUp } from '@material-ui/icons';


const useStyles = makeStyles((theme) => ({
    formControl: {
        margin: theme.spacing(1),
        minWidth: 150,
        maxWidth: 300,
    },
    root: {
        flexGrow: 1,
    },
    selectEmpty: {
        marginTop: theme.spacing(2),
    },
    body: {
        // padding: theme.spacing(4),
        // backgroundColor: "#2F313D",
        height: "100vh"
    },
    search: {
        position: 'relative',
        borderRadius: theme.shape.borderRadius,
        backgroundColor: alpha(theme.palette.common.white, 0.15),
        '&:hover': {
            backgroundColor: alpha(theme.palette.common.white, 0.25),
        },
        marginLeft: 0,
        width: '100%',
        [theme.breakpoints.up('sm')]: {
            marginLeft: theme.spacing(1),
            width: 'auto',
        },
    },
    searchIcon: {
        padding: theme.spacing(0, 2),
        height: '100%',
        position: 'absolute',
        pointerEvents: 'none',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
    },
    inputRoot: {
        color: 'inherit',
    },

    inputInput: {
        padding: theme.spacing(1, 1, 1, 0),
        // vertical padding + font size from searchIcon
        paddingLeft: `calc(1em + ${theme.spacing(4)}px)`,
        transition: theme.transitions.create('width'),
        width: '100%',
        [theme.breakpoints.up('sm')]: {
            width: '12ch',
            '&:focus': {
                width: '20ch',
            },
        },
    },
}));

function Ideas() {
    const classes = useStyles();
    const [age, setAge] = React.useState('');
    const [open, setOpen] = React.useState(false);
    const [count, setCount] = React.useState(1);
    const [state, setState] = React.useState({
        age: '',
        name: 'hai',
    });

    const handleClose = () => {
        setOpen(false);
    };

    const handleOpen = () => {
        setOpen(true);
    };

    const handleChange = (event) => {
        setAge(event.target.value);
    };
    return (
        <Grid container alignItems='center' justifyContent='center' style={{ height: '100vh' }}>

            <Grid
                container
                justifyContent="space-around"
                alignItems="center"
            >
                <Grid item xs={12} sm={8} md={7} lg={6} spacing={3} >
                    <Grid container spacing={4}>
                        <Grid item xs={12} alignItems='flex-end'  >
                            <Grid container alignItems='center'>
                                <Grid item xs={12} md={7} lg={8}  >
                                    <Box display="flex"
                                        justifyContent="flex-start"
                                    >
                                        <Box display="flex" alignItems="center">
                                            <Box mr={0.5}>
                                                <FormControl className={classes.formControl}>
                                                    <Select
                                                        labelId="demo-controlled-open-select-label"
                                                        id="demo-controlled-open-select"
                                                        open={open}
                                                        onClose={handleClose}
                                                        onOpen={handleOpen}
                                                        value={age}
                                                        onChange={handleChange}
                                                    >
                                                        <MenuItem value="">
                                                            <em>None</em>
                                                        </MenuItem>
                                                        <MenuItem value={10}>Ten</MenuItem>
                                                        <MenuItem value={20}>Twenty</MenuItem>
                                                        <MenuItem value={30}>Thirty</MenuItem>
                                                    </Select>
                                                </FormControl>
                                            </Box>
                                            <InputLabel id="demo-controlled-open-select-label">Sort By : Popularity</InputLabel>

                                        </Box>
                                    </Box>

                                </Grid>
                                <Grid item xs={12} md={4} lg={4} >
                                    <Box display="flex" justifyContent="center">
                                        <Box display="flex" alignItems="center">
                                            <Box mr={0.01} pl={4}>
                                                <div className={classes.search}>
                                                    <div className={classes.searchIcon}>
                                                        <SearchIcon />
                                                    </div>
                                                    <InputBase
                                                        placeholder="Search…"
                                                        classes={{
                                                            root: classes.inputRoot,
                                                            input: classes.inputInput,
                                                        }}
                                                        inputProps={{ 'aria-label': 'search' }}
                                                    />
                                                </div>
                                                <div className={classes.grow} />
                                            </Box>

                                        </Box>
                                        <Button variant="outlined" 
                                            style={{
                                                borderRadius: 5,
                                                color: "#00D05A",
                                                padding: "10px 36px",
                                                fontSize: "14px"
                                            }}
                                        >
                                            Search
                                        </Button>
                                    </Box>

                                </Grid>
                            </Grid>
                        </Grid>
                        <Grid item xs={12} >
                            <Grid container direction='column' alignContent='space-between' alignItems='center' spacing={3} >
                                <Grid item xs={12}>
                                    <Card className={classes.root}>
                                        <CardActionArea>
                                            <CardMedia
                                                className={classes.media}
                                                image="/static/images/cards/contemplative-reptile.jpg"
                                                title="Contemplative Reptile"
                                            />
                                            <CardContent>
                                                <Typography variant='subtitle1'>User03729173</Typography>
                                                <Typography gutterBottom variant="h5" component="h2">
                                                    Lorem Ipsum Dolor1
                                                </Typography>
                                                <Typography variant="body2" color="textSecondary" component="p">
                                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut enim ligula platea euismod.
                                                    Rutrum ut erat aenean faucibus orci posuere sed lectus. Massa urna nulla ornare vulputate ut dignissim.
                                                    Ornare sapien sit at porttitor adipiscing imperdiet sed integer semper.
                                                </Typography>
                                            </CardContent>
                                        </CardActionArea>
                                        <CardActions>
                                            <Grid container justifyContent='space-between'>

                                                <Typography variant='subtitle1'>Posted 5 days ago</Typography>

                                                <Grid item >
                                                    <Box display="flex" alignItems="center">

                                                        <Button
                                                            aria-label="reduce"
                                                            onClick={() => {
                                                                setCount(Math.max(count - 1, 0));
                                                            }}
                                                        >
                                                            <ArrowDropDown />
                                                        </Button>

                                                        <Typography>{count}</Typography>

                                                        <Button
                                                            style={{
                                                                borderRadius: 5,
                                                                color: "#00D05A",
                                                            }}
                                                            aria-label="increase"
                                                            onClick={() => {
                                                                setCount(count + 1);
                                                            }}
                                                        >
                                                            <ArrowDropUp />

                                                        </Button>
                                                    </Box>
                                                </Grid>
                                            </Grid>
                                        </CardActions>
                                    </Card>
                                    {/* <Typography>Card</Typography> */}
                                </Grid>
                                <Grid item xs={12}>
                                    <Card className={classes.root}>
                                        <CardActionArea>
                                            <CardMedia
                                                className={classes.media}
                                                image="/static/images/cards/contemplative-reptile.jpg"
                                                title="Contemplative Reptile"
                                            />
                                            <CardContent>
                                                <Typography variant='subtitle1'>User03729173</Typography>
                                                <Typography gutterBottom variant="h5" component="h2">
                                                    Lorem Ipsum Dolor1
                                                </Typography>
                                                <Typography variant="body2" color="textSecondary" component="p">
                                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut enim ligula platea euismod.
                                                    Rutrum ut erat aenean faucibus orci posuere sed lectus. Massa urna nulla ornare vulputate ut dignissim.
                                                    Ornare sapien sit at porttitor adipiscing imperdiet sed integer semper.
                                                </Typography>
                                            </CardContent>
                                        </CardActionArea>
                                        <CardActions>
                                            <Grid container justifyContent='space-between'>

                                                <Typography variant='subtitle1'>Posted 5 days ago</Typography>

                                                <Grid item >
                                                    <Box display="flex" alignItems="center">

                                                        <Button
                                                            aria-label="reduce"
                                                            onClick={() => {
                                                                setCount(Math.max(count - 1, 0));
                                                            }}
                                                        >
                                                            <ArrowDropDown />
                                                        </Button>

                                                        <Typography>{count}</Typography>

                                                        <Button
                                                            aria-label="increase"
                                                            onClick={() => {
                                                                setCount(count + 1);
                                                            }}
                                                            style={{
                                                                borderRadius: 5,
                                                                color: "#00D05A",
                                                            }}
                                                        >
                                                            <ArrowDropUp />

                                                        </Button>
                                                    </Box>
                                                </Grid>
                                            </Grid>
                                        </CardActions>
                                    </Card>
                                    {/* <Typography>Card</Typography> */}
                                </Grid>
                            </Grid> </Grid>
                    </Grid>
                </Grid>
                <Grid item xs={12} sm={6} lg={3} md={4} >
                    <Grid container direction='column' justifyContent='center' spacing={1}>
                        <Grid item xs={12} >

                            <Typography variant='h6'>Suggest an idea</Typography>
                        </Grid>
                        <Grid item xs={12} >

                            <Typography variant="body2">Write a paragraph of the idea you want to see impemented</Typography>
                        </Grid>

                        <Grid item xs={12} >

                            <TextField
                                id="standard-textarea"
                                // label="Multiline Placeholder"
                                placeholder="Write the title here..."
                                multiline
                                fullWidth
                                style={{ borderStyle: "dashed", borderColor: "black" }}
                            />
                        </Grid>

                        <Grid item xs={12}>

                            <TextField
                                id="standard-textarea"
                                // label="Multiline Placeholder"
                                placeholder="Write your suggestions here..."
                                multiline
                                fullWidth
                                rows={10}
                            />
                        </Grid>
                        <Grid item xs={12} >

                            <Button fullWidth  variant="contained"
                                style={{
                                    borderRadius: 5,
                                    color:"#fff",
                                    backgroundColor: "#00D05A",
                                    padding: "18px 36px",
                                    fontSize: "18px"
                                }}
                            >Post</Button>
                        </Grid>
                        {/* <Typography>side</Typography> */}
                    </Grid>
                </Grid>

            </Grid>
        </Grid>
    )
}

export default Ideas