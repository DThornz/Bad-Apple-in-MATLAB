clear;clc;close all
%% Load Video
v=VideoReader('Bad_Apple.mp4');
%% Parse Video
try
    load bad_apple.mat
catch
    s = settings;
    s.matlab.fonts.codefont.Size.TemporaryValue = 8; % points
    numFrames=v.NumFrames;
    frame_size=150;
    width=v.Width;
    height=v.Height;
    aspect_ratio=height/(width*2.5);
    new_height=int16(aspect_ratio*frame_size);
    new_width=int16((1/aspect_ratio)*frame_size);
    bad_apple_text=cell(1,numFrames);
    for ii=1:1000
        %     temp=imresize(im2gray(v.readFrame),[v.Height/32+25+33+28+3 4*v.Width/32+88]);
        %     temp=im2gray(v.readFrame);
        %     temp=imresize(im2gray(v.readFrame),[1.5*75+9, 5*45]);
        temp=imresize(im2gray(v.readFrame),[frame_size-20, new_height+150]);
        temp(temp<200)=0;
        imfile=['FrameNum ' int2str(ii) '.png'];
        str=img2txt(temp);
        bad_apple_text{ii}=str;
        disp(str)
    end
    save('bad_apple.mat','bad_apple_text','-v7.3')
end
%% Show results in console
s.matlab.fonts.codefont.Size.TemporaryValue = 8; % points
for ii=1:length(bad_apple_text)
    tic
    disp(bad_apple_text{ii});
    t=toc;
%     pause(1/60 - t)
%         clc
end
%% Restore MATLAB font settings
clearTemporaryValue(s.matlab.fonts.codefont.Size);