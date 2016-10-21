# Wordcloud Generator

## Creating a Docker Image

- Clone this [repo](https://github.com/initcron-devops/automation.git)

- `cd automation/design/wordcloud`

- `docker build -t ubutnu/wordcloud .`

## Creating a wordcloud image

- Once the image is build successfully, launch the docker container with mounting the current directory as a volume.

- `docker  run -it  -v /automation/:/tmp/ ubutnu/wordcloud /bin/bash`

- Inside the container `cd /tmp` and create a image as per the **generateWordCloud2.py** and **wordFreqFile**

- Run the following command inside the directory where the generateWordCloud2.py and wordFreqFile is present.

- *USAGE: python generateWordCloud.py <wordFreqFile> <outImageFile>*

- `python generateWordCloud.py wordFreqFile xyz.png`
