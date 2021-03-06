## About The Project

Environmentconf is a python based tool to configure remote environments. Remote environments can be remote virtual machines or Docker containers.

### Built With

* [python](https://www.python.org/download/releases/3.0/)

## Getting Started

To run the tool on your machine please follow these steps-
1. Make sure you have Python 3.6 or higher installed on your machine
2. Install `environmentconf` using pip. e.g. `pip3 install environmentconf`
3. Once tool is installed you are ready to use it. e.g. `python3 -m environmentconf.envconf_manager --apply config_path=<valid absolute path which contains configs>`

OR 

If you are running Ubuntu based system then use the `bootstrap.sh` which is at the root of the project to perform all the steps mentioned above.

### Prerequisites

Tool requires `Python 3.6` or higher and `pip` to install tool.
* Install
  ```sh
  apt-get install -y python3-pip
  ```

### Installation

1. Pip install
   ```sh
   pip3 install environmentconf
   ```

<!-- USAGE EXAMPLES -->
## Usage
Tool needs two configuration files 

1. Create a directory where we will put all the configs.
2. Create file named [environments.yaml](https://github.com/maulik887/environmentconf/blob/main/environmentconf/resources/environments.yaml). This specifies all the environments which needs to be configured.

```
---
group1: #group of machines
  environments:
  - ip: 1.2.3.4
    connection_type: ssh
    tags:
      - region: us-east-1
      - account_id: 123
  - ip: 1.2.3.5
    connection_type: ssh
    tags:
      - region: us-east-1
      - account_id: 123
group2: #grop of docker containers(unit testing or if remote env is composed of docker)
  environments:
  - id: e6d3a73ff6c2 #id of the docker container
    connection_type: docker
```
3. Create file named [configurations.yaml](https://github.com/maulik887/environmentconf/blob/main/environmentconf/resources/configurations.yaml). This specifies set of configurations we need to perform on target environments. For example, if we want to configure remote environment to host php using Apache web server then this is how we compose the configuration file.

Note that `hosts` property targets the group defined in `environments.yaml`. You can have multiple environments in `environments.yaml` file for which you can run different set of actions specificed in `configurations.yaml`.

```
---
- hosts: group1
  actions:
  - name: install_apache2
    executor: package
    action: install
    args:
      name: apache2
  - name: install_libapache2-mod-php
    executor: package
    action: install
    args:
      name: libapache2-mod-php
  - name: copy_index_php
    executor: artifact
    action: copy
    args:
      source: /Users/someuser/code/index.php
      destination: /var/www/html/
  - name: delete_index_html
    executor: artifact
    action: delete
    args:
      destination: /var/www/html/index.html
  - name: Start the apache2 server
    executor: process
    action: start
    args:
      name: apache2
      subscribe:
        - install_apache2
```
4. Now, we are all set to configure the remote environment (considering tool is already installed on machine). Grab the absolute path of the directory which contains the above `yaml` files. Run `environmentconf` using this command-

```
python3 -m environmentconf.envconf_manager --apply config_path=<valid absolute path which contains configs>
```

We can also use docker to test the tool.
  * Make sure you have Docker installed on your machine.
  * `docker pull ubuntu:18.04`
  * `docker run -it ubuntu:18.04 bash`
  * Copy/Create `bootstrap.sh` file in docker container and then run it.
  * You are all set! Go run 
```
python3 -m environmentconf.envconf_manager --apply config_path=<valid absolute path which contains configs>
```


<!-- Tool's Architecture -->
## Architecture

Read more about tool's architecture [here](https://github.com/maulik887/environmentconf/blob/main/architecture/README.md)

<!-- LICENSE -->
## License

Distributed under the MIT License.

<!-- CONTACT -->
## Contact

[Maulik Patel](http://maulik.me)

Project Link: [https://github.com/maulik887/environmentconf](https://github.com/maulik887/environmentconf)