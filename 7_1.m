%read the image file. 
background = imread('background.jpg'); 
%convert the image into a double. 
background = double(background); 
%convert the image into a grayscale value. 
background = .2989*background(:,:,1)+.5870*background(:,:,2)+.1140*background(:,:,3);
%read the video file and find the number of frames in the video. 
video = VideoReader('video4tracking(1).avi'); 
numFrames = video.NumberOfFrames; 
%initialize the variables. 
com=zeros(1,numFrames); 
speed=zeros(1,numFrames); 
position=zeros(1,numFrames); 
d=zeros(1,numFrames); 
%for loop to manipulate each frame 
for i = 1:numFrames 
    %read each frame of video and manipulate it. 
    video1 = read(video, i); 
    video1 = double(video1); 
    video1 = .2989*video1(:,:,1)+.5870*video1(:,:,2)+.1140*video1(:,:,3); 
    %compute the difference between the value of background and video1. 
    d = background-video1; 
    %if there is a large enough deviation, the center of mass will be %computed. 
    if (norm(d)>5000) 
        com(i) = alaounm7_2 (d); 
    else
        %if the deviation is not large enough for the center of mass to be %computed, the center of mass will take the value of the previous %center of mass. 
        if(i>1) 
            com(i) = com(i-1); 
        end
    end
    %position function that finds the position of the person in the video. 
    position(i) = com(i) * ((110-0)/video.Width); 
    if(i>1) 
        %the speed function that finds the velocity of the person in the %video. 
        speed(i) = (position(i) - position(i-1))/(1/video.FrameRate); 
    end
end
%prints out the plots of position vs. time and speed vs. time. grid is on %for better readability. 
t = 0:1/video.FrameRate:(numFrames-1)/video.FrameRate;
subplot(2,1,1);
plot(t, position);
xlabel ('Time(seconds)'); 
ylabel ('Position(inches)');
title ('Plot of Position vs. Time');
grid on; 
subplot(2,1,2);
plot(t, speed);
xlabel('Time(seconds)');
ylabel ('Speed(inches/second)');
title ('Plot of Speed vs. Time');
grid on;