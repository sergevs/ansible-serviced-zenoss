# Zenoss Deployment Tool
Ansible playbook to deploy docker, [serviced](https://github.com/control-center/serviced) and [zenoss monitoring system](https://www.zenoss.com)

# Overview
The primary purpose of the playbook is to deploy Zenoss Core to your own bare bone server or a virtual host:
* deploy docker with lvm storage thin pool 
* deploy serviced according to [requirements](https://www.zenoss.com/services-support/documentation/cc-install-guide) optionally deploy a serviced cluster, which in the turn can be used to implement zenoss distributed monitoring
* deploy and run Zenoss Core

# Key features
* Support Zenoss deployments to Debian and Ubuntu operation systems.
* Fully automated deployments 
* Cloud ready: one click [Google Cloud Engine deployment](README.md#google-cloud-deployment)

# Quick start
Install Ansible. Put your host to the [hosts](hosts) and configure **lvm_dev** variable. Proceed to Usage section :)

# Configuration
The configuration options are documented at [group_vars](group_vars) files. You can amend variables there or override it [site_vars.yml](site_vars.yml)

## Host variables:
* **lvm_dev**   : block device for lvm and docker thin pool. the value of global variable will be used if not set.
* **pool_name** : name of serviced pool to assign host to. the **default** pool is used if not set.

## Tags:
* **prepare**  : prepare environment
* **docker**   : deploy docker
* **serviced** : deploy serviced
* **zenoss**   : deploy zenoss

# Usage
After required configuration prepared you can use [setup](setup) script to start deployment.
```
  ./setup
```

# Requirements
At least one spare partition(>= 30 Gb) must be available and configured(**lvm_dev**) for docker and zenoss storage pools.
4 Gb RAM to run serviced services or 24 Gb to run zenoss

Supported OS: 
* Redhat / CentOS 7
* Debian Stretch
* Ubuntu Xenial, Bionic

[ansible](https://www.ansible.com): >= 2.3.0

# Google Cloud Deployment
The playbook tested for serviced 1.5.0 and zenoss 6.1.2. Google cloud host is used for deployment as a reproducible clean environment.
You have to setup [Terraform](https://www.terraform.io) than [zenoss.tf](zenoss.tf) will be used to create GCE instance.

Run [gce_deploy](gce_deploy) script for full cycle deployment to google cloud:
```
  ./gce_deploy <your google cloud ssh key username> [ terraform options ]
``` 

# Further development
There are many features planned. Please visit [Project support page](https://serge.ocslab.com) if you like to appreciate the work.
