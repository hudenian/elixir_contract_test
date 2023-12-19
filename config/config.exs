# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
import Config

# config.exs
config :ethers,
  # Defaults to: Ethereumex.HttpClient
  rpc_client: Ethereumex.HttpClient,
  # Defaults to: ExKeccak
  keccak_module: ExKeccak,
  # Defaults to: Jason
  json_module: Jason

# If using Ethereumex, you can specify a default JSON-RPC server url here for all requests.
config :ethereumex, url: "https://devnet2openapi.platon.network/rpc"

