declare interface "SmartKeyboard{
	'Number of Keyboards':'1',
	'Max Keyboard Polyphony':'0',
	'Keyboard 0 - Number of Keys':'1',
	'Keyboard 0 - Send Freq':'0',
	'Keyboard 0 - Piano Keyboard':'0'
}";


import("stdfaust.lib");

x = hslider("x",0.5,0,1,0.01) : si.smoo;
y = hslider("y",0.5,0,1,0.01) : si.smoo;
t60S = x*8;
trigger0 = hslider("trigger0[midi:ctrl 10]",0,0,1,1);
trigger1 = hslider("trigger1[midi:ctrl 11]",0,0,1,1);
trigger2 = hslider("trigger2[midi:ctrl 12]",0,0,1,1);

drum(j,exPos,velocity,t60Scaler,trig) = excitation <: par(i,N,mode(i,baseFreq,t60Scaler)) :> *(outGain)
with{
	// number of modes
	N = 20;
	// angle
	theta = 0;
	// frequency of the lowest drum
	bFreq = 60;
	// output gain (should be changed in function of the number of drums and modes)
	outGain = 0.1;
	// drum root freq is computed in function of pad number
	baseFreq = bFreq*(j+1);
	// computing the gain of each filter
	inGains(i) = cos((i+1)*theta)/float(i+1);
	// computing each modes, why is this done like this, cus it sounds goooood...
	mode(i,baseFreq,t60) = *(inGains(i)) : modeFilter(baseFreq+(200*i),(N-i)*t60*0.03)*(1/(i+1))
	with{
		// biquad taking freq and t60 as arguments
		modeFilter(f,t60) = fi.tf2(b0,b1,b2,a1,a2)
		with{
			b0 = 1;
			b1 = 0;
			b2 = -1;
			w = 2*ma.PI*f/ma.SR;
			r = pow(0.001,1/float(t60*ma.SR));
			a1 = -2*r*cos(w);
			a2 = r^2;
		};
	};

	// excitation: filtered noise burst. filters change in function of x/y position
	excitation = noiseburst : fi.highpass(2,40+exPos*500) : fi.lowpass(2,500+exPos*15000)
	with{
		// noise excitation
		noiseburst = no.noise*velocity : *(trig : ba.impulsify : trigger(P))
		with {
			 P = ma.SR/300;
  		 	 diffgtz(x) = x != x';
  		 	 decay(n,x) = x - (x>0)/n;
  		 	 release(n) = + ~ decay(n);
  		 	 trigger(n) = diffgtz : release(n) : > (0.0);
		};
	};
};


process = drum(0,y,1,t60S,trigger0) + drum(1,y,1,t60S,trigger1) + drum(2,y,1,t60S,trigger2) <: _,_;
