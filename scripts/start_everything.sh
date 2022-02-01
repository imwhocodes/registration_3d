#!/bin/bash
# Armin Niedermueller 

screen -dm -S ipcrunnrer

echo "Starting Both 3D Cams, Alignment and RVIZ"
sleep 1

echo "Starting 3D Cams"
roslaunch registration_3d start_3d_cams.launch &
sleep 3

echo "Starting ICP Alignment"
bash -c 'rosrun registration_3d preprocess_align_publish allsteps=true algorithm=nlicp /cam_1/depth/color/points /cam_2/depth/color/points' &
sleep 1

echo "Aligning second 3D Cam to Desk"
rosrun tf static_transform_publisher 0.5 -1.0 -1.6 -1.0 -0.1 0.0 3.0 world cam_2_depth_optical_frame 3" &

echo "Starting RVIZ"
bash -c 'roslaunch registration_3d rviz_with_both_cams.launch'
sleep 1

echo "Finished"
