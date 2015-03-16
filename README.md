# The Doctor
================

## Getting Started

Run `vagrant up` to initially provision the virtual machine (Vagrant version 1.5.0+ required)

Once the provisioning is complete, ssh into the VM: `vagrant ssh`

Change directory into `/the-doctor` and run `sh bootstrap.sh`.  This part will take a while.


```
$ sudo su - postgres

$ createuser -P -s -e vagrant
Enter password for new role: password
Enter it again: password

$ exit
```


#### Edit pg_hba.conf to use md5 authentication:

```
$ cd /etc/postgresql/9.3/main
$ sudo nano pg_hba.conf

# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     md5 <--- initially set to "peer"
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
# Allow replication connections from localhost, by a user with the
# replication privilege.
#local   replication     postgres                                peer
#host    replication     postgres        127.0.0.1/32            md5
#host    replication     postgres        ::1/128                 md5


$ cd /vagrant
$ sudo service postgresql restart


```


## git workflow

`git remote add upstream git@github.com:PendragonDevelopment/the-doctor.git`

Checkout your local master branch:

`C/sites/the-doctor (master) $ git pull upstream master`

`git checkout my-feature-branch`

`git rebase master`

`git push origin my-feature-branch`

Open a pull request on Github.



