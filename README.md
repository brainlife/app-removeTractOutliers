# app-removeTractOutliers

This is a brainlife.io wrapper app for mbaComputeFibersOutliers algorithm. It takes an existing tract classification
and prune classified fibers that are unlike other fibers within the same tract.

# configuration

You can tweak the following parameters

* centroidSD

Cut streamlines which are this many standard deviations away from the tract centroid (geometric center). (default 4)

* lengthSD

Cut streamlines which are this many standard deviations away from the tract average streamline length (default 4)

* maxIter

The maximum number of iterations to compute tract averages and apply a cut. (try 5)

