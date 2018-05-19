require "../src/*"
include ModLuaRadio

flow_graph = %q(
  local radio = require('radio')
  return radio.CompositeBlock():connect(
     radio.IQFileSource("examples/fm-capture.dat",
                        "u8",
                        2500000,
                        false),
     radio.TunerBlock(-600e3,
                      500e3,
                      5),
     radio.WBFMMonoDemodulator(),
     radio.DownsamplerBlock(5),
     radio.PulseAudioSink(1))
)

luaradio = LuaRadio.new(flow_graph)
luaradio.start
luaradio.wait
luaradio.free
