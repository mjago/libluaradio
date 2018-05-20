local radio = require('radio')

-- Blocks
local source = radio.IQFileSource("examples/fm-capture.dat", "u8", 2500000, false)
local tuner = radio.TunerBlock(-600000, 500000, 5)
local fm_demod = radio.FrequencyDiscriminatorBlock(1.25)
local hilbert = radio.HilbertTransformBlock(31)
local delay = radio.DelayBlock(31)
local pilot_filter = radio.ComplexBandpassFilterBlock(31, {18e3, 20e3})
local pilot_pll = radio.PLLBlock(100, 200000-50, 200e3+50, 2)
local mixer = radio.MultiplyConjugateBlock()
-- L+R
local lpr_filter = radio.LowpassFilterBlock(128, 15e3)
local lpr_am_demod = radio.ComplexToRealBlock()
-- L-R
local lmr_filter = radio.LowpassFilterBlock(128, 15e3)
local lmr_am_demod = radio.ComplexToRealBlock()
-- L
local l_summer = radio.AddBlock()
local l_af_deemphasis = radio.FMDeemphasisFilterBlock(75e-6)
local l_downsampler = radio.DownsamplerBlock(5)
-- R
local r_subtractor = radio.SubtractBlock()
local r_af_deemphasis = radio.FMDeemphasisFilterBlock(75e-6)
local r_downsampler = radio.DownsamplerBlock(5)
-- Sink
local sink = radio.PulseAudioSink(2)

-- Connections
local top = radio.CompositeBlock()
top:connect(source, tuner, fm_demod, hilbert, delay)
top:connect(hilbert, pilot_filter, pilot_pll)
top:connect(delay, 'out', mixer, 'in1')
top:connect(pilot_pll, 'out', mixer, 'in2')
top:connect(delay, lpr_filter, lpr_am_demod)
top:connect(mixer, lmr_filter, lmr_am_demod)
top:connect(lpr_am_demod, 'out', l_summer, 'in1')
top:connect(lmr_am_demod, 'out', l_summer, 'in2')
top:connect(lpr_am_demod, 'out', r_subtractor, 'in1')
top:connect(lmr_am_demod, 'out', r_subtractor, 'in2')
top:connect(l_summer, l_af_deemphasis, l_downsampler)
top:connect(r_subtractor, r_af_deemphasis, r_downsampler)
top:connect(l_downsampler, 'out', sink, 'in1')
top:connect(r_downsampler, 'out', sink, 'in2')

return top
