# Note: All paths need to be either absolute or relative to the location of the qmd file, which is the execution environment
# The script is copied to a job-specific working directory to avoid conflicts between parallel jobs
rule clean_data_report:
    input:
        "data/global_summary.csv"
    output:
        "cleaning_reports/{provider}/cleaning_report.html"
    log:
        "logs/{provider}_clean_data_report.log"
    threads:
        config["computingResources"]["threads"]["low"]
    resources:
        mem_mb=config["computingResources"]["mem_mb"]["low"],
        hours=config["computingResources"]["hours"]["low"]
    container:
        "singularity_cache/R_v4.3.3_quarto_v1.3.sif"
    shell:
        '''
        mkdir -p {wildcards.provider}.temp
        cp workflow/scripts/cleaning_report.qmd {wildcards.provider}.temp/
        cd {wildcards.provider}.temp/
        DIRNAME=$(dirname "{output}")
        quarto render ./cleaning_report.qmd --output-dir ../"$DIRNAME" -P input:../{input} -P provider:{wildcards.provider} 2> ../{log}
        cd ..
        rm -rf {wildcards.provider}.temp
        '''
