# Insper
## Data Science Deploy
### GCP Cloud Run Function

PADS (Programa Avançado em Data Science e Decisão)

Prompt Copilot (Outras LLMs também funcionam): Criar uma função em python para transformar JSON em XML, usar method POST, retornar mensagem de erro se outros métodos forem usados. Incluir os campos company com valor fixo Insper, e now com data e hora, usar a lib
functions_framework, sera feita implantação (deploy) no GCP Cloud Run Functions

Para rodar local...

```bash
docker build -t json2xml-function .
docker run -p 5000:5000 -e PORT=5000 json2xml-function
curl http://localhost:5000/json2xml
```