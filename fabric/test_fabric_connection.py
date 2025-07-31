import os
from azure.identity import DefaultAzureCredential
from azure.storage.filedatalake import DataLakeServiceClient

account_name = os.environ.get("AZURE_STORAGE_ACCOUNT_NAME")
if not account_name:
    raise ValueError("AZURE_STORAGE_ACCOUNT_NAME environment variable not set")

account_url = f"https://{account_name}.dfs.core.windows.net"
credential = DefaultAzureCredential()

try:
    service_client = DataLakeServiceClient(account_url, credential=credential)
    file_systems = list(service_client.list_file_systems())
    print(f"Connection successful! Found {len(file_systems)} file systems:")
    for fs in file_systems:
        print(f"- {fs.name}")
except Exception as e:
    print(f"Connection failed: {e}")
