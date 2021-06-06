# Commmand line arguments parser - Grammar


```
fiona [OPTION] [FLAGS] <input_file>

One option can be chosen.
Multiple flags can be set (in any order).

Available Options:

OPTION    score     'forecasting tournament' [default]
          compare   'adversarial collaboration'

Available Flags:

FLAGS     -h, --help    'print help message'
          -v, --verbose 'print more info during execution'

```


```
  START :=
    <score option> FLAGS_OR_INPUT
    <compare option> FLAGS_OR_INPUT
    <flag> FLAGS_OR_INPUT
    <char sequence> END   

  FLAGS_OR_INPUT :=
    <flag> FLAGS_OR_INPUT
    <char sequence> EXPECT_END

  EXPECT_END :=
    <end of arguments> STOP
```
