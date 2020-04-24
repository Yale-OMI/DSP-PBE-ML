(

SynthDef(\additive, { |out, freq = 440, partials, amps|
    var sig, env;
    sig = Mix(SinOsc.ar(freq*partials,0,0.1*amps));
	env = EnvGen.kr(Env.perc, doneAction: Done.freeSelf);
	Out.ar(out, (sig * env) ! 2)
}).add;

r = Pbind(
	\instrument, \additive,
	\partials, [0.5,1,1.19,1.56,2,2.51,2.66,3.01,4.1],
	\amps, [0.25,1,0.8,0.5,0.9,0.4,0.3,0.6,0.1],
	\midinote, Prand([60, 67, 69, 71, 72], inf).asStream,
	\dur, Pseq(Array.fill(12,{0.2}), 1)
).play;
)
