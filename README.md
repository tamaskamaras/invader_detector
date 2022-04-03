# Invader Detecor

Library for parsing ASCII texts in the form of a Ruby gem.

### Use case

Radar screens can be analyzed for detecting predefined patterns with adjustable tolerance by considering certain volume on noise on the screen.

## Getting Started

Include in your Gemfile
```
gem 'invader_detector', git: 'https://github.com/tamaskamaras/invader_detector.git'
```

and run `bundle install`

## Usage

First initialize the necessary objects:
- the sought patterns from a text file as invaders,
- the radar screen
- and a monitor object that will do the job

```
invader1 = Radar::Invader.new('path/to/text_file/of/invador1')
invader2 = Radar::Invader.new('path/to/text_file/of/invador2')

screen = Radar::Screen.new('path/to/text_file/of/radar_screen')

monitor = Monitor.new(screen, tolerance: 10)

```


## Contribution

**Invader Detecor** was created and maintained by [tamaskamaras](https://github.com/tamaskamaras)

Contributions are welcomed in the form of

* forking the project
* creating a feature branch

## License

Invader Detecor was released under the [MIT License](https://opensource.org/licenses/MIT).

