# Regression Test

## Usage

Spcify a list of benchmarks to try in `filelist.lst`:
```
fir
```

Run the regression test:
```sh
bash regression_test.sh
```

View the results:
```
find . -name 'hls_verify.log' -exec grep -H Pass {} \;

# hopefully this should tell you this :)
# ./examples/fir/reports/hls_verify.log:Comparison of [end] : Pass
```

