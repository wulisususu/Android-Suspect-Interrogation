.class public Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;
.super Ljava/lang/Object;
.source "TLogPlugin.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/ha/adapter/plugin/TLogPlugin;->start(Lcom/alibaba/ha/protocol/AliHaParam;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation


# instance fields
.field public final synthetic this$0:Lcom/alibaba/ha/adapter/plugin/TLogPlugin;

.field public final synthetic val$aliHaParam:Lcom/alibaba/ha/protocol/AliHaParam;

.field public final synthetic val$appId:Ljava/lang/String;

.field public final synthetic val$appKey:Ljava/lang/String;

.field public final synthetic val$appSecret:Ljava/lang/String;

.field public final synthetic val$appVersion:Ljava/lang/String;

.field public final synthetic val$application:Landroid/app/Application;

.field public final synthetic val$context:Landroid/content/Context;

.field public final synthetic val$userNick:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lcom/alibaba/ha/adapter/plugin/TLogPlugin;Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Landroid/app/Application;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/alibaba/ha/protocol/AliHaParam;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->this$0:Lcom/alibaba/ha/adapter/plugin/TLogPlugin;

    iput-object p2, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$context:Landroid/content/Context;

    iput-object p3, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$appKey:Ljava/lang/String;

    iput-object p4, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$appVersion:Ljava/lang/String;

    iput-object p5, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$application:Landroid/app/Application;

    iput-object p6, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$appSecret:Ljava/lang/String;

    iput-object p7, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$userNick:Ljava/lang/String;

    iput-object p8, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$appId:Ljava/lang/String;

    iput-object p9, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$aliHaParam:Lcom/alibaba/ha/protocol/AliHaParam;

    .line 61
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 10

    iget-object v0, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$context:Landroid/content/Context;

    .line 64
    invoke-static {v0}, Lcom/ut/device/UTDevice;->getUtdid(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$context:Landroid/content/Context;

    .line 66
    invoke-static {v1}, Lcom/alibaba/sdk/android/tbrest/utils/AppUtils;->getMyProcessNameByAppProcessInfo(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_0

    const-string v1, "DEFAULT"

    :cond_0
    move-object v6, v1

    .line 71
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "init tlog, appKey is "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$appKey:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " appVersion is "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$appVersion:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " namePrefix is "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v9, "AliHaAdapter"

    invoke-static {v9, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 75
    :try_start_0
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v2

    iget-object v3, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$context:Landroid/content/Context;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v4, 0x0

    const-string v5, "logs"

    :try_start_1
    iget-object v7, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$appKey:Ljava/lang/String;

    iget-object v8, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$appVersion:Ljava/lang/String;

    invoke-virtual/range {v2 .. v8}, Lcom/taobao/tao/log/TLogInitializer;->builder(Landroid/content/Context;Lcom/taobao/tao/log/LogLevel;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$application:Landroid/app/Application;

    .line 77
    invoke-virtual {v1, v2}, Lcom/taobao/tao/log/TLogInitializer;->setApplication(Landroid/app/Application;)Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$appSecret:Ljava/lang/String;

    .line 78
    invoke-virtual {v1, v2}, Lcom/taobao/tao/log/TLogInitializer;->setSecurityKey(Ljava/lang/String;)Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$userNick:Ljava/lang/String;

    .line 79
    invoke-virtual {v1, v2}, Lcom/taobao/tao/log/TLogInitializer;->setUserNick(Ljava/lang/String;)Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    .line 80
    invoke-virtual {v1, v0}, Lcom/taobao/tao/log/TLogInitializer;->setUtdid(Ljava/lang/String;)Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$appId:Ljava/lang/String;

    .line 81
    invoke-virtual {v0, v1}, Lcom/taobao/tao/log/TLogInitializer;->setAppId(Ljava/lang/String;)Lcom/taobao/tao/log/TLogInitializer;

    iget-object v0, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$aliHaParam:Lcom/alibaba/ha/protocol/AliHaParam;

    .line 82
    iget-wide v0, v0, Lcom/alibaba/ha/protocol/AliHaParam;->tlogFileMaxSize:J

    const-wide/16 v2, 0x64

    cmp-long v0, v0, v2

    if-gez v0, :cond_1

    iget-object v0, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$aliHaParam:Lcom/alibaba/ha/protocol/AliHaParam;

    iget-wide v0, v0, Lcom/alibaba/ha/protocol/AliHaParam;->tlogFileMaxSize:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_1

    .line 83
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$aliHaParam:Lcom/alibaba/ha/protocol/AliHaParam;

    iget-wide v1, v1, Lcom/alibaba/ha/protocol/AliHaParam;->tlogFileMaxSize:J

    invoke-virtual {v0, v1, v2}, Lcom/taobao/tao/log/TLogInitializer;->setLogFileMaxSize(J)Lcom/taobao/tao/log/TLogInitializer;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 87
    :cond_1
    :try_start_2
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;->val$aliHaParam:Lcom/alibaba/ha/protocol/AliHaParam;

    iget v1, v1, Lcom/alibaba/ha/protocol/AliHaParam;->noCollectionDataType:I

    invoke-virtual {v0, v1}, Lcom/taobao/tao/log/TLogInitializer;->setNoCollectionDataType(I)Lcom/taobao/tao/log/TLogInitializer;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 91
    :catchall_0
    :try_start_3
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->init()Lcom/taobao/tao/log/TLogInitializer;

    .line 94
    new-instance v0, Lcom/taobao/tao/log/monitor/DefaultTLogMonitorImpl;

    invoke-direct {v0}, Lcom/taobao/tao/log/monitor/DefaultTLogMonitorImpl;-><init>()V

    .line 95
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/taobao/tao/log/TLogInitializer;->settLogMonitor(Lcom/taobao/tao/log/monitor/TLogMonitor;)Lcom/taobao/tao/log/TLogInitializer;

    .line 98
    new-instance v0, Lcom/taobao/android/tlog/uploader/TLogUploader;

    invoke-direct {v0}, Lcom/taobao/android/tlog/uploader/TLogUploader;-><init>()V

    .line 99
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/taobao/tao/log/TLogInitializer;->setLogUploader(Lcom/taobao/tao/log/upload/LogUploader;)Lcom/taobao/tao/log/TLogInitializer;

    .line 102
    new-instance v0, Lcom/taobao/android/tlog/message/TLogMessage;

    invoke-direct {v0}, Lcom/taobao/android/tlog/message/TLogMessage;-><init>()V

    .line 103
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/taobao/tao/log/TLogInitializer;->setMessageSender(Lcom/taobao/tao/log/message/MessageSender;)Lcom/taobao/tao/log/TLogInitializer;

    const/4 v0, 0x1

    .line 113
    invoke-static {v0}, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$Service;->access$002(Z)Z
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v1, "param is unlegal, tlog plugin start failure "

    .line 115
    invoke-static {v9, v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_0
    return-void
.end method
