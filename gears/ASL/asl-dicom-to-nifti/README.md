[ASLtbx](https://cfn.upenn.edu/~zewang/ASLtbx.php) requires that the dicoms be prepared in a very particular way: The first dicom in an acquisition becomes a 3D nifti file, the second is discarded and the remaining 10 become a 4D nifti file. Neither nifti file should be compressed. This gear uses [dcm2niix](https://github.com/rordenlab/dcm2niix) to perform that specific dicom-to-nifti transformation.

The input file should be a zip file containing 12 dicoms. The gear takes two parameters: The name you want to give the 3D nifti and the name you want to give the 4D nifti.