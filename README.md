**Homework Assignment: Dockerfile for PostgreSQL Database**

### Objective

In this assignment, you will write a Dockerfile to create a PostgreSQL database container. You will use various Dockerfile commands to configure the image, and then you will run the container to ensure it works as expected.

### Part 1: Writing the Dockerfile

You will create a Dockerfile that builds an image for running a PostgreSQL database. The following Dockerfile statements should be used:

1. **FROM**: Use the official PostgreSQL image as the base image.
2. **COPY**: Copy an initialization SQL script into the container. The script should contain SQL commands that will set up a sample database when the container is started. (Note: You can use a script named `init.sql`, which I can supply if needed.)
3. **VOLUME**: Define a volume to ensure that your database data persists beyond the container's lifecycle.
4. **EXPOSE**: Expose the default PostgreSQL port to allow external connections.
5. **CMD**: Set the default command to start PostgreSQL when the container is run.
6. **RUN**: Run commands during the image build to prepare your environment or set specific configurations.

#### Requirements

- Create a Dockerfile named `Dockerfile`.
- Use **bitnami/postgresql:15** as your base image.
- Refer to the official documentation for the Bitnami PostgreSQL image at [https://hub.docker.com/r/bitnami/postgresql](https://hub.docker.com/r/bitnami/postgresql). This documentation will help you understand how to use Docker volume to mount the PostgreSQL data in a volume, specifically in the section called "Persisting your database." This will be particularly useful during Part 2.
- Use a custom SQL script (`init.sql`) to set up a database. This script should be copied into the container at `/docker-entrypoint-initdb.d/`. This directory is automatically used by PostgreSQL for running initialization scripts on first run. The database should contain at least one table with some sample data.
- Define a **VOLUME** to store PostgreSQL data as explained in the official documentation.
- **EXPOSE** port `5432` (the default PostgreSQL port).
- Use **CMD** to specify the default command for starting PostgreSQL and add an **ENTRYPOINT** statement:
  - The `ENTRYPOINT` should call the `/opt/bitnami/scripts/postgresql/entrypoint.sh` script.
  - The `CMD` statement should call the `/opt/bitnami/scripts/postgresql/run.sh` script.
- Set environment variables in the Dockerfile to configure logging and connection settings: `POSTGRESQL_LOG_CONNECTIONS`, `POSTGRESQL_LOG_DISCONNECTIONS`, and `POSTGRESQL_MAX_CONNECTIONS`. Make sure these are properly set to ensure proper logging and manage the number of concurrent connections:
  - `POSTGRESQL_LOG_CONNECTIONS` should be set to true.
  - `POSTGRESQL_LOG_DISCONNECTIONS` should be set to true.
  - `POSTGRESQL_MAX_CONNECTIONS` should be set to 5. Make sure these are properly set to ensure proper logging and manage the number of concurrent connections. You can find further information on these environment variables on the official documentation for the Bitnami PostgreSQL image listed above.
- Look at the documentation at [https://hub.docker.com/r/bitnami/postgresql](https://hub.docker.com/r/bitnami/postgresql) for details on the environment variables listed. You'll need to use one of these environment variables to set a password for the created user, this will allow you to connect to the postgres database later in Part 2 so you can get your last Deliverable screenshot.

#### Example Structure of `init.sql`

Your `init.sql` script should look something like this:

```sql
CREATE DATABASE sampledb;
\c sampledb;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(50)
);

INSERT INTO users (name, email) VALUES ('Alice', 'alice@example.com'), ('Bob', 'bob@example.com');
```

### Part 2: Building and Running the Container

1. **Build the Docker Image**

   - From the directory where your Dockerfile is located, run the following command to build the image:
     ```sh
     docker build -t postgres-homework .
     ```

2. **Run the Container**

   - Run a container using the image you built. Make sure to:
     - Publish the appropriate ports to allow external access to PostgreSQL.
     - Run the container in the background (`-d` flag).
     - Mount a volume to ensure that your PostgreSQL data persists between container restarts. Make sure to specify a named volume to avoid confusion about how to implement persistence. For example, you can use `-v pgdata:/bitnami/postgresql` to specify a named volume.

3. **Confirm the Setup**

   - Connect to the running container using a PostgreSQL client (e.g., `psql` or a GUI client like DBeaver).
   - Verify that the `sampledb` database exists and that the `users` table contains the inserted sample data.
   - You can also connect using `docker exec` to run `psql` inside the container:
     ```sh
     docker exec -it postgres-container psql -U postgres -d sampledb
     ```
   - Run the command `SELECT * FROM users;` to verify the table and data.
   - **Optional**: You're welcome to also use VSCode extension to connect to the postgres instance
        - You can refer to [these docs](./docs_on_vscode_extension.md) for how to use the extension if you'd like to, but you're not obligated to do so

### Deliverables

- Screenshots of the terminal output showing:
  - [35pts] The Dockerfile used.
  - [20pts] The Docker image being built, including the command you ran.
  - [20pts] The Docker container being started, including the command you ran.
  - [12pts] The logs showing that PostgreSQL is running without errors.
  - [13pts] The output of `SELECT * FROM users;` confirming that the database is running and contains the sample data.

### Bonus
- [Research, 10pts] Do some research on how to pass secrets to containers and identify a more secure way of passing secrets to containers.
  - [5pts] Type up your suggestions, explaining in your own words to the best of your understanding. Quality over quantity is important.
  - [5pts] Implement a secure password solution and provide a screenshot demonstrating it.

**Good luck, and happy containerizing!**

