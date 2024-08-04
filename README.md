# About
Repo to create a docker image to use to create crewAI agents using [crewAI](https://www.crewai.com/)
Building the docker image:
```bash
docker image build --build-arg RELEASE_DATE="$(date +'%Y-%m-%d')" --build-arg CREWAI="0.41.1" --build-arg TOOLS="0.4.26" -t sageil/crewai .
```
`CREWAI` and `TOOLS` are the versions of crewai and tools respectively, which can be found on [crewai](https://github.com/crewAIInc/crewAI) and [tools](https://github.com/crewAIInc/crewAI-tools)

### Using the publicly available image from docker hub
1. Navigate to where you want the crewAI project to be created
2. Use the prebuilt images on dockerhub to create a crewAI project with the name `my_crew`: `docker container run -e P="my_crew" --name crew -it --rm -v $(pwd):/app sageil/crewai:1.0.0 bash` 
3. Once the container running, you can use the following commands to interact with your crew by running `poetry install` then `poetry run my_crew` where `my_crew` is the crewAI project name.
4. Open your project in VSCode: `code .` or any other IDE of choice.
5. Edit files in VSCode and save them, they will be reflected inside the container as long as you have mounted the current directory to it.
6. Execute `poetry run my_crew` to run your project from the container terminal.

### Autocomplete for crewAI commands
To get autocomplete working for `poetry` in bash, type poetry followed by `tab`