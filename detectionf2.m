clear all;                                                                  %clear all commands from workspace if there before running
clc;                                                                        %clear command window
cam = webcam;                                                               %gives the variable name cam to the device webam;
while 1                                                                     %infinite loop stars
    time1 = tic;                                                            %time1 variable given to the start of time with command tic
    while toc(time1) <0.01                                                  %loop stars which ends when time which was started by time1 reaches 0.01 sec
        toc(time1);                                                         %gives the time after the start of time of the variable time1
    end                                                                     %time1 loop ends i.e. time1 reaches 0.01 sec or a bit higher
    i=1;                                                                    %some random variable i is assigned value as 1
    while i<101                                                             %loop is started which is terminated by 100 times unless stated by break command                
        
        img1=snapshot(cam);                                                 %variable named img1 stores the image taken by webcam(which is stored in variable cam)         
        img2=imsubtract(img1(:,:,1),rgb2gray(img1));                        %img1 is converted to the image which has more red intensity from which a gray scale image of img1 is subtracted and stored in img2
        img3=medfilt2(img2,[2 2]);                                          %it removes noise from img2 around the matrix whose dimensions are 2x2 and then stored in img3
        img4=im2bw(img3, 0.09);                                             %converts the img3 image to binary image with level 0.09 (level here basically means blurring)and then stored in img4
        img5=bwareaopen(img4,300);                                          %from img4, it removes the nearby small objects whose pixels shared among each other are less than 300 and the final output is stored in img5. the main difference between medfilt2 and bwareaopen is that medfilt2 is for colored image and bwareaopen is only for binary image
        if img5 == zeros(480,640)                                           %condition is given which will be passed only if img5 is a zeros matrix of 480x640 dimension
            if i>1                                                          %condition if variable i(declared already) which will be passed only if i is greater than 1 
                timetaken=toc(objectenters);                                %variable named timetaken stores the time clocked after the tick stored in variable objectenters started(tic is declared later but the condition is so put that until and unless tic isn't started toc won't come and so there will be no error in the compiling)
                k=floor(i/2);                                               %variable named k stores the greatest integer less than i/2
                filename3 = strcat('img',num2str(k),'a.jpg');               %filename stores the name of the file which is catenated for different images using the command strcat(string catenation), the characters in apostrophe are constants and left in the command changes after a no is converted into string 
                img6 = imread(  filename3);                                 %variable img6 reads the stores the image from harddrive with a name which is stored in filename3
               t=1;                                                         %some variable t is assigned a value one
                
                while img6(t)==0                                            %loop is started which will be passed only if img6's element t is equal to zero
                    t=t+1;                                                  %the variable t is incremented by one        
                end                                                         %the loop of img6(t)==0 is terminated over here
                ic=floor(t/480)+1;                                          %ic variable(intial column) stores the value of greatest integer value of t/480 +1; where t is the value after coming out of the loop
                
                t=307200;                                                   %t is assigned values 307200(480x640 which is dimension of the matrix of the image)
                while img6(t)==0                                            %loop is started which will be passed by img6's t element is equal to 0
                    t=t-1;                                                  %variable t (declared alreay) is decremented by 1
                end                                                         %loop img6(t) is ended
                fc=floor(t/480)+1;                                          %fc variable (final column) stores the values greatest integer of t/480 +1
                
%                 pixelscovered=abs(ic-fc);                                   %pixelscovered variable stores the value which is equal to the difference between ic and fc i.e.(intial columna and final column)
                d=(31*pixelscovered)/(100*81);                              %d is the distance of the object from the cam, where 31 cm is reference distance of some object from the webcam which covers 81 pixels for the current object length in pixel is stored in variable pixelscovered and division by 100 is for converting cm into m
                D=2*d*tand(30);                                             %D stores the distance travelled by object in metres in the view of the camera
                currentvelocity=((4.2/100)+D)/(timetaken);                  %gives the average velocity the object had while crossing the field of vision of webcam
                Timenstws=2000/currentvelocity;
                mtimea=(275/9-currentvelocity)*9/80;
                distancea=((275/9)^2-currentvelocity^2)/(2*80/9);
               distanceb=2000-distancea;
               mtimeb=distanceb/(275/9);
               minimumtime=mtimea+mtimeb;                
                break;                                                      %it breaks the lop
                
            end                                                             %end of the loop for i>1
            continue;                                                       %condition for img5==zeros(480,640) for being continuing the current loop without cfinishing the current loop    
        else                                                                %another condition for img5==zeros(480,640) is declared
            filename1 = strcat ('img',num2str(i),'a.jpg');                  %filename which string catenated is given
            filename2 = strcat ('img', num2str(i),'b.jpg');                 %filename which string catenated is given
            imwrite(img5,filename1);                                        %file with variable img5 is stored
            imwrite(img1,filename2);        
           
            if i ==1
                inimage=img5;
                objectenters=tic;
            end
            i=i+1;
            
            
            
        end
    end
    break;
end