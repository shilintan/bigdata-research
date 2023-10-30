# 目标

flink基于k8s资源调度自动扩缩容, 自动优化慢计算

场景: 不同时间段使用的业务不一样、资源不一样

对研发的效果: 通过扩容底层资源实现优化算法一样的效果, 为优化算法缓冲时间



版本: 1.14

# k8s

部署k8s, 参考文档: https://github.com/shilintan/k8s-research/blob/main/%E9%83%A8%E7%BD%B2k8s-sealos/sealos%E5%AE%89%E8%A3%85k8s.md

ca(集群自动扩容节点)



# 业务

客户端发现处理延迟发现运行时过低

​	假设 最大允许堆积时间 < 10s

​	mq堆积数量/mq处理速度 > 最大允许堆积时间

客户端调整运行时并发度

​	时间窗口为1m

​	mq消费数量

​	mq生产数量

​	期望并行度=生产数量/消费数量*当前并行度



​	不能频繁调整并发度(时间窗口大于1m)

​	souce的并发度应该始终保持为1



调整算子的并行度

```
final StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

DataStream<String> text = [...];
DataStream<Tuple2<String, Integer>> wordCounts = text
    .flatMap(new LineSplitter())
    .keyBy(value -> value.f0)
    .window(TumblingEventTimeWindows.of(Time.seconds(5)))
    .sum(1).setParallelism(5);

wordCounts.print();

env.execute("Word Count Example");
```



# flink

官方文档: https://github.com/apache/flink-kubernetes-operator

部署参考 ` 部署.md `





# 问题

## 1.19-snapshot中的reactive讲了什么?

在taskmanager扩容之后会调整job的并行度

但是在深度使用flink场景中, job的并行度都是由算子设置的, 所以可能意义不大

## flink有没有原生指标直接就可以观察到堆积量, 而不是通过看上层mq消费进度



# 行动项

整理思路

部署kafka

编写wordcount



编写部署文档、研究文档、扩容文档、故障处理文档

# 后续

配置文件如何集成进去

​	修改 `defaultConfiguration/flink-conf.yaml`

监控

​	配置pushgateway

k8s ca

​	腾讯云

算子如何自动感知并调整并行度



# 调试

观察应用启动日志



# 研究

operator

crd

jobmanager

taskmanager
