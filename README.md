# Scripts to load the MS-COCO annotations into torch

```bash
luarocks install dkjson
```

Place instances_train-val2014.zip in the same folder. You can download it from http://mscoco.org/dataset/#download

Then run the following commands:

```bash
unzip instances_train-val2014.zip
th load.lua    
th load.lua ### yes, run it twice.
```