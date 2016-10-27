+++
categories = ["projects"]
date = "2016-10-02T22:55:05-04:00"
tags = ["projects"]
title = "Projects"
showpagemeta = "false"
+++

<section id="projects">
  <div class="container">
    <h3>Projects</h3>
    <div class="panel panel-default">
      <div class="panel-body">
      <h5>
        <i class="fa fa-github"></i>&nbsp;&nbsp;<strong><a href="https://github.com/kentsommer/2D-EKF-SLAM">2D Extendend Kalman Filter Based SLAM</a></strong> <br>
        <i class="fa fa-cog"></i>&nbsp;&nbsp;<a href="SLAM_report.pdf" target="_blank">Paper</a> <br>
        - This project serves as a robust simultaneous localization and mapping stack written for use on the Pioneer 3-DX with a SICK LMS-200 laser scanner in a pre-determined environment. It uses the extended kalman filter approach to SLAM which until recently was the go-to method of implementing SLAM. It consists of three main parts: motion controller, feature detector, and kalman filter. The motion controller runs in a separate thread to allow for faster updates and follows the following logic: turn left whenever possible, otherwise continue straight and align to the walls on either side. The feature detector works by applying the Hough Transform to extract lines which are subsequently processed down into segments and then corners which are used as features. The kalman filter is a standard implementation and uses the Mahalanobis distance algorithm to determine if landmarks are new or are being re-detected. 
      </h5>
      <h5>
        <i class="fa fa-github"></i>&nbsp;&nbsp;<strong><a href="https://github.com/kentsommer/obstacle_detection">3D Obstacle Detection</a></strong> <br>
        - This project serves as an obstacle detection stack with the goal of being efficient enough to run on relatively low powered hardware. The approach starts with an unfiltered pointcloud (from an 3D sensor). The first step is a passthrough filter which cuts off points further away in the Z direction than would be visible given the starting camera angle. Next I applied a voxel grid downsample to further help reduce the number of points. This was followed by performing statistical outlier removal on the points that didn't fit the set model (not enough points close enough together). The next step was ground extraction which used the following: RANSAC plane fitting, group plane inlier extraction, ground plane outlier extraction, convex hull creation from projected ground inliers, and finally outlier extraction from above the convex hull. The output of this could then be passed on to the path planning system. It is able to accurately detect objects as thin as 1.2 cm that are on the floor. 
      </h5>
        <h5>
        <i class="fa fa-github"></i>&nbsp;&nbsp;<strong><a href="https://github.com/kentsommer/3DObjectReconstruction">3D Object Reconstruction</a></strong> <br>
        <i class="fa fa-cog"></i>&nbsp;&nbsp;<a href="3D+Model+Reconstruction+Paper.pdf" target="_blank">Individual Paper</a> <br>
        <i class="fa fa-cog"></i>&nbsp;&nbsp;<a href="3D+Model+Reconstruction+Group+Paper.pdf" target="_blank">Group Paper</a> <br>
        - This served as my final project for CSCI 5561 (Computer Vision). Using a single camera with pictures taken at multiple angles, this project allowed for a dense reconstruction of the original object. The project relies heavily on the principle of shape from silhouettes and voxel carving. It works by first extracting a silhouette of the object at all camera angles. These binary images are then used to carve away a bounding box of the object using shape from silhouettes. Finally, the carved model is then retextured by matching the 3D model points to their respective original images. 
      </h5>
      <h5>
        <i class="fa fa-cog"></i>&nbsp;&nbsp;<strong><a href="Sodoku+AI+Research+Paper.pdf">Sudoku AI Research Paper</a></strong> <br>
        - This paper was my final research paper for CSCI 4511W (Introduction to Artificial Intelligence). It examines various approaches to building an AI for Sudoku.
      </h5>


      </div>
    </div>
  </div>
</section>

