require "../src/*"
include ModLuaRadio

quit = false
luaradio = LuaRadio.new("examples/wbfm_stereo.lua", format = "file")
spawn do
  luaradio.start
end

count = 1
loop do
  puts "running (#{count})..."
  break if count >= 10
  sleep 1.0
  count += 1
end

puts "stopping..."
luaradio.stop
puts "freeing"
luaradio.free
