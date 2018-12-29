% Creating my own simulation of up and down sampling.  Begins by generating
% a 200 Hz sine wave, then samples it at 2000 Hz.  The digital version is
% plotted.  Next the digital samples are down sampled to 1/2 the rate (1000
% Hz) and the result is plotted.  Finally, the original 200 Hz sine wave is
% upsampled to 600 Hz and plotted.

clear all;

% All frequency values are in Hz.
Fs = 2000;      % Sampling Frequency
Forig = 200;    % Original sine wave frequency

% Filter specifications
N     = 20;     % Order
Fpass = 200;    % Passband Frequency
Fstop = 300;    % Stopband Frequency
Wpass = 1;      % Passband Weight
Wstop = 1;      % Stopband Weight

% Calculate the coefficients using the FIRLS function.
b  = firls(N, [0 Fpass Fstop Fs/2]/(Fs/2), [1 1 0 0], [Wpass Wstop]);

% Generate the sine wave
sin_orig = dsp.SineWave(1,Forig,0,'SampleRate',Fs,'SamplesPerFrame',2*Fs/Forig);
y = sin_orig();
figure;
subplot(3,1,2);
plot(y);
title('Original Signal');
xlabel('Hertz');

% Down sample
sin_down = downsample(sin_orig(),2);
subplot(3,1,1);
plot(sin_down);
title('Down Sampled');
xlabel('Hertz');

% Up Sampled
sin_up = upsample(sin_orig(),3);
sin_up_interp = filter(b,1,sin_up);

% Plot
subplot(3,1,3);
plot(sin_up_interp);
title('Up Sampled');
xlabel('Hertz');
H = dsp.FIRFilter(b);
figure;
%freqz(b,1,256)
