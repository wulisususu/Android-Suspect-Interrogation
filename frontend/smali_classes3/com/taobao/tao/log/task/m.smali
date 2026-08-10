.class public Lcom/taobao/tao/log/task/m;
.super Ljava/lang/Object;
.source "LogUploadRequestTask.java"

# interfaces
.implements Lcom/taobao/tao/log/task/i;


# instance fields
.field private TAG:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "TLOG.LogUploadRequestTask"

    iput-object v0, p0, Lcom/taobao/tao/log/task/m;->TAG:Ljava/lang/String;

    return-void
.end method

.method private a([Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;)Ljava/util/List;
    .locals 18
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;",
            ")",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    move-object/from16 v0, p1

    .line 81
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    const/4 v2, 0x0

    if-nez v0, :cond_0

    move-object/from16 v3, p0

    iget-object v0, v3, Lcom/taobao/tao/log/task/m;->TAG:Ljava/lang/String;

    const-string v1, "log features is null "

    .line 83
    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-object v2

    :cond_0
    move-object/from16 v3, p0

    .line 87
    array-length v4, v0

    const/4 v5, 0x0

    move v6, v5

    :goto_0
    if-ge v6, v4, :cond_9

    aget-object v7, v0, v6

    .line 88
    iget-object v8, v7, Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;->appenderName:Ljava/lang/String;

    if-nez v8, :cond_1

    .line 90
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v8

    invoke-virtual {v8}, Lcom/taobao/tao/log/TLogInitializer;->getNameprefix()Ljava/lang/String;

    move-result-object v8

    .line 92
    invoke-static {v8}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_1

    const/16 v9, 0x3a

    .line 93
    invoke-virtual {v8, v9}, Ljava/lang/String;->indexOf(I)I

    move-result v9

    if-lez v9, :cond_1

    .line 95
    invoke-virtual {v8, v5, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    .line 99
    :cond_1
    iget-object v9, v7, Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;->suffix:Ljava/lang/String;

    .line 100
    iget-object v10, v7, Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;->maxHistory:Ljava/lang/Integer;

    if-eqz v9, :cond_2

    .line 104
    invoke-static {v9, v10}, Lcom/taobao/tao/log/TLogUtils;->getFilePath(Ljava/lang/String;Ljava/lang/Integer;)Ljava/util/List;

    move-result-object v9

    goto :goto_1

    :cond_2
    move-object v9, v2

    :goto_1
    if-eqz v8, :cond_4

    .line 108
    new-instance v11, Ljava/text/SimpleDateFormat;

    const-string v12, "yyyyMMdd"

    invoke-direct {v11, v12}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    .line 109
    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v12

    new-array v12, v12, [Ljava/lang/String;

    .line 110
    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v10

    add-int/lit8 v10, v10, -0x1

    :goto_2
    if-ltz v10, :cond_3

    .line 111
    new-instance v13, Ljava/util/Date;

    iget-object v14, v7, Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;->endTime:Ljava/lang/Long;

    invoke-virtual {v14}, Ljava/lang/Long;->longValue()J

    move-result-wide v14

    const-wide/32 v16, 0x5265c00

    int-to-long v2, v10

    mul-long v2, v2, v16

    sub-long/2addr v14, v2

    invoke-direct {v13, v14, v15}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v11, v13}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v12, v10

    add-int/lit8 v10, v10, -0x1

    move-object/from16 v3, p0

    const/4 v2, 0x0

    goto :goto_2

    .line 114
    :cond_3
    invoke-static {v12}, Lcom/taobao/tao/log/TLogUtils;->transferTodayFileIfNeeded([Ljava/lang/String;)V

    const/4 v2, -0x1

    .line 115
    invoke-static {v8, v2, v12}, Lcom/taobao/tao/log/TLogUtils;->getFilePath(Ljava/lang/String;I[Ljava/lang/String;)Ljava/util/List;

    move-result-object v2

    goto :goto_3

    :cond_4
    const/4 v2, 0x0

    :goto_3
    if-eqz v9, :cond_6

    .line 120
    invoke-interface {v9}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_5
    :goto_4
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_6

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    .line 121
    invoke-interface {v1, v7}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_5

    .line 122
    invoke-interface {v1, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_4

    :cond_6
    if-eqz v2, :cond_8

    .line 129
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_7
    :goto_5
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_8

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 130
    invoke-interface {v1, v3}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_7

    .line 131
    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_5

    :cond_8
    add-int/lit8 v6, v6, 0x1

    move-object/from16 v3, p0

    const/4 v2, 0x0

    goto/16 :goto_0

    :cond_9
    return-object v1
.end method


# virtual methods
.method public a(Lcom/taobao/android/tlog/protocol/model/CommandInfo;)Lcom/taobao/tao/log/task/i;
    .locals 10

    const-string v0, "\u6d88\u606f\u5904\u7406\uff1a\u670d\u52a1\u7aef\u8bf7\u6c42\u4e0a\u4f20\u6587\u4ef6,\u662f\u5426\u5141\u8bb8\u975ewifi\u4e0a\u4f20\uff1a"

    .line 34
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object v1

    sget-object v2, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_HANDLE:Ljava/lang/String;

    iget-object v3, p0, Lcom/taobao/tao/log/task/m;->TAG:Ljava/lang/String;

    const-string v4, "\u6d88\u606f\u5904\u7406\uff1a\u670d\u52a1\u7aef\u8bf7\u6c42\u4e0a\u4f20\u6587\u4ef6"

    invoke-interface {v1, v2, v3, v4}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    const/4 v1, 0x1

    .line 38
    invoke-static {v1}, Lcom/taobao/tao/log/TLogNative;->appenderFlushData(Z)V

    .line 41
    :try_start_0
    new-instance v1, Lcom/taobao/android/tlog/protocol/model/request/LogUploadRequest;

    invoke-direct {v1}, Lcom/taobao/android/tlog/protocol/model/request/LogUploadRequest;-><init>()V

    .line 42
    iget-object v2, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->data:Lcom/alibaba/fastjson/JSON;

    invoke-virtual {v1, v2, p1}, Lcom/taobao/android/tlog/protocol/model/request/LogUploadRequest;->parse(Lcom/alibaba/fastjson/JSON;Lcom/taobao/android/tlog/protocol/model/CommandInfo;)V

    .line 44
    iget-object v4, v1, Lcom/taobao/android/tlog/protocol/model/request/LogUploadRequest;->uploadId:Ljava/lang/String;

    .line 45
    iget-object v2, v1, Lcom/taobao/android/tlog/protocol/model/request/LogUploadRequest;->logFeatures:[Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;

    .line 46
    iget-object v1, v1, Lcom/taobao/android/tlog/protocol/model/request/LogUploadRequest;->allowNotWifi:Ljava/lang/Boolean;

    if-eqz v1, :cond_0

    .line 48
    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    if-nez v3, :cond_0

    .line 50
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v3

    invoke-virtual {v3}, Lcom/taobao/tao/log/TLogInitializer;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Lcom/taobao/tao/log/TLogUtils;->checkNetworkIsWifi(Landroid/content/Context;)Z

    move-result v3

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    .line 51
    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    if-nez v3, :cond_0

    const/4 v5, 0x0

    const-string v6, "1"

    const-string v7, "405"

    const-string v8, "NotWifi"

    const/4 v9, 0x0

    move-object v3, p1

    .line 53
    invoke-static/range {v3 .. v9}, Lcom/taobao/tao/log/task/l;->b(Lcom/taobao/android/tlog/protocol/model/CommandInfo;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-object p0

    .line 58
    :cond_0
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object p1

    sget-object v3, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_HANDLE:Ljava/lang/String;

    iget-object v5, p0, Lcom/taobao/tao/log/task/m;->TAG:Ljava/lang/String;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v3, v5, v0}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 62
    invoke-direct {p0, v2}, Lcom/taobao/tao/log/task/m;->a([Lcom/taobao/android/tlog/protocol/model/request/base/LogFeature;)Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_1

    .line 63
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_1

    const-string v0, "application/x-tlog"

    .line 64
    invoke-static {v4, p1, v0}, Lcom/taobao/tao/log/task/b;->a(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    iget-object v0, p0, Lcom/taobao/tao/log/task/m;->TAG:Ljava/lang/String;

    const-string v1, "execute error"

    .line 67
    invoke-static {v0, v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 68
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object v0

    sget-object v1, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_HANDLE:Ljava/lang/String;

    iget-object v2, p0, Lcom/taobao/tao/log/task/m;->TAG:Ljava/lang/String;

    invoke-interface {v0, v1, v2, p1}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageError(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_1
    :goto_0
    const/4 p1, 0x0

    return-object p1
.end method
