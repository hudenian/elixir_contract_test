defmodule CallContractTest do
  use ExUnit.Case
  doctest CallContract

  alias Utils.TypeTranslator
  alias ABI.TypeDecoder
  alias ExRLP


  @tag :erc20_total_supply
  test "call erc20 total supply" do
    # 合约调用
        tx_data = Ethers.Contracts.ERC20.total_supply()
        a = Ethers.call(tx_data, to: "0x88edBfC0d17BFa9ffC064244Bc90Bf0F264D0880")
    IO.inspect(a,lable: "total_supply is:")
    IO.puts "Hello, World!"
    # 合约调用
#    tx_data = Ethers.Contracts.ERC20.balance_of("0x70d207c1322ccb9069d3790d6768866dabff1035")
#    a = Ethers.call(tx_data, to: "0x88edBfC0d17BFa9ffC064244Bc90Bf0F264D0880")
#    IO.inspect(a,lable: "total_supply is:")
#    IO.puts "Hello, World!"
  end

  @tag :call
  test "call contract" do
    data =  StakeHandler.get_validators(<<>>,2)
    a = Ethers.call(data, to: "0x1000000000000000000000000000000000000005",from: "0x13943B955A42f55c0576c08a14734641249a943F", rpc_opts: [url: "http://192.168.9.82:8801"])
#  a = Ethers.call(data,[to: "0x1000000000000000000000000000000000000005", from: "0x13943B955A42f55c0576c08a14734641249a943F",rpc_client:""])
    # 合约调用
#    tx_data = Ethers.Contracts.ERC20.balance_of("0xDB0eCbE91f2739a10DAd39e5b53b3174C6C0Eeb2")
#    a = Ethers.call(tx_data, to: "0x877149B4428A731fF08A301103EBFB7BE7ad4183")
    IO.inspect(a,lable: "a is:")
    IO.puts "Hello, World!"
  end


  @tag :rlp
  test "call rlp" do
   a =  "00000000000000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000003f96d3598b087521f681f80f9b8b79a191385dfb594623382dd0ee3e5021618cb" |> ExRLP.decode(encoding: :hex)
#   a =  "dog" |> ExRLP.encode(encoding: :hex)
    IO.inspect(a,lable: "a is:")
  end


#  http://192.168.9.82:8801
#  0x1000000000000000000000000000000000000005
  @tag :abi_decode_bytes
  test "contract abi decode by type" do
     [re]= "00000000000000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000003f96d3598b087521f681f80f9b8b79a191385dfb594623382dd0ee3e5021618cb"
         |> Base.decode16!(case: :lower)
         |> TypeDecoder.decode_raw([{:bytes, 32}])
     IO.inspect( re)
  end

  @tag :abi_decode_bytes_ValidatorRegistered
  test "contract abi decode by type ValidatorRegistered" do
    str = "00000000000000000000000097ab3d4f7f5051f127b0e9f8d10772125d94d65b0000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000e000000000000000000000000000000000000000000000000000000000000000407c278b7e4320528bdbf5c02db611282b431dbaec2509b1fbebe3de4be7442a4114f1c9970ffd0c589afa8ef6262692efd4edae5d77c87641f21f44b1d082c3480000000000000000000000000000000000000000000000000000000000000030b969678ef2cf458b49b8c568d95e63221efe0f30383a9b0c5eb683bf2e23d118664631ce992d81ec4b6127ec0a760f8600000000000000000000000000000000"
#          |> Base.decode16!(case: :lower)
#    {decoded, _} = ExRLP.decode(str, encoding: :hex)
#    IO.inspect( decoded)
  end

  "00000000000000000000000000000000000000000000000000000000000000110000000000000000000000000000000000000000000000000000000000000001"
  |> Base.decode16!(case: :lower)
  |> ABI.TypeDecoder.decode(
       %ABI.FunctionSelector{
         function: nil,
         types: [
           {:tuple, [{:uint, 32}, :bool]}
         ]
       }
     )
  [{17, true}]

  def find_and_decode_event(abi, topics, data) do
    [topic1, topic2, topic3, topic4] =
      Enum.map(topics, fn topic ->
        TypeTranslator.hex_to_bin(topic)
      end)

    abi
    |> ABI.parse_specification(include_events?: true)
    |> ABI.Event.find_and_decode(topic1, topic2, topic3, topic4, TypeTranslator.hex_to_bin(data))

  end




  @tag :abi_decode_by_json_demo
  test "contract abi decode by json demo" do
    topic1 = ExKeccak.hash_256("WantsPets(string,uint256,bool)")
    topic2 = ExKeccak.hash_256("bob")
    topic3 = "0000000000000000000000000000000000000000000000000000000000000001" |> Base.decode16!()
    topic4 = nil


    data = "00000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000001cb1441bce2f80199517e5ba84e5d517cd7fcb35faf93799c975ebcaa8193a20f" |> Base.decode16!()

    result =  File.read!("priv/dog.abi.json")
              |> Jason.decode!()
              |> ABI.parse_specification(include_events?: true)
              |> ABI.Event.find_and_decode(topic1, topic2, topic3, topic4, data)
    IO.inspect("decode value is>>>#{inspect result}")
    #    {func,params} = result

    #    IO.puts("function name : #{func.function}")
    #    IO.puts("function method id: #{Base.encode16(func.method_id,case: :lower)}")
    #    [value] = params
    #    IO.puts("value: #{value}")
  end



  @tag :abi_decode_by_json_demo_my
  test "contract abi decode by json demo my" do
    topic1 = ExKeccak.hash_256("NewCommitment(uint256,uint256,bytes32)")
    IO.inspect("topic1 is>>>#{inspect topic1}")
    topic2 = "0000000000000000000000000000000000000000000000000000000000000001" |> Base.decode16!()
    IO.inspect("topic2 is>>>#{inspect topic2}")
    topic3 = "0000000000000000000000000000000000000000000000000000000000000001" |> Base.decode16!()
    topic4 = nil

    data = "cb1441bce2f80199517e5ba84e5d517cd7fcb35faf93799c975ebcaa8193a20f" |> Base.decode16!(case: :mixed)

    result =  File.read!("priv/a.json")
              |> Jason.decode!()
              |> ABI.parse_specification(include_events?: true)
              |> ABI.Event.find_and_decode(topic1, topic2, topic3, topic4, data)
    IO.inspect("decode value is>>>#{inspect result}")
  end



  @tag :call_inspect
  test "call inspect" do
#    data =  StakeHandler.get_validators(<<>>,2)
#    a = Ethers.call(data, to: "0x1000000000000000000000000000000000000005",from: "0x13943B955A42f55c0576c08a14734641249a943F", rpc_opts: [url: "http://192.168.9.82:8801"])
    #  a = Ethers.call(data,[to: "0x1000000000000000000000000000000000000005", from: "0x13943B955A42f55c0576c08a14734641249a943F",rpc_client:""])
    # 合约调用
    #    tx_data = Ethers.Contracts.ERC20.balance_of("0xDB0eCbE91f2739a10DAd39e5b53b3174C6C0Eeb2")
    #    a = Ethers.call(tx_data, to: "0x877149B4428A731fF08A301103EBFB7BE7ad4183")
    a = "haha"
    IO.inspect(a, label: "value>>>")
  end







  @tag :abi_decode_by_json
  test "contract abi decode by json" do
    topic1 = ExKeccak.hash_256("ValidatorRegistered(address,address,uint256,bytes,bytes)")
    topic2 = ExKeccak.hash_256("1")
    topic3 = nil
    topic4 = nil

    a  =  File.read!("priv/a.json")
          |> Jason.decode!
          |> ABI.parse_specification(include_events?: true)
          |> ABI.Event.find_and_decode(topic1,topic2,topic3,topic4,"00000000000000000000000097ab3d4f7f5051f127b0e9f8d10772125d94d65b0000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000e000000000000000000000000000000000000000000000000000000000000000407c278b7e4320528bdbf5c02db611282b431dbaec2509b1fbebe3de4be7442a4114f1c9970ffd0c589afa8ef6262692efd4edae5d77c87641f21f44b1d082c3480000000000000000000000000000000000000000000000000000000000000030b969678ef2cf458b49b8c568d95e63221efe0f30383a9b0c5eb683bf2e23d118664631ce992d81ec4b6127ec0a760f8600000000000000000000000000000000" |> Base.decode16!(case: :lower))
    IO.inspect("decode value is>>>#{inspect a}")
  end


  @tag :abi_decode_unit
  test "contract abi decode unit" do
    address = <<151, 171, 61, 79, 127, 80, 81, 241, 39, 176, 233, 248, 209, 7, 114, 18, 93, 148, 214, 91>>
              |>  Base.encode16(case: :lower)
    hex_address = "0x" <> address
    IO.inspect( "amount is>>>>>>>>>>>>>>>>>#{ hex_address}")
  end









end
