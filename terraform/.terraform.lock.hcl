# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is maintained automatically by "terraform init".
# Manual edits may be lost in future updates.

provider "registry.terraform.io/hashicorp/external" {
  version = "2.1.0"
  hashes = [
    "h1:wbtDfLeawmv6xVT1W0w0fctRCb4ABlaD3JTxwb1jXag=",
    "zh:0d83ffb72fbd08986378204a7373d8c43b127049096eaf2765bfdd6b00ad9853",
    "zh:7577d6edc67b1e8c2cf62fe6501192df1231d74125d90e51d570d586d95269c5",
    "zh:9c669ded5d5affa4b2544952c4b6588dfed55260147d24ced02dca3a2829f328",
    "zh:a404d46f2831f90633947ab5d57e19dbfe35b3704104ba6ec80bcf50b058acfd",
    "zh:ae1caea1c936d459ceadf287bb5c5bd67b5e2a7819df6f5c4114b7305df7f822",
    "zh:afb4f805477694a4b9dde86b268d2c0821711c8aab1c6088f5f992228c4c06fb",
    "zh:b993b4a1de8a462643e78f4786789e44ce5064b332fee1cb0d6250ed085561b8",
    "zh:c84b2c13fa3ea2c0aa7291243006d560ce480a5591294b9001ce3742fc9c5791",
    "zh:c8966f69b7eccccb771704fd5335923692eccc9e0e90cb95d14538fe2e92a3b8",
    "zh:d5fe68850d449b811e633a300b114d0617df6d450305e8251643b4d143dc855b",
    "zh:ddebfd1e674ba336df09b1f27bbaa0e036c25b7a7087dc8081443f6e5954028b",
  ]
}

provider "registry.terraform.io/hashicorp/google" {
  version     = "3.85.0"
  constraints = ">= 3.39.0, ~> 3.85.0, < 4.0.0"
  hashes = [
    "h1:NFLAKeIbO6e3PaqsLIPqf55m7Gta0e8FRbyyeoHLL5A=",
    "zh:08d7856f7a57c2a6f4d49340fa4a7ba63d6d63a96669172d580eb4339ba2231c",
    "zh:0f70abdbbdea8d4617df6582ecb9626ba5b31aa1401326fd564844d62b2b11b6",
    "zh:2259e6518fbb0092d8f387749ea9add91362bb0f45c1d21829ff46f77b0f88e7",
    "zh:29cb85bacec2fc4a1bd9fae4cc065e16c9f1a10c1ab76e0131fa55dc9a369d01",
    "zh:4271ccfe6b4f45a1eea2586ecaf8e3fa6d93d187795a96642b7b979fe578f7cc",
    "zh:6cc85edb48b0d04599d4ba02b109ad9d3348342bc77ec09323c734a2c5e53bc9",
    "zh:995cd51b1ceb4f1e968f7a94c90258b5501325f1d7d6bbbc21d39acd04b55d51",
    "zh:a039acd66af0c3fd5b14bc9a153ba1db3ae24e6e766d2e3a435c2101e1b09e38",
    "zh:a6b2a9f70375fb93c3274ece7d3a90a6e54c9e24e123c6f219a3e17cb282fc57",
    "zh:bc2cc035f469b7e9efe907e009b9a8c28f1e4f23673b0039a50983e829fc49cf",
    "zh:eb50a38f75e57cfede9e99e03c8b9aba03b3c79d22d9650e868022fd1c130fdd",
  ]
}

provider "registry.terraform.io/hashicorp/google-beta" {
  version     = "3.65.0"
  constraints = "~> 3.65.0"
  hashes = [
    "h1:+Sme4aLkrInDkZoVUZYTBXuTqv+PGPsf7yHXfNiXQSs=",
    "h1:m6WJmpTXJy1TptMd7lCv/7BvWvcLZb5l8adFuQE9SPM=",
    "zh:351b6e1b4a1559422e1909c155ec0cff6db77dba0016c8a3bc60e0e9fcc06b85",
    "zh:3a3b46ae21cb864442d0d1e434dc83630361f23e5a678265868f93741d255d9c",
    "zh:5fdc09b133567e5e754607192c5b6e06c36c36c12a7751149d8edd658b06eb13",
    "zh:b94797baac1f990a7f87995382f05dccb0216f96db768be28012985e0b77c116",
    "zh:d591bec9b883e412eadddd32fab50ef6f8712734fd0499b24952c7d30141e3bf",
    "zh:ddb9fed734abcfa03c5550ea6d5e48e18a83a7f720c0b72a4467b2a5f6afd57f",
    "zh:e2ad58c6b4dc5d13eaf0493ee56cbdff1a544a537d2868f28f4802d431868c66",
    "zh:e3d0d3e667273051ac995426b2bce429e3a1b53072a229496db4f33c7af0f2bf",
    "zh:f12e99d90dabe17fb422fd5e745274ca731da004bb2271636fcfa2d779567301",
    "zh:f8d3d249f283e3c36cffdb3235f192e4de302b21f06fb751d00c6e9f651270f9",
    "zh:fd368451c44a141a172ef4103338d3da69f870571b960eb29fc0ce9a8fcdadef",
  ]
}

provider "registry.terraform.io/hashicorp/kubernetes" {
  version     = "1.13.3"
  constraints = "~> 1.10, != 1.11.0"
  hashes = [
    "h1:whoGs/NeucMF8U/urPaeXdQUb+ppaO1Ae4r5aJRhfrU=",
    "zh:11fd58df9c297a4f3cab82ce8eb2f54f1be27f78fa23be2273ecd545ab254b91",
    "zh:5b9e6f352c5666d791e2658a1d18bf0990f3ab70c99c916c393a2ee7f385364c",
    "zh:5c94f1350471a5c8e8ee6675874608c506a0bfd3164bdd91b802842723547e2c",
    "zh:5d9c5c44dba9addbb86491339012096e74778bb4ea93b70f12333bffba3d05e6",
    "zh:6336f9cbb0b580f247cebb97fb7d4cc5e7fe9cc734d8d958d84c4ea3f1e24041",
    "zh:bca3b9d4dcbe6f804f5611a83add371dc03b5aa92271f60ebdc2216bfedfab28",
    "zh:cbcdc87a593090f490f7899f4f2d302e0c7023155591fcf65e6fadd69f5452f0",
    "zh:ec2886a1adbfe3c861b2deb9446369111b9c6116701ae73ef372dc7df5bb3c9e",
    "zh:edb5b4172610672bb4d7425511961fda2047b8a00675b99ae6887cd2ece4bda9",
    "zh:ff7ea7743246181ea739643d7751c37041c4016eb6bbc39beb1e3b4e99629112",
  ]
}

provider "registry.terraform.io/hashicorp/null" {
  version = "3.1.0"
  hashes = [
    "h1:vpC6bgUQoJ0znqIKVFevOdq+YQw42bRq0u+H3nto8nA=",
    "zh:02a1675fd8de126a00460942aaae242e65ca3380b5bb192e8773ef3da9073fd2",
    "zh:53e30545ff8926a8e30ad30648991ca8b93b6fa496272cd23b26763c8ee84515",
    "zh:5f9200bf708913621d0f6514179d89700e9aa3097c77dac730e8ba6e5901d521",
    "zh:9ebf4d9704faba06b3ec7242c773c0fbfe12d62db7d00356d4f55385fc69bfb2",
    "zh:a6576c81adc70326e4e1c999c04ad9ca37113a6e925aefab4765e5a5198efa7e",
    "zh:a8a42d13346347aff6c63a37cda9b2c6aa5cc384a55b2fe6d6adfa390e609c53",
    "zh:c797744d08a5307d50210e0454f91ca4d1c7621c68740441cf4579390452321d",
    "zh:cecb6a304046df34c11229f20a80b24b1603960b794d68361a67c5efe58e62b8",
    "zh:e1371aa1e502000d9974cfaff5be4cfa02f47b17400005a16f14d2ef30dc2a70",
    "zh:fc39cc1fe71234a0b0369d5c5c7f876c71b956d23d7d6f518289737a001ba69b",
    "zh:fea4227271ebf7d9e2b61b89ce2328c7262acd9fd190e1fd6d15a591abfa848e",
  ]
}

provider "registry.terraform.io/hashicorp/random" {
  version = "3.1.0"
  hashes = [
    "h1:BZMEPucF+pbu9gsPk0G0BHx7YP04+tKdq2MrRDF1EDM=",
    "zh:2bbb3339f0643b5daa07480ef4397bd23a79963cc364cdfbb4e86354cb7725bc",
    "zh:3cd456047805bf639fbf2c761b1848880ea703a054f76db51852008b11008626",
    "zh:4f251b0eda5bb5e3dc26ea4400dba200018213654b69b4a5f96abee815b4f5ff",
    "zh:7011332745ea061e517fe1319bd6c75054a314155cb2c1199a5b01fe1889a7e2",
    "zh:738ed82858317ccc246691c8b85995bc125ac3b4143043219bd0437adc56c992",
    "zh:7dbe52fac7bb21227acd7529b487511c91f4107db9cc4414f50d04ffc3cab427",
    "zh:a3a9251fb15f93e4cfc1789800fc2d7414bbc18944ad4c5c98f466e6477c42bc",
    "zh:a543ec1a3a8c20635cf374110bd2f87c07374cf2c50617eee2c669b3ceeeaa9f",
    "zh:d9ab41d556a48bd7059f0810cf020500635bfc696c9fc3adab5ea8915c1d886b",
    "zh:d9e13427a7d011dbd654e591b0337e6074eef8c3b9bb11b2e39eaaf257044fd7",
    "zh:f7605bd1437752114baf601bdf6931debe6dc6bfe3006eb7e9bb9080931dca8a",
  ]
}
