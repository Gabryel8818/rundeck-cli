# Rundeck CLI docker action

This action create jobs in rundeck api with rundeck cli

## Envs
```
RD_TOKEN: YOUR-RD-TOKEN
FILE: YOUR-JOB-FILE
PROJECT: YOUR-RUNDECK-PROJECT
RD_URL: YOUR-RUNDECK-PROJECT
```
## Example usage

### Example with specific file
```
uses: Gabryel8818/rundeck-cli@v1
env:
  RD_TOKEN: TOKEN
  FILE: testes.yaml 
  PROJECT: project
  RD_URL: http://localhost:4440
```
### Example with file in directory
```
uses: Gabryel8818/rundeck-cli@v1
env:
  RD_TOKEN: TOKEN
  FILE: testes.yaml 
  PROJECT: project
  RD_URL: http://localhost:4440
```
### Example with multiple files
```
jobs:
  filesChanged:
    runs-on: ubuntu
    steps:
      - id: file_changes
        uses: trilom/file-changes-action@1.2.4

      - name: Get files
        id: files
        run: |
          content=$(jq ".[]" $HOME/files.json | grep "infra" | jq -R -s -c 'split("\n")[:-1]' )
          echo "::set-output name=files::$content"
          echo $content
    outputs:
      files: ${{ steps.files.outputs.files }}

  create_job:
    runs-on: ubuntu
    needs: [filesChanged]
    strategy:
      fail-fast: false
      matrix:
        file: ${{ fromJson(needs.filesChanged.outputs.files) }}
    steps:
      - name: Checkout
        uses: actions/checkout@v3
        
      - name: create a job
        uses: Gabryel8818/rundeck-cli@v1
        env:
          RD_TOKEN: TOKEN
          FILE: ${{ matrix.file }} 
          PROJECT: project
          RD_URL: http://localhost:4440

```
