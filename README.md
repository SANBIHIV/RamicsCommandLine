Installation
=

These scripts require ruby and the `rest-client` and `json` gems.

Run `bundle install` in this directory to install the required gems.

Usage
=

ramics.rb
==

Run this script by calling `ruby ramics.rb <name> <sample file> <reference file> <parameters>`. The name given to the job is for your own convenience when recognising the results later. The sample file contains the sequence(s) to be aligned. The reference file is the sequence against which the sample is aligned. And the parameters are a JSON formatted string of options to RAMICS. The JSON object has keys of the parameters names with corresponding values. For flag parameters, the value should be true. All parameters should be specified with one less leading `-` than would be used as a command line option.

For all available options, see the man page included in this repository -- `man ./ramics.8`.
 
At least one output type must be specified as a parameter. The options are:

- `-print-mutations`
- `-print-codons`
- `-print-cleaned`
- `-print-global`
- `-print-pairs`
- `-print-sam`

For example, to get RAMICS to produce a global alignment and to output in Sam format, the parameters would be: `"{\"-print-global\":\"true\",\"-print-sam\":\"true\"}"`

Once the job has be uploaded and added to the queue for processing, a job ID is printed to STDOUT. This ID is used to retrieve the results for that job.

Results
=

The results for a RAMICS job can be viewed online by visiting `http://hiv.sanbi.ac.za/tools/#/ramics/jobs/<job ID>`.

To download a results record in JSON format, send a GET request to `https://hiv-tools-api.sanbi.ac.za/v2/jobs/<job ID>/results`. If the job has not finished running, the response will be an empty array named `job_results` otherwise the array will contain a single object with links to each of the available output files.
