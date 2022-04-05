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
  version     = "3.65.0"
  constraints = "~> 3.65.0"
  hashes = [
    "h1:ZvXCeUYoex3aOLlZYqv08WZ3hcPaf5p/gEa/DeMrkfs=",
    "h1:co5a0w0HS20URndev4CPdCuU1FlM7fFSW6wTP7gqFE4=",
    "zh:402b8ba03f19558f7d0e2a453a9b82747882fb3519ce686ce26a9afd4593d05e",
    "zh:523a306c2906c213b630d1c2f1e48698769bfffe360b68388d935d0bd171c55c",
    "zh:76af4170f5a524ff353e60dd68d728c55dcbd9f6c5f60648e28e4f8f9ca8e958",
    "zh:7d00a44769d26144f42b413c82272e31ae9b63153532b9a135a8f69a6608b9a6",
    "zh:7f5d0ab79d213809726663f7603004c173694602bd22f2419c445d6897729ca2",
    "zh:a1c23e3d280a5053bae9102ad55df1315585395f8656ddf83928978c7e6cd307",
    "zh:a81d0af5ef58c193197f81dc3059f8b22c7dde0575bb3198a0360aff7f9ca476",
    "zh:b5b79fa8f9e49d2d26badfded64a1e460cdb11b152168e578443cf92df679bca",
    "zh:ec4f88d1fd8990511b86205709c1a76ac3a444d0088a810c82a4f5db37ca4afe",
    "zh:f15390a40dc6e9c5b5285bc2b6a8c54b6030ae9cc04cc4a31ecf9b14145c467b",
    "zh:fb1a150464d822aa9182cd46a0b7bc2c279ff9400017b4bb3238256224ab41b6",
  ]
}

provider "registry.terraform.io/hashicorp/google-beta" {
  version     = "4.16.0"
  constraints = "~> 4.16.0"
  hashes = [
    "h1:E46exeQhH8/eraOw9TwI7e+FY/cctTvjSYBf3kRMT48=",
    "zh:117d90f85dbf99430e7a57d19903065837152f2b9b8b426060f62b561e6d46d2",
    "zh:1385515f1d95c383ae47ecd1bb66c2d0d9e5484782cbd3be6b14303c79f9a634",
    "zh:143d51e6e0aef53b1d40a3d828b4d7e151fba01efe98eece8e5b4e6e80dd8eb2",
    "zh:29206ff8fd22fe91d36ffda381229f33404389ee2dca3f6959a1e5ca3865f998",
    "zh:38fa1d6d9365e7a38290f4b2454d9d8819da3e746d173715e87c542198f8256b",
    "zh:58695c5ffc643ddee96a2eb75bbd4fc6a0a60b791dbf0e87ff515e1b0711b466",
    "zh:625af9db990bf5af532f485bb6ec80a729ff2084d72fa38569f46736726a571b",
    "zh:805b484ecb19f698341e2de12d7c34612a49e6a09f9decb4e3c4241a0372ac11",
    "zh:9193e12f4c19541fe788c2990f3e9e572ab69e7d7656b043abcf23d460cc05df",
    "zh:b6f044ab18f8d2962da7b042100ba8251c20217d4b8cf7a9d03b4a0037477a4c",
    "zh:e9b736075e76b4159bcf0f9b9607e5a120f6e2d3fb74528abbfa08f96ebb0736",
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
