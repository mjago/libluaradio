# libluaradio

Crystal Bindings For [LuaRadio](https://luaradio.io)

## Why

I have written an [Audio Player called Sonicri](https://github.com/mjago/sonicri) in the Crystal language which plays audio files, internet radio, and podcasts. I wanted to add
terrestrial FM and AM radio stations and discovered LuaRadio. These bindings enable me to embed suitable radio players into [Sonicri](https://github.com/mjago/sonicri).

## Dependencies

1) LuaRadio ([Installation instructions](http://luaradio.io/docs/installation.html))
2) fftw3f
3) volk or liquid

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  libluaradio:
    github: mjago/libluaradio
```

## Usage

```crystal
require "libluaradio"
```
See the examples for usage. The flow-graph is a Lua script. See [LuaRadio project docs](http://luaradio.io/) for more details.

## Examples:
(Note: The examples decode a recorded IQ data file.
 Generally you would decode an SDR device plugged into a USB port,
 such as a cheap RTLSDR usb stick - see Ebay.)

First download an IQ recording data file called fm-capture.dat to the examples directory:
```sh
> wget -O examples/fm-capture.dat http://martynjago.co.uk/blog/audio/fm-capture.dat
```

Then run the examples
```sh
> crystal examples/wbfm1.cr
> crystal examples/wbfm2.cr
> crystal examples/wbfm_stereo.cr
```
Excellent documentation for the LuaRadio project [can be viewed here](http://luaradio.io/)

## Debug:
To see debug info during play use the following:
```sh
> LUARADIO_DEBUG=1 crystal examples/wbfm_stereo.cr
```
## Contributing

1. Fork it ( https://github.com/mjago/libluaradio/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [mjago](https://github.com/mjago) mjago - creator, maintainer
