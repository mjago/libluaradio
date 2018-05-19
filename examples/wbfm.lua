local radio = require('radio')

return radio.CompositeBlock():connect(
   radio.IQFileSource("#SOURCE_NAME#", "#FORMAT#", #FREQUENCY#, #REPEAT#),
   radio.TunerBlock(#TUNE_OFFSET#, #BANDWIDTH#, 5),
   radio.WBFMMonoDemodulator(),
   radio.DownsamplerBlock(#DOWNSAMPLING_FACTOR#),
   radio.PulseAudioSink(#OUT_CHANNELS#))
