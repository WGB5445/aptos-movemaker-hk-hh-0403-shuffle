# Aptos Shuffle 智能合约

这是一个基于Aptos区块链的随机洗牌合约，用于生成随机排列的玩家列表。该合约利用Aptos的随机性模块，为游戏、抽奖或任何需要公平随机分配的场景提供服务。

## 合约信息

- **测试网合约地址**: `0x68fd7b26ca8f8574b4e5ea9e183e3d27beb70c467c638e159149fa1fe5b4529e`
- **网络**: Aptos测试网(Testnet)
- **浏览器**: https://explorer.aptoslabs.com/object/0x68fd7b26ca8f8574b4e5ea9e183e3d27beb70c467c638e159149fa1fe5b4529e/modules/view/Shuffle/get_player_list_hk?network=testnet
- 当前抽签顺序 8,10,13,5,16,2,22,30,25,29,15,27,24,23,26,14,6,9,34,21,32,17,20,18,31,19,11,7,1,4,28,12,33,3

## 功能概述

- 生成指定数量的玩家ID并随机洗牌排序
- 查询已洗牌的玩家列表
- 支持重新洗牌现有玩家列表

## 技术特点

- 使用Aptos的原生随机性模块确保公平性
- 高效的洗牌算法
- 完全去中心化，结果不可篡改

## 如何使用

### 环境准备

1. 安装Aptos CLI工具
   ```bash
   curl -fsSL "https://aptos.dev/scripts/install_cli.py" | python3
   ```

2. 检查安装
   ```bash
   aptos --version
   ```

### 部署合约

1. 初始化项目（如果你是从头开始）
   ```bash
   aptos init
   ```

2. 编译合约
   ```bash
   aptos move compile
   ```

3. 发布合约
   ```bash
   aptos move publish
   ```

### 合约交互

#### 创建随机洗牌的玩家列表

调用`Shuffle`函数创建一个包含指定数量玩家的随机排序列表：

```bash
aptos move run \
  --function-id 0x68fd7b26ca8f8574b4e5ea9e183e3d27beb70c467c638e159149fa1fe5b4529e::shuffle::Shuffle \
  --args u64:<玩家数量>
```

例如，创建一个包含10名玩家的列表：
```bash
aptos move run \
  --function-id 0x68fd7b26ca8f8574b4e5ea9e183e3d27beb70c467c638e159149fa1fe5b4529e::shuffle::Shuffle \
  --args u64:10
```

#### 查询玩家列表

你可以使用以下命令查询某个地址下的玩家列表：

```bash
aptos move view \
  --function-id 0x68fd7b26ca8f8574b4e5ea9e183e3d27beb70c467c638e159149fa1fe5b4529e::shuffle::get_player_list \
  --args address:<要查询的地址>
```

或者查询预设的香港地址列表：

```bash
aptos move view \
  --function-id 0x68fd7b26ca8f8574b4e5ea9e183e3d27beb70c467c638e159149fa1fe5b4529e::shuffle::get_player_list_hk
```

#### 测试网资源浏览器链接

你可以在Aptos测试网浏览器上查看合约状态：
```
https://explorer.aptoslabs.com/account/0x68fd7b26ca8f8574b4e5ea9e183e3d27beb70c467c638e159149fa1fe5b4529e?network=testnet
```

## 代码示例

这是合约的核心洗牌函数:

```move
fun shuffle (
    vec: vector<u64>
): vector<u64>{
    let count = vec.length();
    let res = vector::empty();
    for ( i in 0..count){
        let index = randomness::u64_range(0, vec.length());
        let player = vec.remove(index);
        res.push_back(player)
    };
    res
}
```

## 贡献

欢迎提交问题和改进建议！请随时创建Issue或Pull Request。

## 许可证

本项目采用[开源许可证]。
