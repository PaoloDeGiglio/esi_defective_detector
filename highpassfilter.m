function realOutput = highpassfilter(A,window)

grayImage = A;

% Take the FFT.
fftImage = fft2(grayImage);

% Zero out the corners

fftImage(1:window, 1:window) = 0;
fftImage(end-window:end, 1:window) = 0;
fftImage(1:window, end-window:end) = 0;
fftImage(end-window:end, end-window:end) = 0;

% Inverse FFT to get high pass filtered image.
output = ifft2(fftImage);

realOutput = real(output);
end