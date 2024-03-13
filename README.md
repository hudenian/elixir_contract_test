# CallContract

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `call_contract` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:call_contract, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/call_contract>.



# 创建项目
```
mix new call_contract
```

# 添加依赖
mix.exs
```
{:ethers, "~> 0.1.2"}
```

# 下载依赖
```
mix deps.get
```

# 编写测试用例
```
tx_data = Ethers.Contracts.ERC20.balance_of("0xDB0eCbE91f2739a10DAd39e5b53b3174C6C0Eeb2")
a = Ethers.call(tx_data, to: "0x877149B4428A731fF08A301103EBFB7BE7ad4183")
IO.inspect(a,lable: "a is:")
IO.puts "Hello, World!"
```

# 执行测试用例
```
mix test 
mix test --only erc20_total_supply
```

