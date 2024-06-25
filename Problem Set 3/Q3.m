%%

clear vars;
clc;

%Reading the "existing" file (If it doesn't exist, an error is thrown.)
try
    [audioData, sampleRate] = audioread('i_hope_i_dont_lose_my_job.wav');
catch
    error('Error: The audio file "i_hope_i_dont_lose_my_job.wav" does not exist or could not be read. Please check the location and extension of your file.');
end


try
    % Performing a Fourier Transform operation
    audioDataFFT = fft(audioData);

    n = length(audioData);
    frequencies = (0:n-1)*(sampleRate/n);

    snareFreqRange = (frequencies >= 150 & frequencies <= 250) | (frequencies >= (sampleRate - 250) & frequencies <= (sampleRate - 150));

    audioDataFFT(snareFreqRange) = audioDataFFT(snareFreqRange) * 0.75;

    % Performing an Inverse Fourier Transform operation
    modifiedAudioData = ifft(audioDataFFT, 'symmetric');
catch
    error('Error: An error occurred while processing the audio data. Please try again later.');
end

% Writing into another .wav file which saves Navin's job.
try
    audiowrite('thankyou_for_saving_my_job.wav', modifiedAudioData, sampleRate);
    disp('The volume of the snare drums has been successfully reduced by 25%.');
catch
    error('Error: The modified audio file could not be written. Please try again later.');
end


%%
