# Examples that Didn't Pass the Regression Test


## Failed the verifier


```sh
atax_float # output result does not match (maybe because of zext/sext implementation)
```


## Failed the dot2hdl

```sh
covariance_float # LSQ node has some problems, maybe because it has 0 loads
cordic # LSQ node has some problems, maybe because it has 0 loads
```
