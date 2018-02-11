Puppet 4 : Language Essentials

Define configuration needs as resources
Set the correct service names
Restarting service

by end of course, we will be able to create manifest to define configuration needs

Prerequisites :
LFCS : Linux Essentials by Andrew Mallett
LFCS : Linux Service Management by Andrew Mallett


2.1 Configuration Mgmt and Puppet
---------------------------------
Lab env
course content

Lab env : 
centos 7 : 192.168.56.15
ubuntu14 : 192.168.56.16

1. Struggling to maintain an ever growing server farm.
2. Feelign overwhelmed with the number of distributions to support
3. You need to become the Puppet master
4. Puppet can simplify configuration changes and help you meet compliance goals

First in a Series on Puppet 4 and Puppet Enterprise : This course is the first of a series of courses where we help you to learn the new skills that are needed with puppet 4 and puppet enterprise. The leading software in configuration mgmt

1. Language essentials
2. working with modules and classes
3. working with files and templates
4. Hiera the single source of truth
5. Server and Puppet Enterprise

1. Language essentials
- a. Installing Puppet 4
- b. Puppet apply
- c. Understanding Resources
- d. Exposing the Language
- e. Resource Relationships
- f. Testing and Validation

PUppet language and "idempotency"

2.2 The same power of idempotency :

#Create user id :
sudo useradd -m -u 1001 bob

#simple idempotent operation:
echo "Hello" > file1
echo "Hello" > file1
echo "Hello" > file1

cat file1

#non idenpotent
echo "Hello" >> file1
echo "Hello" >> file1
echo "Hello" >> file1

cat file1

2.3 Summary and What's Next
--------------------------

Puppet 4 courses
Lab Environment

3.1 Installaing the Puppet Client
---------------------------------
-who are Puppetlabs
-creat puppetlabs repos
Install Puppet AIO client
locate important Puppet Files and Directories
Running Puppet with and without sudo

#Puppetlabs
1. Puppet created in 2005 by Luke Kanies
2. First commercial release in 2011
3. Support for Linux, Unix and Windows
4. Opensource V4.5 and Puppet Enterprise 2016-1

# Create Repos for Puppet Labs : Most distributions still ship Puppet 3 in their internal repositories. To be able to amake use of the latest puppet 4 code then we must first setup software repositories pointing to Puppetlabs

Package Collection Repository CentOS: Puppet-Collections are new to Puppet 4 and ensure that all dependency packages such as heira, facter and ruby come from the same repository ensure most compatibility with the client

sudo rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

#Package collection repository ubuntu : The process for ubuntu is similar. Here we use the code name of "trusty" for the 14.04 repository

wget http://apt.puppetlabs.com/puppet-release-trusty.deb
sudo dpkg -i puppetlabs-relase-pc1-trusty.deb
sudo apt-get update

Adding repositories:
#In Centos

id (user belongs wheel group then we should be use sudo command)

sudo yum install -y https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

yum repolist - see repos list

3.3 Configuration the Ubuntu Puppet repository
----------------------------------------------
#in ubuntu

wget http://apt.puppetlabs.com/puppet-release-trusty.deb
sudo dpkg -i puppetlabs-relase-pc1-trusty.deb
sudo apt-get update

#before installing agent - we need to install ntp to make sure server is sync in all machines

3.4 Installing the Puppet Agent 
-------------------------------
Installing the Client : On both the Ubuntu and CentOS systems we can now install the All in One Client. To ensure that the package will not clash with the standard repositories to package name is puppet-agent.

#In CentOS
sudo yum install puppet-agent 

ls -l /opt/puppetlabs/bin

#In Ubuntu
sudo apt-get install puppet-agent

3.5 Understanding the File Locations:
-------------------------------------
Binary Locations

A subset of executables are available in : /opt/puppetlabs/bin. This is added to the PATH variable
Other executables are in /opt/puppetlabs/puppet/bin. This is not in the PATH and makes it less likely these programswill be used in error.

Main configuration:
The main configuration directory is: /etc/puppetlabs/puppet. The main configuration files is puppet.conf
This makes Puppet Open Source now consistent with Puppet Enterprise.

#Display Data
Puppet Agent --version

Puppet config print

puppet config print confdir

puppet config print certname

puppet config print { confdir rundir ssldir runinterval }

3.6 Locating Configuration in Puppet
------------------------------------
ls -l /opt/puppetlabs/bin/

cd /opt/puppetlabs/puppet/bin

#adding file location in PATH statement
cat /etc/profile.d/puppet-agent-sh

Copy 
export PATH=$PATH:/opt/puppetlabs/bin

and pasted in command prompt

puppet --version

#login with root user
su -

puppet config print
puppet config print confdir
puppet config print vardir
puppet config print { confdir rundir ssldir runintenval }

3.7 Gaining Administrative Rights
---------------------------------
sudo, su or not

Plain User : Different configuraiton path
su : Need to know the root password
sudo: Need to update the secure_path

#Investigating Privileges
-------------------------
puppet config print { confdir ssldir vardir }

puppet resource user bob

su -
passwd

puppet resource user bob

#Secure path
sudo visudo

search for secure_path
:/secure_path (presee Upper case A : Append the end of the line) :/opt/puppetlabs/bin

sudo puppet resource user fred

sudo puppet resource user fred --edit

user { 'fred':
  ensure => 'present',
  managehome => true,
  uid => '2001',
 }
 
sudo puppet resource user fred

#3.8 Summary
------------
*History behind the puppetlabs
*Puppet 4 uses Puppet Collections
*Puppet-Agent
*PATH: /opt/puppetlabs/bin
*Collections: /opt/puppetlabs/puppet/bin
*sudo: secure_path

Next Module : Working with Puppet Apply and Manifests

4.1 Working with Puppet Apply and Manifests
-------------------------------------------
Objectives :
 - What are Puppet Manifests
 - Using Puppet Apply
 - Ensure Puppet Agent is stopped and disabled
 - Puppet Style guide
 - Syntax highlighting and styling in vim

Puppet Manifests : 
 - Text files with .pp suffix
 - Contain puppet code
 - puppet server and agent architecture - site.pp
 - puppet modules - init.pp
 
Hellow World : The notify resource type can be used to send a message to the agent log or screen if being used interactively. This makes a great and simple.

notify { 'Hellow World': }

validate the Manifest : Although this manifest is very simple we should get in the habit of validating code as we create it. Helping to keep our code robust and healthy.

sudo puppet parser validate helloworld.pp

Creating a Manifest file.















