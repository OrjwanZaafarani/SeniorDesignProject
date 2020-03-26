
%% IMU CALIBRATION    
 while 1
        AccelReading = readAcceleration(SH);
        AngularReading = readAngularVelocity(SH);
        MagneticReading = readMagneticField(SH);
        
%         FUSE = ahrsfilter << This is run in the command window just like rpi=raspi and SH=sensehat(rpi)

%         Orientation_Quaternion = FUSE(AccelReading, AngularReading, MagneticReading);
%         disp('Quaternion:');
%         disp(Orientation_Quaternion);
%         Orientation_eulerAngles = eulerd(Orientation_Quaternion,'ZYX','frame'); 
%         disp('Euler:');
%         disp(Orientation_eulerAngles);

        Orientation_Quaternion = ecompass(AccelReading,MagneticReading);
        eulerAngles = eulerd(Orientation_Quaternion,'ZYX','frame');
        Orientation_eulerAngles = eulerAngles(:,2);
        disp('Euler:');
        disp(Orientation_eulerAngles);
        pause(0.05);
 end