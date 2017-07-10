declare interface "SmartKeyboard{
	'Number of Keyboards':'1',
	'Max Keyboard Polyphony':'0',
	'Keyboard 0 - Number of Keys':'2',
	'Keyboard 0 - Send Freq':'0',
	'Keyboard 0 - Piano Keyboard':'0'
}";
import("stdfaust.lib");

//record = button("gate"):int;
//x = hslider("x",0,0,1,0.01);
key = hslider("key",0,0,1,1) : int;
record = key;
// t = hslider("t[acc: 0 0 -10 0 10]",0.5,0,1,0.01);
frequency = hslider("frequency[acc: 0 0 -10 0 10]",1000,10,2000,0.01) : si.smoo;
del = hslider("del[acc: 1 0 -10 0 10]",1023,0,2047,0.01) : si.smoo;

cnt0 = +(1)~*(record) : -(1) : %(192000);
cnt1 = +(1)~*(1-record): -(1) : %(192000);

process = rwtable(192000, 0.0, cnt0, _, cnt1)*(1-record : si.smoo) :_*(os.osc(frequency)*0.5 + 0.5) : de.fdelay4(2048,del); //_*(os.osc(t)*0.5 + 0.5);// : _*(os.osc(freq)*0.5 + 0.5) ;//<: dm.zita_rev1;
