FROM python:3.11-slim-bookworm
ARG RELEASE_DATE
ARG CREWAI
ARG TOOLS
ENV P=value
LABEL crewai.version=${CREWAI}
LABEL crewai-tools.version=${TOOLS}
LABEL maintainedby="Sammy Ageil"
LABEL release-date=${RELEASE_DATE}


RUN apt-get update -y && apt-get install curl=7.88.1-10+deb12u6 vim=2:9.0.1378-2 \ 
  bash-completion=1:2.11-6 -y --no-install-recommends \ 
  && rm -rf /var/lib/apt/lists/* && \
  groupadd appgroup && useradd -m -s /bin/bash -G appgroup appuser
COPY entrypoint.sh /entrypoint.sh
COPY shell_venv.sh  /shell_venv.sh
RUN chmod +x /entrypoint.sh
USER appuser
ENV PATH="/home/appuser/.local/bin:$PATH"
RUN mkdir -p "$HOME/.local"
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
WORKDIR /app/
RUN chown appuser:appgroup "/app/"
RUN curl -sSL https://install.python-poetry.org | python3 - && poetry config virtualenvs.in-project true && \ 
  pip install crewai==${CREWAI} crewai-tools==${TOOLS} --no-cache-dir && \
  poetry completions bash >> ~/.bash_completion && echo "source /shell_venv.sh" >> ~/.bashrc
ENTRYPOINT [ "/entrypoint.sh" ]

