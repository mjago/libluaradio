require "./libluaradio/*"

module ModLuaRadio
  @[Link("luajit-5.1")]
  @[Link("luaradio")]
  lib LibLuaRadio
    alias LrHandle = Void*
    alias State = Void*
    alias ErrorStr = UInt8*
    alias Script = UInt8*
    fun new = luaradio_new : LrHandle
    fun load = luaradio_load(LrHandle, Script) : Int32
    fun start = luaradio_start(LrHandle) : Int32
    fun status = luaradio_status(LrHandle, Int32*) : Int32
    fun wait = luaradio_wait(LrHandle) : Int32
    fun stop = luaradio_stop(LrHandle) : Int32
    fun free = luaradio_free(LrHandle) : Int32
    fun state = luaradio_get_state(LrHandle) : State
    fun error_string = luaradio_strerror(LrHandle) : ErrorStr
  end

  class LuaRadio
    @handle : LibLuaRadio::LrHandle
    @script : String

    def initialize(scr, format = "script")
      @handle = LibLuaRadio.new
      @config = ""
      @script = parse(scr, format)
      @loaded = false
    end

    def load(config = @config)
      config = @config == "" ? @script : @config
      ret = LibLuaRadio.load(@handle, config.bytes)
      raise lr_error unless ret == 0
    end

    def start
      load @config unless @loaded
      ret = LibLuaRadio.start(@handle)
      raise lr_error unless ret == 0
    end

    def status
      status = 0
      status_ptr = pointerof(status)
      ret = LibLuaRadio.status(@handle, status_ptr)
      raise lr_error unless ret == 0
      status_ptr.value
    end

    def wait
      ret = LibLuaRadio.wait(@handle)
      raise lr_error unless ret == 0
    end

    def stop
      ret = LibLuaRadio.stop(@handle)
      raise lr_error unless ret == 0
    end

    def free
      ret = LibLuaRadio.free(@handle)
      raise lr_error unless ret == 0
    end

    def state
      state = LibLuaRadio.state(@handle)
      raise lr_error unless ret == 0
    end

    def configure(data)
      cfg = @script
      data.each { |k, v| cfg = cfg.gsub(k, v) }
      @config = cfg
    end

    private def parse(lua, format)
      return lua if format == "script"
      File.read(lua)
    end

    private def lr_error
      String.new(LibLuaRadio.error_string(@handle))
    end
  end
end
