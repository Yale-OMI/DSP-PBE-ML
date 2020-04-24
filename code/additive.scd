


(
var midi = Prand([60, 67, 69, 71, 72], inf).asStream;
var dur = Pseq([1,1,1,1,1,1], 1).asStream;
var t = TempoClock.new(30);

SynthDef(\additive, { |out, freq = 440, sustain = 0.1, amp = 0.5|
    var sig;
    sig = Mix(SinOsc.ar(freq*[0.5,1,1.19,1.56,2,2.51,2.66,3.01,4.1],0,0.1));
	sig = sig * EnvGen.kr(Env.adsr(0.01, 0.03, sustain, 0.1), doneAction: Done.freeSelf);
    Out.ar(out, sig ! 2)
}).add;

r = Task({
    var delta;
    while {
        delta = dur.next;
        delta.notNil
    } {
        Synth(\additive, [freq: midi.next.midicps]);
        delta.yield;
    }
}).play(quant: t.beats);
)

Synth(\additive);

{SinOsc.ar()}.play