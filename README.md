# libluaradio

Crystal Binding For [LuaRadio](https://luaradio.io)

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
 such as an RTLSDR receiver.)

Download a data file called fm-capture.dat to the examples directory:
```sh
 wget -O examples/fm-capture.dat http://martynjago.co.uk/blog/audio/fm-capture.dat
```

Run the following commands:
```crystal
crystal examples/wbfm1.cr
crystal examples/wbfm2.cr
```
Excellent documentation for the LuaRadio project [can be viewed here](http://luaradio.io/)

## Contributing

1. Fork it ( https://github.com/mjago/libluaradio/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [mjago](https://github.com/mjago) mjago - creator, maintainer
