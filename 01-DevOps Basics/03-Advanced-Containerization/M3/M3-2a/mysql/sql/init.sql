CREATE DATABASE docker_info;

USE docker_info;

CREATE TABLE docker_commands 
(
    command_id int,
    command_category varchar(100), 
    command_name varchar(100),
    command_description varchar(255)
);

INSERT INTO docker_commands VALUES (1, 'container', 'attach [OPTIONS] CONTAINER', 'Attach to a running container');
INSERT INTO docker_commands VALUES (2, 'container', 'exec [OPTIONS] CONTAINER COMMAND [ARG...]', 'Run a command in a running container');
INSERT INTO docker_commands VALUES (3, 'container', 'ls [OPTIONS]', 'List containers');
INSERT INTO docker_commands VALUES (4, 'container', 'prune [OPTIONS]', 'Remove all stopped containers');
INSERT INTO docker_commands VALUES (5, 'container', 'rm [OPTIONS] CONTAINER [CONTAINER...]', 'Remove one or more containers');
INSERT INTO docker_commands VALUES (6, 'container', 'run [OPTIONS] IMAGE [COMMAND] [ARG...]', 'Run a command in a new container');
INSERT INTO docker_commands VALUES (7, 'container', 'start [OPTIONS] CONTAINER [CONTAINER...]', 'Start one or more stopped containers');
INSERT INTO docker_commands VALUES (8, 'container', 'stop [OPTIONS] CONTAINER [CONTAINER...]', 'Stop one or more running containers');

CREATE TABLE docker_examples 
(
    example_id int,
    command_id int,
    example_code varchar(255),
    example_description varchar(255)
);

INSERT INTO docker_examples VALUES (1, 1, 'attach con101', 'Attach to a runninng container con101.');
INSERT INTO docker_examples VALUES (2, 2, 'exec -it con101 /bin/bash', 'Create and interactive session to container con101 and execute /bin/bash.');
INSERT INTO docker_examples VALUES (3, 3, 'ls -a', 'Show all containers including the stopped ones.');
INSERT INTO docker_examples VALUES (4, 3, 'ls -a -q', 'Show IDs of all containers including the stopped ones.');
INSERT INTO docker_examples VALUES (5, 4, 'prune -f', 'Remove all stopped containers without confiramtion');
INSERT INTO docker_examples VALUES (6, 5, 'rm -f -v con101', 'Force the removal of running container con101 and its volumes.');
INSERT INTO docker_examples VALUES (7, 6, 'run -it --name con101 ubuntu /bin/bash', 'Run new container named con101 based on the ubuntu image and executes /bin/bash in it.');
INSERT INTO docker_examples VALUES (8, 6, 'run -d --name con101 -p 8080:80 nginx', 'Run new container named con101 based on the nginx image and redirects internal port 80 to external port 8080.');
INSERT INTO docker_examples VALUES (9, 7, 'start -a -i con101', 'Start stopped containter con101 and attaches its STDIN, STDOUT and STDERR.');
INSERT INTO docker_examples VALUES (10, 8, 'stop con101 con102', 'Stop containers con101 and con102.');
