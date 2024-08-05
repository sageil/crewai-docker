# About
Contains the required tools to create a multi-artchitecture docker image containing [crewAI](https://www.crewai.com/) dependencies and the crewAI tool itself, as well as some other useful tools for Ai tasks.

Using this image will create a container using the `e P="my_crew"` will create and confgure a project named `my_crew` in the directory the command is executed, and will install all dependencies for crewAI.

The prebuilt docker images can be found on [Docker Hub](https://hub.docker.com/r/sageil/crewai/tags)

Building from source:
1. Clone the repository
2. Navigate to the repository directory
3. Run the following command to build the docker image 

```bash
docker buildx build --platform linux/amd64,linux/arm64 --build-arg RELEASE_DATE="$(date +'%Y-%m-%d')" --build-arg CREWAI="0.41.1" --build-arg TOOLS="0.4.26" -t sageil/crewai:latest ./

```

`CREWAI` and `TOOLS` are the versions of crewai and tools respectively, which can be found on [crewai](https://github.com/crewAIInc/crewAI) and [tools](https://github.com/crewAIInc/crewAI-tools)

### Using the publicly available image from docker hub
***these steps assume the project being created is named `my_crew`***
1. Navigate to where you want the crewAI project to be created
2. Use the prebuilt images on dockerhub to create a crewAI project with the name `my_crew`: 
```bash
docker container run -e P="my_crew" --network host --name crew -it --rm -v $(pwd):/app sageil/crewai:latest bash
```
3. Run `poetry lock && poetry install` in the opened container shell

### Editing the project source code

***NOTE*** The `OPENAI_API_KEY` is required to run crewai because it defaults to OpenAI models but if you plan to run your crew locally, any random string will work.

1. Open your project in VSCode: `code .` or any other IDE of choice.
2. Modify the .env file to include your open api key `OPENAI_API_KEY=YOURKEY`. 
3. Edit files in VSCode and save them, they will be reflected inside the container as long as you have mounted the current directory to it.
4. From the running container, execute `poetry run my_crew` to run your project.

### Using local LLM
1. Add the following to top of crew.py
``` python
from langchain_openai import ChatOpenAI
llm=ChatOpenAI(
	model="mistral:latest", # Replace with your model
	base_url="http://host.docker.internal:11434/v1" # your local LLM host URL. in this snippet, both LLM and containers are running on docker using the -network host
)
```

### Autocomplete for crewAI commands
To get autocomplete working for `poetry` in bash, type poetry followed by `tab`