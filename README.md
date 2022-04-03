# Invader Detector

Library for parsing ASCII texts in the form of a Ruby gem.

### Use case

Radar screens can be analyzed for detecting predefined patterns with adjustable tolerance by considering a certain volume of noise on the screen.

## Getting Started

Include in your Gemfile
```
gem 'invader_detector', git: 'https://github.com/tamaskamaras/invader_detector.git'
```

and run `bundle install`

## Usage

First, initialize the necessary objects:

* the sought patterns from a text file as invaders,
* the radar screen,
* and a monitor object that will do the job:

```
invader1 = Radar::Invader.new('path/to/text_file/of/invador1')
invader2 = Radar::Invader.new('path/to/text_file/of/invador2')

screen = Radar::Screen.new('path/to/text_file/of/radar_screen')

monitor = Monitor.new(screen, tolerance: 20)

```
Where tolerance defines the volume of noise to be tolerated. (default: 0)

Then invoke detection by passing the invader object:
```
monitor.detect(invader1)
=> [
     {:size=>88, :coordinates=>{:x=>74, :y=>1}},
     {:size=>88, :coordinates=>{:x=>85, :y=>12}},
     {:size=>88, :coordinates=>{:x=>60, :y=>13}}
   ]

```
It returns the size and the exact location of the invader(s) in an Array.

The `detect` method receives both an `Invader` object and an Array of `Invader` objects:
```
monitor.detect([invader1, invader2])
=> [
     {:size=>88, :coordinates=>{:x=>74, :y=>1}},
     {:size=>88, :coordinates=>{:x=>85, :y=>12}},
     {:size=>88, :coordinates=>{:x=>60, :y=>13}},
     {:size=>64, :coordinates=>{:x=>42, :y=>0}},
     {:size=>64, :coordinates=>{:x=>35, :y=>15}},
     {:size=>64, :coordinates=>{:x=>16, :y=>28}},
     {:size=>64, :coordinates=>{:x=>82, :y=>41}}
   ]

```

## Contribution

**Invader Detector** was created and maintained by [tamaskamaras](https://github.com/tamaskamaras)

Contributions are welcomed in the form of

* forking the project
* creating a feature branch

## License

Invader Detector was released under the [MIT License](https://opensource.org/licenses/MIT).

