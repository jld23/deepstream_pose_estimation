# DeepStream Human Pose Estimation

Human pose estimation is the computer vision task of estimating the configuration (‘the pose’) of the human body by localizing certain key points on a body within a video or a photo. The following application serves as a reference to deploy custom pose estimation models with DeepStream 5.0 using the [TRTPose](https://github.com/NVIDIA-AI-IOT/trt_pose) project as an example. 

A detailed deep-dive NVIDIA Developer blog is available [here](https://developer.nvidia.com/blog/creating-a-human-pose-estimation-application-with-deepstream-sdk/?ncid=so-link-52952-vt24&sfdcid=EM08#cid=em08_so-link_en-us).
<!--<img src="images/input.gif" width="300"/> <img src="images/auxillary.png" width="100"/> <img src="images/output.gif" width="300"/>-->

<table>
  <tr>
    <td>Input Video Source</td>
     <td></td>
     <td>Output Video</td>
  </tr>
  <tr>
    <td valign="top"><img src="images/input.gif"></td>
    <td valign="center"><img src="images/auxillary.png" width="100"></td>
    <td valign="top"><img src="images/output.gif"></td>
  </tr>
 </table>


## Prerequisites
You will need 
1. DeepStreamSDK 5.0
2. CUDA 10.2
3. TensorRT 7.x


## Getting Started:
To get started, please follow these steps.
1. Install [DeepStream](https://developer.nvidia.com/deepstream-sdk) on your platform, verify it is working by running deepstream-app.
2. Clone the repository preferably in `$DEEPSTREAM_DIR/sources/apps/sample_apps`.
2. Download the TRTPose [model](https://github.com/NVIDIA-AI-IOT/trt_pose), convert it to ONNX using this [export utility](https://github.com/NVIDIA-AI-IOT/trt_pose/blob/master/trt_pose/utils/export_for_isaac.py), and set its location in the DeepStream configuration file.
3. Replace the OSD binaries (x86 or Jetson) in `$DEEPSTREAM_DIR/libs` with the ones provided in this repository under `bin/`. Please note that these are not inter-compatible across platforms.
4. Compile the program
 ```
  $ cd deepstream-pose-estimation/
  $ sudo make
  $ sudo ./deepstream-pose-estimation-app <file-uri> <output-path>
```
5. The final output is stored in 'output-path' as `Pose_Estimation.mp4`

NOTE: If you do not already have a .trt engine generated from the ONNX model you provided to DeepStream, an engine will be created on the first run of the application. Depending upon the system you’re using, this may take anywhere from 4 to 10 minutes.

For any issues or questions, please feel free to make a new post on the [DeepStreamSDK forums](https://forums.developer.nvidia.com/c/accelerated-computing/intelligent-video-analytics/deepstream-sdk/).

## References
Cao, Zhe, et al. "Realtime multi-person 2d pose estimation using part affinity fields." Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition. 2017.

Xiao, Bin, Haiping Wu, and Yichen Wei. "Simple baselines for human pose estimation and tracking." Proceedings of the European Conference on Computer Vision (ECCV). 2018.

## Notes

after building the container and project this command works
```{bash}
root@29899558d390:/opt/nvidia/deepstream/deepstream-6.0/sources/apps/sample_apps/deepstream-pose_estimation# ./deepstream-pose-estimation-app ../../../../samples/streams/sample_720p.h264 ./720p3_

```
and this doesn't
```{bash}
root@29899558d390:/opt/nvidia/deepstream/deepstream-6.0/sources/apps/sample_apps/deepstream-pose_estimation# ./deepstream-pose-estimation-app ncsu_swing.mp4 ./post_
```
Here is the error message:
```
Now playing: ncsu_swing.mp4
0:00:02.097240502 235336 0x55abba917d80 INFO                 nvinfer gstnvinfer.cpp:638:gst_nvinfer_logger:<primary-nvinference-engine> NvDsInferContext[UID 1]: Info from NvDsInferContextImpl::deserializeEngineAndBackend() <nvdsinfer_context_impl.cpp:1900> [UID = 1]: deserialized trt engine from :/opt/nvidia/deepstream/deepstream-6.0/sources/apps/sample_apps/deepstream-pose_estimation/pose_estimation.onnx_b1_gpu0_fp32.engine
INFO: ../nvdsinfer/nvdsinfer_model_builder.cpp:610 [Implicit Engine Info]: layers num: 3
0   INPUT  kFLOAT input.1         3x224x224       
1   OUTPUT kFLOAT 262             18x56x56        
2   OUTPUT kFLOAT 264             42x56x56        

0:00:02.097343549 235336 0x55abba917d80 INFO                 nvinfer gstnvinfer.cpp:638:gst_nvinfer_logger:<primary-nvinference-engine> NvDsInferContext[UID 1]: Info from NvDsInferContextImpl::generateBackendContext() <nvdsinfer_context_impl.cpp:2004> [UID = 1]: Use deserialized engine model: /opt/nvidia/deepstream/deepstream-6.0/sources/apps/sample_apps/deepstream-pose_estimation/pose_estimation.onnx_b1_gpu0_fp32.engine
0:00:02.102549947 235336 0x55abba917d80 INFO                 nvinfer gstnvinfer_impl.cpp:313:notifyLoadModelStatus:<primary-nvinference-engine> [UID 1]: Load new model:deepstream_pose_estimation_config.txt sucessfully
Running...
ERROR from element h264-parser: Failed to parse stream
Error details: gstbaseparse.c(2998): gst_base_parse_check_sync (): /GstPipeline:deepstream-tensorrt-openpose-pipeline/GstH264Parse:h264-parser
Returned, stopping playback
Deleting pipeline
```

The codex are the same as viewed in VLC except the frame rate

![image](codec1.png)



This hangs
```
root@29899558d390:/opt/nvidia/deepstream/deepstream-6.0/sources/apps/sample_apps/deepstream-pose_estimation# ./deepstream-pose-estimation-app /opt/nvidia/deepstream/deepstream-6.0/samples/streams/sample_1080p_h264.mp4 ./1080p_
```
