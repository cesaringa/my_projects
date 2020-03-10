clear all
clc
close all

% *************************************************************************
% ***************************** ORIGINAL AUDIO ****************************
% *************************************************************************

% MAGNITUDE SPECTRUM OF THE ORIGINAL SIGNAL_______________________________
[y_original,fs] = audioread('speech_dft.avi'); % Reading an audio from MATLAB files
L=size(y_original);                            % Getting the size of the audio
sound(y_original,fs);                          % Playing the original sound
figure(1)
plot(y_original,'c');                          % Plotting in Time domain
title ('Original audio in time domain');
xlabel('Time duration (samples)');
ylabel('Amplitude');


% ORIGINAL AUDIO IN THE FREQUENCY DOMAIN (FFT)_____________________________

y_fft = abs(fft(y_original));                  % Getting the FFT of the original audio
length_y_fft = length(y_fft);                  % Getting the lenght of the audio
figure(2)                                      % Plotting the half of FFT at a Normalised Frequency
plot([0:1/(length_y_fft/2 -1):1], y_fft(1:length_y_fft/2),'c')
title ('FFT of the original audio signal');         
xlabel('Normalised frequency (\pi rads/sample)');
ylabel('Amplitude');
legend('Original sound');
grid on
grid minor
hold on
pause

% *************************************************************************
% *********************** ADDING NOISE TO THE AUDIO ***********************
% *************************************************************************

% MAGNITUDE SPECTRUM OF THE AUDIO + NOISE__________________________________

x_noise = awgn(y_original,30);                  % Adding a gaussian noise
sound(x_noise,fs);                              % Playing sound + noise
figure(3)
plot(x_noise,'k');                              % Plotting sound + noise in Time domain
title ('Sound + Noise');
xlabel('Time duration (samples)');
ylabel('Amplitude');
legend('Gaussian noise')

% AUDIO + NOISE _ FREQUENCY DOMAIN (FFT)___________________________________
x_noise_fft = abs(fft(x_noise));                % Getting the FFT of the audio + noise
lenght_x_noise_fft = length(x_noise_fft);       % Getting the lenght of the audio + noise

figure(4)                                       
plot([0:1/(lenght_x_noise_fft/2 -1):1], x_noise_fft(1:lenght_x_noise_fft/2),'k')
title ('FFT of the Audio signal with Noise');
xlabel('Normalised frequency (\pi rads/sample)');
ylabel('Amplitude');
legend('Sound + Noise signal');
grid on
grid minor
hold on
pause

% *************************************************************************
% ***************** FILTERING THE AUDIO AFFECTED BY NOISE *****************
% *************************** FILTER_1 LOW PASS ***************************
% *************************************************************************

% FILER DESIGN 1 using a butterworth design technique__________________

%Use matlab built-in buttord function to get the optimum order to meet a specification
Wp = 0.7;                                      % Passband corner frequency
Ws = 0.9;                                      % Stopband corner frequency
Rp = 5;                                        % Passband ripple in decibels.
Rs = 40;                                       % Stopband attenuation in decibels
[N Wn] = buttord (Wp,Ws,Rp,Rs);                % N: Filter order, Wn: Cutoff frequency
 
%N = 10;                                        % Filter order
%Wn = 0.7;                                      % Cutoff frequency
[b a] = butter(N, Wn, 'low');                  % Getting parameters of the filter

H = freqz(b,a, floor(lenght_x_noise_fft/2));
hold on
figure(5)                                      % plot the magnitude spectrum
plot([0:1/(lenght_x_noise_fft/2 -1):1], abs(H),'r');
title ('Frecuency response of a Low Pass filter');
xlabel('Normalised frequency (\pi rads/sample)');
ylabel('Amplitude');
grid on
grid minor
x_noise_filtered = filter(b,a,x_noise);        % Appllying the designed filter to the audio + noise
                                        
% FILTERED AUDIO - TIME DOMAIN_________________________________
sound(x_noise_filtered,fs)                     % Playing the filtered sound
hold on
figure(6)
plot(x_noise_filtered,'r')                     % Plotting the filtered sound in Time domain
title(['Filtered signal in Time domain using ' num2str(N) ' th Order Butterworth Low Pass'])
xlabel('Samples');
ylabel('Amplitude');

% FILTERED AUDIO - FREQUENCY DOMAIN (FFT)______________________

x_noise_filtered_fft = abs(fft(x_noise_filtered));         % Getting the FFT of the audio + noise
lenght_x_noise_filtered_fft = length(x_noise_filtered_fft);% Getting the lenght of the audio + noise
hold on
figure(7)                                                  % Plotting the half of DFT at a Normalised Frequency
plot([0:1/(lenght_x_noise_filtered_fft/2 -1):1], x_noise_filtered_fft(1:lenght_x_noise_filtered_fft/2),'r')
title(['FFT of Filtered signal using ' num2str(N) ' th Order Butterworth Low Pass'])
xlabel('Normalised frequency (\pi rads/sample)');
ylabel('Amplitude');
legend('Filtered audio signal');
grid on
grid minor
pause

% *************************************************************************
% ***************** FILTERING THE AUDIO AFFECTED BY NOISE *****************
% ************************** FILTER_2 STOP BAND ***************************
% *************************************************************************

% FILER DESIGN 2 using a butterworth design technique__________________

N2 = 10;                                   % Filter order
[b2,a2] = butter(N2,[0.5 0.7],'stop');     % Getting parameters of the filter

% Magnitude spectrum of the filtered signal 2
H_stop = freqz(b2,a2, floor(lenght_x_noise_filtered_fft/2));
hold on

figure(8)
plot([0:1/(lenght_x_noise_filtered_fft/2 -1):1], abs(H_stop),'g');
title ('Frecuency response of the Stop band filter');
xlabel('Normalised frequency (\pi rads/sample)');
ylabel('Amplitude');
grid on
grid minor
x_noise_filtered2 = filter(b2,a2,x_noise_filtered);    % Appllying the designed filter to the audio + noise
                                        
% FILTERED AUDIO - TIME DOMAIN_____________________________________________
sound(x_noise_filtered2,fs)                     % Playing the filtered sound
hold on
figure(9)
plot(x_noise_filtered2,'b')                     % Plotting the filtered sound in Time domain
title(['Filtered signal in Time domain using ' num2str(N) ' th Order Butterworth Stop Band'])
xlabel('Samples');
ylabel('Amplitude');

% FILTERED AUDIO - FREQUENCY DOMAIN (FFT)__________________________________

x_noise_filtered2_fft = abs(fft(x_noise_filtered2)); % Getting the fFT of the noisy audio + filter 1
lenght_x_filtered2 = length(x_noise_filtered2_fft); % Getting the lenght of the noisy audio + filter 1
hold on
figure(10)                                          % Plotting the half of DFT at a Normalised Frequency
plot([0:1/(lenght_x_filtered2/2 -1):1], x_noise_filtered2_fft(1:lenght_x_filtered2/2),'b') 
title(['FFT of Filtered signal using ' num2str(N) ' th Order Butterworth Stop band'])
xlabel('Normalised frequency (\pi rads/sample)');
ylabel('Amplitude');
legend('Filtered audio signal');
grid on
grid minor

hold on



% *************************************************************************
% ***** COMPARISON BETWEEN ORIGINAL SIGNAL AND FILTERED ONES ACHIEVED  ****
% *************************************************************************

figure(11)                                       
plot([0:1/(lenght_x_noise_fft/2 -1):1], x_noise_fft(1:lenght_x_noise_fft/2),'k') % Signal + Noise
hold on
plot([0:1/(length_y_fft/2 -1):1], y_fft(1:length_y_fft/2),'c') % Original signal
title ('FFT Comparison between "original signal" with "signal + noise"');
xlabel('Normalised frequency (\pi rads/sample)');
ylabel('Amplitude');
legend('Sound + Noise signal', 'Original sound');
grid on
grid minor
hold on
                                     
figure(12)                                       
plot([0:1/(lenght_x_noise_filtered_fft/2 -1):1], x_noise_filtered_fft(1:lenght_x_noise_filtered_fft/2),'r') % Filtered signal_filter low pass
hold on
plot([0:1/(length_y_fft/2 -1):1], y_fft(1:length_y_fft/2),'c') % Original signal
title ('FFT Comparison between "Original signal" with "Filtered signal_filter low pass"');
xlabel('Normalised frequency (\pi rads/sample)');
ylabel('Amplitude');
legend('Filtered signal with low pass filter', 'Original sound');
grid on
grid minor
hold on

figure(13)                                       
plot([0:1/(lenght_x_filtered2/2 -1):1], x_noise_filtered2_fft(1:lenght_x_filtered2/2),'b') % Filtered signal_filter stop band
hold on
plot([0:1/(length_y_fft/2 -1):1], y_fft(1:length_y_fft/2),'c') % Original signal
title ('FFT Comparison between "Original signal" with "Filtered signal_filter low pass"');
xlabel('Normalised frequency (\pi rads/sample)');
ylabel('Amplitude');
legend('Filtered signal with stop band filter', 'Original sound');
grid on
grid minor
hold on

fvtool (b,a);
fvtool (b2,a2);

%substract amplitudes  to see what part to apply the filters %
%explain noise behaviour
%explain filter design and why i chose one and no others
