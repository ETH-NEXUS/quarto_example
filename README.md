# Example workflow 

The workflow includes a single step rendering the quarto report. The scripts and a test input file are available on Leomed2 in our project directory in the following subdirectory `reproducible_reporting/quarto_example`


### Execution

```
conda activate <path to the sharedutils folder on customapps>/snakemake_v7.12.1

snakemake --use-singularity --singularity-args "--bind <working directory> --bind /scratch --cleanenv" --cluster "sbatch --ntasks=1 --mem={resources.mem_mb} --cpus-per-task={threads} --time={resources.hours}:00:00" --printshellcmds --latency-wait 60 --jobs 1 --configfile config/config.yaml
```

### What you could try
* Create a copy of the directory and try to run the snakemake pipeline
* Try to make changes to the report, e.g. fix plots (in my test run, Fig. 2 looked messed up), improve narrative, add plots, add Nexus logo etc. 
* Make a modified copy of the input file (or ask ChatGPT to do it) for a second "hospital". Add this second data provider to the list of providers in `config/config.yml` and try to rerun the pipeline. It should now produce two reports.







