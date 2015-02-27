# Palette

__this is a work in progress, currently under development__

Service to extract color information about an image.

Try it out at [http://palette-shothere.rhcloud.com/](http://palette-shothere.rhcloud.com/)

## API

### Get main colors

Give the url of your image to the service


```
  POST /colors
  {
    "url": "http://ia.media-imdb.com/images/M/MV5BNDkwNTEyMzkzNl5BMl5BanBnXkFtZTgwNTAwNzk3MjE@.jpg"
  }
```

It will answer with a list of the main colors used in the given image

```
  {
    "Brown": {
        "frequency": 39,
        "html": "#25161C"
    },
    "Red": {
        "frequency": 26,
        "html": "#220E1A"
    },
    "Violet": {
        "frequency": 21,
        "html": "#0E060D"
    },
    "Grey": {
        "frequency": 8,
        "html": "#473B44"
    },
    "Orange": {
        "frequency": 3,
        "html": "#885F3A"
    },
    "Yellow": {
        "frequency": 1,
        "html": "#AF8A53"
    },
    "Green": {
        "frequency": 1,
        "html": "#7F8078"
    },
    "Blue": {
        "frequency": 0,
        "html": "#150829"
    }
  }
```
