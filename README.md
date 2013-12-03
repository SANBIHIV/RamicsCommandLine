Installation
=

These scripts require ruby and the `rest-client` and `json` gems.

Run `bundle install` in this directory to install the required gems.

Usage
=

login.rb
==

This script obtains an api key for your account and prints it to the standard output.

Run `ruby login.rb <email> <password>`.

seq2res.rb
==

This script runs Seq2Res on files stored on your computer. For files which are already online, this is not the most efficient approach.

First login by running `login.rb` which will print out your api key.

Then create a job by running `ruby seq2res.rb <api key> sequence.fastq MIDlist.txt primers.txt "{\"keyseqlen\":\"4\",\"trim\":\"m=20,l=50,mode=2\",\"analysis_type\":\"0\",\"mt\":\"2\",\"pt\":\"4\",\"cutoff\":\"15\"}"`

The order of the arguments is: api key, fastq file, mid file, primer file, name, parameters

An example of the parameters is in parameters.txt

get_reports.rb
==

This script prints out drug resistance reports for a specified job ID. This is the job ID printed by seq2res.rb. 

Run `ruby get_reports.rb <api key> <job id> <mids>`.

Where `mids` is an optional argument and may be 1 or MID's that you wish to print tables for. By default, all MID's are printed.

The tables are printed to two files named `<job_name>_<mid>_consensus-like.txt` and `<job_name>_<mid>_ultra-deep.txt`.
