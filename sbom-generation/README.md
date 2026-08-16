# SBOM Generation

SBOM (Software Bill Of Materials) is a a file that reference every componants, open source libraries, tiers modules and dependencies that compose an application and their relations between them.

For this lab, I will use the `syft` tool

## Local SBOM generation

In order to generate a fast and easy to access SBOM, we can install for exemple `syft` on our own device with `brew install syft`.\
Then, we can generate a SBOM with `syft 'path to package.json file'` then we can add multiple args :

- `-o table` to generate a human readable table of the components.
- `-o cyclonedx-json='target for the SBOM'` to generate a cycloneDX JSON format SBOM and store it in target directory

The output is a massive SBOM (we can configure the output format with the second `syft` parameter)
