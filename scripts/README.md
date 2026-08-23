# Scripts

## sbom-analyze.sh
This is the first script I started to work with.\
This is also my first hand written bash script and I never touched this before.

### Bash
This language is pretty simple and straight forward, I was able to make a little script, actually, really easy to just generate then analyze a sbom.

### The script
The script is really simple for now.\
The goal is only to automate the `syft` sbom generation then the analyze with `grype`.
In fact, it's so simple that it is useless as `grype` can already do it by his own alone.\
The only thing that this script do is being able to also output the SBOM as a standalone file if needed, where grype isn't able to do so by himself.

The goal was more to challenge myself to create the script than make it usefull.

So, it will take 2 params :
- The first one is the target that we want to scan, it can be anything that `syft` can scan in fact.
- The second one is the target folder where we want to create the report.

The script will first call `syft` and store the result as a cycloneDX json file in a temporary file.\
Then, we simply use `grype` that will take in params the previously generated file to analyze it and output the result either in the terminal directly if no target folder has been set or in a json file.

