defmodule StakeHandler do
  use Ethers.Contract,
      abi_file: "priv/StakeHandler.json",
      default_address: "0x1000000000000000000000000000000000000005"

  # You can also add more code here in this module if you wish
end
