
[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/brain-life/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.195-blue.svg)](https://doi.org/10.25663/brainlife.app.195)

# app-removeTractOutliers
This app uses [mbaComputeFibersOutliers](https://github.com/francopestilli/mba/blob/master/compute/mbaComputeFibersOutliers.m) from the [Matlab Brain Anatomy (MBA)](https://github.com/francopestilli/mba) script collection to perform a fiber cleaning operation.  Specifically, it removes outlier streamlines on the basis of ether [distance from fiber centroid core](https://github.com/francopestilli/mba/blob/1f06c4bd86da41322d292bfb0318ab61efe8b4a5/compute/mbaComputeFibersOutliers.m#L11) or [distance from mean streamline length](https://github.com/francopestilli/mba/blob/1f06c4bd86da41322d292bfb0318ab61efe8b4a5/compute/mbaComputeFibersOutliers.m#L13).  Moreover, this app performs this operation iteratively across all fiber tracts mapped in the input [White Matter Classification (WMC)](https://brainlife.io/datatype/5cc1d64c44947d8aea6b2d8b).  For this reason, it is advised that this application not be applied to [White Matter Classification (WMC)](https://brainlife.io/datatype/5cc1d64c44947d8aea6b2d8b) structures that do not correspond to "coherent white matter tracts", as the mathematical operations performed assume a "tract-like" morphology and coherence.

### Authors
- Daniel Bullock (dnbulloc@iu.edu)

### Contributors
- Soichi Hayashi (hayashis@iu.edu)

### Project Director
- Franco Pestilli (franpest@indiana.edu)

### Funding
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-ACI-1916518](https://img.shields.io/badge/NSF_ACI-1916518-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1916518)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://grantome.com/grant/NIH/R01-EB029272-01)
[![NIMH-T32-5T32MH103213-05](https://img.shields.io/badge/NIMH_T32-5T32MH103213--05-blue.svg)](https://projectreporter.nih.gov/project_info_description.cfm?aid=9725739)

### References 
[Avesani, P., McPherson, B., Hayashi, S. et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. Sci Data 6, 69 (2019).](https://doi.org/10.1038/s41597-019-0073-y)

## Running the App 

### Inputs

This application reqiures a [White Matter Classification (WMC)](https://brainlife.io/datatype/5cc1d64c44947d8aea6b2d8b) and **corresponding** [tractography](https://brainlife.io/datatype/5907d922436ee50ffde9c549) input. It is advised that this application not be applied to [White Matter Classification (WMC)](https://brainlife.io/datatype/5cc1d64c44947d8aea6b2d8b) structures that do not correspond to "coherent white matter tracts", as the mathematical operations performed assume a "tract-like" morphology and coherence.

### Configuration/Parameters

You can tweak the following parameters

* centroidSD

Cut streamlines which are this many standard deviations away from the tract centroid (geometric center). (default 4)

* lengthSD

Cut streamlines which are this many standard deviations away from the tract average streamline length (default 4)

* maxIter

The maximum number of iterations to compute tract averages and apply a cut. (try 5)

### On Brainlife.io

Visit [this page](https://doi.org/10.25663/brainlife.app.195) to run this app on the brainlife.io platform.  A [White Matter Classification (WMC)](https://brainlife.io/datatype/5cc1d64c44947d8aea6b2d8b) and **corresponding** [tractography](https://brainlife.io/datatype/5907d922436ee50ffde9c549) input.

### Running Locally (on your machine)

Given that this is, in essence, a wrapper around the [outlier removal function](https://github.com/francopestilli/mba/blob/master/compute/mbaComputeFibersOutliers.m), it is recommended that users desiring to use the unedrlying code simply use the underlying functions (i.e. the [wraper](https://github.com/DanNBullock/wma_tools/blob/master/ClassificationStruc_Tools/removeOutliersClassification.m) or [direct function](https://github.com/francopestilli/mba/blob/master/compute/mbaComputeFibersOutliers.m)).  This is as opposed to trying to use a dockerized version of this application.  Alternatively, [comperable methods](https://dipy.org/documentation/1.0.0./examples_built/cluster_confidence/) are available via [dipy](https://dipy.org/).

### Sample Datasets

Visit brainlife.io and explore the following data sets to find viable classification and tractography inputs:

HCP classificaiton:  https://brainlife.io/project/5c3caea0a6747b0036dcbf9a/
HCP tractography:  https://brainlife.io/project/5c3caea0a6747b0036dcbf9a/

### Output

The output of this application is a [White Matter Classification (WMC)](https://brainlife.io/datatype/5cc1d64c44947d8aea6b2d8b) structure which has been pruned in accordance with the set parameters.


