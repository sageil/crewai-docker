docker image build --build-arg RELEASE_DATE="$(date +'%Y-%m-%d')" --build-arg CREWAI="0.41.1" --build-arg TOOLS="0.4.26" -t sageil/crewai .
