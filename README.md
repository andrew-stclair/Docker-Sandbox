# github-runner
Docker actions template for github

# GitHub Secrets
| Secret              | Description                           |
| :------------------ | :------------------------------------ |
| `DOCKER_USERNAME`   | your username for docker hub          |
| `DOCKER_PASSWORD`   | your auth token for docker hub        |
| `DOCKER_REPOSITORY` | the container tag for your repository |

Notes:

* the auth id for docker can be created in your account settings
* the repository format is `username/container`