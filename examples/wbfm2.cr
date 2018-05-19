require "../src/*"
include ModLuaRadio

data = {
  "#SOURCE_NAME#"  => "examples/fm-capture.dat",
  "#FORMAT#"      => "u8",
  "#FREQUENCY#"   => 2500000,
  "#BANDWIDTH#"   => 500000,
  "#OUT_CHANNELS#" => 1,
  "#DOWNSAMPLING_FACTOR#" => 5,
  "#REPEAT#"      => false
}

tune_offset = [-1000000, -600000, -200000]
luaradio = LuaRadio.new("examples/wbfm.lua", format = "file")

tune_offset.each do |offset|
  data["#TUNE_OFFSET#"] = offset
  luaradio.configure(data)
  luaradio.load
  luaradio.start
  luaradio.wait
end
luaradio.free
