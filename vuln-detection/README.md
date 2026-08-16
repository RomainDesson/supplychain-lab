# Vulnerabilities detection

**Vulnerabilities detection** (or scanning) is the process of identifying known security vulnerabilities in software package and dependencies.

I will use the `grype` tool for this lab.

## How does grype work

`grype` is a tool used to scan multiple targets like SBOM and containers images.\
It can be used either in combination with a SBOM generator tool or even as a standalone tool (it can handle the internal SBOM generation by himself but **will not output it**)\
When we start a scan, here is what happens : 
- First, grype will check if we have any already cached vulnerability db in `~/Library/Caches/grype/db/<SCHEMA-VERSION>/vulnerability.db`.\
If one cache file is presents, grype will check with the remote vulnerabilities source if your source is fresh enough. If yes, it will use it as reference for the scan.\
If there is no cache folder or the data are flagged as obsoletes, it will pull the latest data from the source (comming from `vunnel` aggregation) and rebuild a new database, overwriting the last one if existing.
- Then if you passed a SBOM file as argument, it will compare it to the vulnerable versions in its database.\
If you don't passed a SBOM file, it will first generate one with the `syft` tool and make the same analyzing.

## Local usage

For local usage, we can also use the `grype` tool directly in command line with, for SBOM scanning : `grype ./path-to-sbom`.
It will output a formated table of reported vulnerabilities : 
```
NAME        INSTALLED  FIXED IN  TYPE  VULNERABILITY        SEVERITY  EPSS          RISK
next        15.3.8     15.5.16   npm   GHSA-c4j6-fc7j-m34r  High      38.9% (98th)  31.3
lodash      4.17.21    4.18.0    npm   GHSA-r5fr-rjxr-66jc  High      2.6% (83rd)   2.0
next        15.3.8     15.4.7    npm   GHSA-4342-x723-ch2f  Medium    2.5% (83rd)   1.4
```

In this table, we can have quick informations about the name of the vulnerable dependencies, the patch version GHSA ID and Severity.\
It gives a good overview of our total production vulnerabilities.

> Compared to the `npm audit` command for exemple, using a SBOM instead of the whole package.lock.json file for the audit help us know exactly what is shipped to the clients with our application.
> `npm audit`, even if we sort out dev dependencies, it will audit befors tree shaking and also audit node only packages 

We are also able to generate json output for vulnerabilities scanning to use it in other softwares for example.\
We can do so with `grype ./path-to-sbom -o json` here, it will output the json file in the command line. We can output it directly in a file, like with syft with `grype ./path-to-sbom -o json=./vuln-report`, then, we read and store it with `jq . ./vuln-report.json > vuln.json ` to put it in a vuln.json file.\
> In one line, it is : `grype ./path-to-sbom -o json | jq . > vuln-report.json`

