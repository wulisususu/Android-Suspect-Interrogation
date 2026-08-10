.class public Lcom/taobao/tao/log/godeye/api/a/e;
.super Ljava/lang/Object;
.source "TraceTask.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field public allocMemoryLevel:Ljava/lang/Long;

.field public bufferSize:Ljava/lang/Integer;

.field public filePath:Ljava/lang/String;

.field public maxTrys:Ljava/lang/Integer;

.field public numTrys:Ljava/lang/Integer;

.field public opCode:Ljava/lang/String;

.field public progress:Ljava/lang/String;

.field public requestId:Ljava/lang/String;

.field public samplingInterval:Ljava/lang/Long;

.field public sequence:Ljava/lang/String;

.field public start:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;

.field public stop:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;

.field public threshold:Ljava/lang/Double;

.field public uploadId:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 52
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/api/a/e;->numTrys:Ljava/lang/Integer;

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/api/a/e;->bufferSize:Ljava/lang/Integer;

    const/4 v0, 0x3

    .line 56
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/api/a/e;->maxTrys:Ljava/lang/Integer;

    return-void
.end method


# virtual methods
.method public a(Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;)V
    .locals 5

    .line 72
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;->commandInfo:Lcom/taobao/android/tlog/protocol/model/CommandInfo;

    if-nez v0, :cond_0

    return-void

    .line 77
    :cond_0
    iget-object v1, p1, Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;->commandInfo:Lcom/taobao/android/tlog/protocol/model/CommandInfo;

    iget-object v1, v1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->opCode:Ljava/lang/String;

    iput-object v1, p0, Lcom/taobao/tao/log/godeye/api/a/e;->opCode:Ljava/lang/String;

    .line 78
    iget-object v1, p1, Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;->commandInfo:Lcom/taobao/android/tlog/protocol/model/CommandInfo;

    iget-object v1, v1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->requestId:Ljava/lang/String;

    iput-object v1, p0, Lcom/taobao/tao/log/godeye/api/a/e;->requestId:Ljava/lang/String;

    .line 79
    iget-object v1, p1, Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;->uploadId:Ljava/lang/String;

    iput-object v1, p0, Lcom/taobao/tao/log/godeye/api/a/e;->uploadId:Ljava/lang/String;

    .line 81
    iget-object v1, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->opCode:Ljava/lang/String;

    const-string v2, "RDWP_METHOD_TRACE_DUMP"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const-string v2, "TLOG.TraceTask"

    if-eqz v1, :cond_a

    .line 82
    new-instance v1, Lcom/taobao/android/tlog/protocol/model/request/MethodTraceRequest;

    invoke-direct {v1}, Lcom/taobao/android/tlog/protocol/model/request/MethodTraceRequest;-><init>()V

    .line 84
    :try_start_0
    iget-object v3, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->data:Lcom/alibaba/fastjson/JSON;

    invoke-virtual {v1, v3, v0}, Lcom/taobao/android/tlog/protocol/model/request/MethodTraceRequest;->parse(Lcom/alibaba/fastjson/JSON;Lcom/taobao/android/tlog/protocol/model/CommandInfo;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 86
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 87
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v3

    invoke-virtual {v3}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object v3

    sget-object v4, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_HANDLE:Ljava/lang/String;

    invoke-interface {v3, v4, v2, v0}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageError(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 91
    :goto_0
    iget-object v0, v1, Lcom/taobao/android/tlog/protocol/model/request/MethodTraceRequest;->start:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;

    if-eqz v0, :cond_1

    .line 92
    iget-object v0, v1, Lcom/taobao/android/tlog/protocol/model/request/MethodTraceRequest;->start:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/api/a/e;->start:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;

    .line 94
    :cond_1
    iget-object v0, v1, Lcom/taobao/android/tlog/protocol/model/request/MethodTraceRequest;->stop:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;

    if-eqz v0, :cond_2

    .line 95
    iget-object v0, v1, Lcom/taobao/android/tlog/protocol/model/request/MethodTraceRequest;->stop:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/api/a/e;->stop:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;

    .line 97
    :cond_2
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;->commandInfo:Lcom/taobao/android/tlog/protocol/model/CommandInfo;

    iget-object v0, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->requestId:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/api/a/e;->sequence:Ljava/lang/String;

    const/4 v0, 0x0

    .line 99
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    iput-object v2, p0, Lcom/taobao/tao/log/godeye/api/a/e;->numTrys:Ljava/lang/Integer;

    .line 100
    iget-object v2, v1, Lcom/taobao/android/tlog/protocol/model/request/MethodTraceRequest;->maxTrys:Ljava/lang/Integer;

    if-eqz v2, :cond_3

    .line 101
    iget-object v2, v1, Lcom/taobao/android/tlog/protocol/model/request/MethodTraceRequest;->maxTrys:Ljava/lang/Integer;

    iput-object v2, p0, Lcom/taobao/tao/log/godeye/api/a/e;->maxTrys:Ljava/lang/Integer;

    goto :goto_1

    .line 103
    :cond_3
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    iput-object v2, p0, Lcom/taobao/tao/log/godeye/api/a/e;->maxTrys:Ljava/lang/Integer;

    .line 105
    :goto_1
    iget-object v2, v1, Lcom/taobao/android/tlog/protocol/model/request/MethodTraceRequest;->samplingInterval:Ljava/lang/Long;

    if-eqz v2, :cond_4

    .line 106
    iget-object v1, v1, Lcom/taobao/android/tlog/protocol/model/request/MethodTraceRequest;->samplingInterval:Ljava/lang/Long;

    iput-object v1, p0, Lcom/taobao/tao/log/godeye/api/a/e;->samplingInterval:Ljava/lang/Long;

    .line 108
    :cond_4
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/api/a/e;->numTrys:Ljava/lang/Integer;

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/api/a/e;->maxTrys:Ljava/lang/Integer;

    .line 109
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-nez v0, :cond_5

    const/4 v0, 0x3

    .line 110
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/api/a/e;->maxTrys:Ljava/lang/Integer;

    .line 112
    :cond_5
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;->filePath:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/api/a/e;->filePath:Ljava/lang/String;

    .line 113
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;->progress:Ljava/lang/String;

    if-eqz v0, :cond_6

    .line 114
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;->progress:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/api/a/e;->progress:Ljava/lang/String;

    :cond_6
    iget-object v0, p0, Lcom/taobao/tao/log/godeye/api/a/e;->progress:Ljava/lang/String;

    if-nez v0, :cond_7

    .line 117
    sget-object v0, Lcom/taobao/tao/log/godeye/api/a/d;->a:Lcom/taobao/tao/log/godeye/api/a/d;

    invoke-virtual {v0}, Lcom/taobao/tao/log/godeye/api/a/d;->name()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/api/a/e;->progress:Ljava/lang/String;

    .line 119
    :cond_7
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;->bufferSize:Ljava/lang/Integer;

    if-eqz v0, :cond_8

    .line 120
    iget-object p1, p1, Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;->bufferSize:Ljava/lang/Integer;

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/api/a/e;->bufferSize:Ljava/lang/Integer;

    :cond_8
    iget-object p1, p0, Lcom/taobao/tao/log/godeye/api/a/e;->bufferSize:Ljava/lang/Integer;

    .line 122
    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    if-nez p1, :cond_9

    const/high16 p1, 0x400000

    .line 123
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/api/a/e;->bufferSize:Ljava/lang/Integer;

    :cond_9
    iget-object p1, p0, Lcom/taobao/tao/log/godeye/api/a/e;->samplingInterval:Ljava/lang/Long;

    if-nez p1, :cond_d

    const-wide/16 v0, 0x2710

    .line 126
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/api/a/e;->samplingInterval:Ljava/lang/Long;

    goto :goto_4

    .line 128
    :cond_a
    iget-object p1, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->opCode:Ljava/lang/String;

    const-string v1, "RDWP_HEAP_DUMP"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_d

    .line 129
    new-instance p1, Lcom/taobao/android/tlog/protocol/model/request/HeapDumpRequest;

    invoke-direct {p1}, Lcom/taobao/android/tlog/protocol/model/request/HeapDumpRequest;-><init>()V

    .line 131
    :try_start_1
    iget-object v1, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->data:Lcom/alibaba/fastjson/JSON;

    invoke-virtual {p1, v1, v0}, Lcom/taobao/android/tlog/protocol/model/request/HeapDumpRequest;->parse(Lcom/alibaba/fastjson/JSON;Lcom/taobao/android/tlog/protocol/model/CommandInfo;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_2

    :catch_1
    move-exception v0

    .line 133
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 134
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object v1

    sget-object v3, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_HANDLE:Ljava/lang/String;

    invoke-interface {v1, v3, v2, v0}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageError(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 138
    :goto_2
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/request/HeapDumpRequest;->start:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;

    if-eqz v0, :cond_b

    .line 139
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/request/HeapDumpRequest;->start:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/api/a/e;->start:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;

    .line 142
    :cond_b
    iget-object p1, p1, Lcom/taobao/android/tlog/protocol/model/request/HeapDumpRequest;->heapSizeThreshold:Ljava/lang/Integer;

    if-eqz p1, :cond_c

    .line 144
    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    int-to-double v0, p1

    invoke-static {v0, v1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/api/a/e;->threshold:Ljava/lang/Double;

    goto :goto_3

    :cond_c
    const-wide v0, 0x3fe3333333333333L    # 0.6

    .line 146
    invoke-static {v0, v1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/api/a/e;->threshold:Ljava/lang/Double;

    :goto_3
    const-wide/32 v0, 0x6400000

    .line 148
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/api/a/e;->allocMemoryLevel:Ljava/lang/Long;

    :cond_d
    :goto_4
    return-void
.end method
