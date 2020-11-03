# Solidity笔记-手摸手部署属于自己的合约代币
 
## 前言
学习了solidity后肯定要部署一个属于自己的合约, 下面介绍两种部署合约的方法

## 安装 MetaMask获取测试资金
 安装谷歌插件, 生成自己的钱包地址
> 下载地址  https://metamask.io/

注册一个账户, 成功后如下图

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201103112153351.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3l3ZGh6eGY=,size_16,color_FFFFFF,t_70#pic_center)

选择 Ropsten测试链, 刚生成的账户没有测试ETH, 点击

BUY - 测试水管获取ETH 

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201103112337270.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3l3ZGh6eGY=,size_16,color_FFFFFF,t_70#pic_center)

点击发送成功后即可获得一个ETH的资金, 创建合约的时候需要花费ETH

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201103112438644.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3l3ZGh6eGY=,size_16,color_FFFFFF,t_70#pic_center)

## 简单粗暴一键发币
> https://yidaibi.me/app/index.html#/token

### 参数填写完成后支付矿工费

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201103113409198.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3l3ZGh6eGY=,size_16,color_FFFFFF,t_70#pic_center)
### 点击交易哈希即可跳转到区块浏览器

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201103113835483.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3l3ZGh6eGY=,size_16,color_FFFFFF,t_70#pic_center)
### 红线框即为你的合约地址, 点进去即可查看合约详情

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201103113805107.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3l3ZGh6eGY=,size_16,color_FFFFFF,t_70#pic_center)

### 在 MetaMask钱包中添加你的测试代币

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201103114041727.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3l3ZGh6eGY=,size_16,color_FFFFFF,t_70#pic_center)
### 就可以看到你的代币了, 可以给其他地址发送了

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201103114137372.png#pic_center)

## 自定义代码部署合约
用到solidity编辑器
> http://remix.ethereum.org

可以在区块浏览器找一个自己喜欢的合约, 比如link 合约代码 
> https://cn.etherscan.com/address/0x514910771af9ca656af840dff83e8264ecf986ca#code

### 在remix中新建文件, 并修改其中的参数
```
totalSupply 总发行量
name        代币名称
decimals    代币精度
symbol      代币符号
```
会solidity编码想添加其他功能的直接加就行
# 选择对应solidity版本(合约代码开始会标明), 点击编译合约, 编译无误即可;

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201103114731658.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3l3ZGh6eGY=,size_16,color_FFFFFF,t_70#pic_center)

### 来到部署界面, 选择环境为 Injected Web3 (如果有错误就刷新下页面, 可能没链接上 MetaMask), 选择部署的主合约,点击 Deploy部署即可, 需要支付下矿工费, 然后下面控制台会返回交易哈希

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201103152857516.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3l3ZGh6eGY=,size_16,color_FFFFFF,t_70#pic_center)

### 点击哈希进入区块浏览器, 查看合约

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201103150902154.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3l3ZGh6eGY=,size_16,color_FFFFFF,t_70#pic_center)

### 点击进行验证发布

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201103150939236.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3l3ZGh6eGY=,size_16,color_FFFFFF,t_70#pic_center)

### 选择对应配置项

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201103151027586.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3l3ZGh6eGY=,size_16,color_FFFFFF,t_70#pic_center)

### 第一个框就把remix中的合同代码直接复制上去就好了, 第二个是abi编码的构造函数参数, 这里没有不用填

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201103151110877.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3l3ZGh6eGY=,size_16,color_FFFFFF,t_70#pic_center)

### 验证成功

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201103151149413.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3l3ZGh6eGY=,size_16,color_FFFFFF,t_70#pic_center)

### 钱包添加代币

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201103151258855.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3l3ZGh6eGY=,size_16,color_FFFFFF,t_70#pic_center)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201103151323317.png#pic_center)