<h1 align="center">Remove Tract Outliers</h1>

<p align="center">
  A cleaned white matter classification, with outlier streamlines pruned from every tract by distance from the tract core and by length, using mbaComputeFibersOutliers.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.195"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.195-blue.svg" alt="Run on brainlife.io"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="MIT license"></a>
</p>

## At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Removes outlier streamlines from each tract of a white matter classification by distance from the tract centroid and by length, using mbaComputeFibersOutliers.**

Iteratively removes streamlines more than centroidSD standard deviations from the tract core or lengthSD from the mean length (up to maxIter passes) and saves a cleaned classification with tract JSONs; surfaces from the input are copied over. Use it on coherent, tract-like bundles; it is not meant for arbitrary streamline groupings.

| | |
|---|---|
| **Inputs** | `neuro/wmc` · `neuro/track/tck` |
| **Outputs** | `neuro/wmc` |
| **Container** | `brainlife/mcr:r2019a` |
| **Resources** | 8 CPUs · 28 GB memory · 10 h walltime |
| **Run it** | [doi.org/10.25663/brainlife.app.195](https://doi.org/10.25663/brainlife.app.195) |

#### Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `classification` | `neuro/wmc` | yes | White matter classification (classification.mat) to clean. Must index the streamlines of the given tractogram. |
| `wbfg` | `neuro/track/tck` | yes | Tractogram (.tck) the classification refers to. Streamline count must equal the length of the classification index. |

#### Outputs

| Output | Datatype | Description |
|---|---|---|
| `classification` | `neuro/wmc` | Cleaned white matter classification (classification.mat) with tract JSONs and the input surfaces. |

<details>
<summary><b>Parameters</b> (3)</summary>

| Parameter | Type | Default | Description |
|---|---|---|---|
| `centroidSD` | number | `4` | Cut streamlines which are this many standard deviations away from the tract centroid. |
| `lengthSD` | number | `4` | Cut streamlines which are this many standard deviations away from the tract average streamline length. |
| `maxIter` | number | `5` | The maximum number of iterations to compute tract averages and apply a cut. |

</details>

<!-- brainlife-app:end -->

## Versions on brainlife.io

Each version is a separate App on brainlife.io, built from its own branch of this repository.

| Version | Input datatype | Branch | Run it | Status |
|---|---|---|---|---|
| Remove Tract Outliers | `neuro/wmc` | [`1.4`](https://github.com/brainlife/app-removeTractOutliers/tree/1.4) | [doi:10.25663/brainlife.app.195](https://doi.org/10.25663/brainlife.app.195) | current |
| Remove Tract Outliers | `neuro/wmc-deprecated` | [`1.3`](https://github.com/brainlife/app-removeTractOutliers/tree/1.3) | [doi:10.25663/brainlife.app.157](https://doi.org/10.25663/brainlife.app.157) | deprecated |

## Running the App

### On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.195](https://doi.org/10.25663/brainlife.app.195), choose a [White Matter Classification (WMC)](https://brainlife.io/datatype/5cc1d64c44947d8aea6b2d8b) and the **corresponding** [tractogram](https://brainlife.io/datatype/5907d922436ee50ffde9c549) (`neuro/track/tck`), set the parameters and press **Execute**. The cleaned classification is archived as a `neuro/wmc` dataset tagged `cleaned`.

The App wraps [`mbaComputeFibersOutliers`](https://github.com/francopestilli/mba/blob/master/compute/mbaComputeFibersOutliers.m) from the [Matlab Brain Anatomy (MBA)](https://github.com/francopestilli/mba) collection, through `removeOutliersClassification` in [wma_tools](https://github.com/DanNBullock/wma_tools), and applies it to every tract in the classification. It removes streamlines that are far from the [tract centroid core](https://github.com/francopestilli/mba/blob/1f06c4bd86da41322d292bfb0318ab61efe8b4a5/compute/mbaComputeFibersOutliers.m#L11) or from the [mean streamline length](https://github.com/francopestilli/mba/blob/1f06c4bd86da41322d292bfb0318ab61efe8b4a5/compute/mbaComputeFibersOutliers.m#L13):

- `centroidSD`: cut streamlines this many standard deviations away from the tract centroid (default 4).
- `lengthSD`: cut streamlines this many standard deviations away from the tract's mean streamline length (default 4).
- `maxIter`: the maximum number of iterations of computing tract averages and applying a cut (default 5).

Do not apply it to classifications whose entries are not coherent white matter tracts: the computation assumes a tract-like morphology.

### Locally

You need [Singularity/Apptainer](https://apptainer.org/) and [`jq`](https://jqlang.github.io/jq/). The App runs the compiled MATLAB code in the `brainlife/mcr:r2019a` container.

1. Clone this repository and check out the App branch: `git checkout 1.4`.
2. Create `config.json` with the paths to your inputs and the parameters (see `config.json.sample`):

   ```json
   {
       "centroidSD": 4,
       "lengthSD": 4,
       "maxIter": 2,
       "classification": "testdata/full/classification.mat",
       "track": "testdata/full/track.tck"
   }
   ```

3. Run the App:

   ```bash
   ./main
   ```

Since this App is essentially a wrapper, if you want to use the method in your own code you may prefer to call the [wrapper](https://github.com/DanNBullock/wma_tools/blob/master/ClassificationStruc_Tools/removeOutliersClassification.m) or the [underlying function](https://github.com/francopestilli/mba/blob/master/compute/mbaComputeFibersOutliers.m) directly. [Comparable methods](https://dipy.org/documentation/1.0.0./examples_built/cluster_confidence/) are available in [DIPY](https://dipy.org/).

### Sample data

Viable classification and tractography inputs from the HCP are in this brainlife.io project: <https://brainlife.io/project/5c3caea0a6747b0036dcbf9a/>.

## Outputs

```text
classification/
├── classification.mat   pruned classification (`names` and per-streamline `index`)
├── tracts/              one JSON per tract (up to 1000 streamlines each) and tracts.json
└── surfaces/            copied from the input WMC when present
```

`product.json` reports the streamline count of each tract.

## Troubleshooting

- **`wmc(N) and track fiber(M) counts do not match`**: the classification and the tractogram come from different tracking runs. Use the tractogram the classification was made from.
- **`output missing`**: `classification/classification.mat` was not produced. Check the log for a count mismatch or a MATLAB error.

## Citing

> [!TIP]
> If you use this App in your work, please cite the App, the software it builds on and brainlife.io (below). GitHub's **Cite this repository** button gives the App citation in APA and BibTeX.

- Remove Tract Outliers. brainlife.io App. [doi:10.25663/brainlife.app.195](https://doi.org/10.25663/brainlife.app.195)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. Sci Data 6, 69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)

## Authors

- Daniel Bullock
- Franco Pestilli (project director)

**Contributors:** Soichi Hayashi

## Funding

[![Wellcome-226486/Z/22/Z](https://img.shields.io/badge/Wellcome-226486%2FZ%2F22%2FZ-purple.svg)](https://wellcome.org/)
[![NIH-NINDS-U24NS140384](https://img.shields.io/badge/NIH_NINDS-U24NS140384-green.svg)](https://reporter.nih.gov/project-details/11261037)
[![NIH-NINDS-UM1NS132207](https://img.shields.io/badge/NIH_NINDS-UM1NS132207-green.svg)](https://reporter.nih.gov/project-details/11411328)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://reporter.nih.gov/project-details/10262925)
[![NIH-NIBIB-R01EB030896](https://img.shields.io/badge/NIH_NIBIB-R01EB030896-green.svg)](https://reporter.nih.gov/project-details/10428625)
[![NIH-NIMH-R01MH126699](https://img.shields.io/badge/NIH_NIMH-R01MH126699-green.svg)](https://reporter.nih.gov/project-details/10460628)
[![NIH-NIDCD-R01DC020088](https://img.shields.io/badge/NIH_NIDCD-R01DC020088-green.svg)](https://reporter.nih.gov/project-details/11140284)
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-2203524](https://img.shields.io/badge/NSF_BCS-2203524-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2203524)
[![NSF-IIS-1636893](https://img.shields.io/badge/NSF_IIS-1636893-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-OAC-2148729](https://img.shields.io/badge/NSF_OAC-2148729-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148729)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-IIS-2148700](https://img.shields.io/badge/NSF_IIS-2148700-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148700)
[![NSF-OAC-1916518](https://img.shields.io/badge/NSF_OAC-1916518-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1916518)

<sub>brainlife.io is publicly funded, and acknowledging that support helps keep it running. This App was developed with support from Wellcome, the U.S. National Institutes of Health (including the BRAIN Initiative BRAIN CONNECTS program: The Axonal Projectome EXchange, U24NS140384, and the Center for Mesoscale Connectomics, UM1NS132207) and the U.S. National Science Foundation.</sub>

## License

[MIT](LICENSE).
