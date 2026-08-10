.class public Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$1;
.super Ljava/lang/Object;
.source "OlympicPlugin.java"

# interfaces
.implements Lcom/taobao/monitor/olympic/plugins/strictmode/ViolationSubject$Observer;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->initOlympic(Landroid/content/Context;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation


# instance fields
.field public final synthetic this$0:Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;


# direct methods
.method public constructor <init>(Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$1;->this$0:Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;

    .line 73
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private createDetail(Lcom/taobao/monitor/olympic/ViolationError;)Ljava/lang/String;
    .locals 2

    .line 144
    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/ViolationError;->getStackTrace()Ljava/lang/String;

    move-result-object v0

    .line 145
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/ViolationError;->getMessage()Ljava/lang/String;

    move-result-object v0

    :cond_0
    return-object v0
.end method

.method private createKey(Lcom/taobao/monitor/olympic/ViolationError;)Ljava/lang/String;
    .locals 4

    .line 128
    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/ViolationError;->getExceptionMessage()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_0

    const-string v0, "UID"

    .line 130
    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 133
    :try_start_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    add-int/lit8 v2, v0, -0x1

    const/4 v3, 0x0

    invoke-virtual {p1, v3, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " UID XXXXX "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    add-int/lit8 v0, v0, 0x9

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 135
    invoke-static {v0}, Lcom/taobao/monitor/olympic/logger/Logger;->throwException(Ljava/lang/Throwable;)V

    :cond_0
    :goto_0
    return-object p1
.end method

.method private getErrorType(Ljava/lang/String;)I
    .locals 5

    .line 150
    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v0

    const/4 v1, 0x5

    const/4 v2, 0x4

    const/4 v3, 0x0

    const/4 v4, -0x1

    sparse-switch v0, :sswitch_data_0

    goto :goto_0

    :sswitch_0
    const-string v0, "HA_MAIN_THREAD_BLOCK"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    move v4, v1

    goto :goto_0

    :sswitch_1
    const-string v0, "HA_BIG_BITMAP"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_1

    goto :goto_0

    :cond_1
    move v4, v2

    goto :goto_0

    :sswitch_2
    const-string v0, "HA_MAIN_THREAD_IO"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_2

    goto :goto_0

    :cond_2
    const/4 v4, 0x3

    goto :goto_0

    :sswitch_3
    const-string v0, "HA_RESOURCE_LEAK"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_3

    goto :goto_0

    :cond_3
    const/4 v4, 0x2

    goto :goto_0

    :sswitch_4
    const-string v0, "HA_MEM_LEAK"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_4

    goto :goto_0

    :cond_4
    const/4 v4, 0x1

    goto :goto_0

    :sswitch_5
    const-string v0, "HA_SECURITY_GUARD"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_5

    goto :goto_0

    :cond_5
    move v4, v3

    :goto_0
    packed-switch v4, :pswitch_data_0

    move v1, v3

    goto :goto_1

    :pswitch_0
    const/4 v1, 0x7

    goto :goto_1

    :pswitch_1
    const/4 v1, 0x6

    goto :goto_1

    :pswitch_2
    const/16 v1, 0x9

    goto :goto_1

    :pswitch_3
    move v1, v2

    goto :goto_1

    :pswitch_4
    const/16 v1, 0xb

    :goto_1
    :pswitch_5
    return v1

    nop

    :sswitch_data_0
    .sparse-switch
        -0x12f94b34 -> :sswitch_5
        -0xa16dfcd -> :sswitch_4
        0x8eb282e -> :sswitch_3
        0x4cc8d07b -> :sswitch_2
        0x71f54c74 -> :sswitch_1
        0x7c9a48f8 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_5
    .end packed-switch
.end method

.method private violation2BizError(Lcom/taobao/monitor/olympic/ViolationError;)Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;
    .locals 5

    .line 92
    new-instance v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

    invoke-direct {v0}, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;-><init>()V

    .line 93
    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/ViolationError;->getType()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->businessType:Ljava/lang/String;

    .line 94
    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/ViolationError;->getType()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$1;->getErrorType(Ljava/lang/String;)I

    move-result v1

    iput v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->errorType:I

    .line 95
    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/ViolationError;->getThrowable()Ljava/lang/Throwable;

    move-result-object v1

    .line 96
    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/ViolationError;->getStackTrace()Ljava/lang/String;

    move-result-object v2

    if-nez v1, :cond_0

    .line 97
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 98
    sget-object v2, Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;->CONTENT:Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    iput-object v2, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->aggregationType:Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    goto :goto_0

    .line 100
    :cond_0
    sget-object v2, Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;->STACK:Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    iput-object v2, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->aggregationType:Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    .line 103
    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->businessType:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionId:Ljava/lang/String;

    .line 104
    invoke-direct {p0, p1}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$1;->createKey(Lcom/taobao/monitor/olympic/ViolationError;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionCode:Ljava/lang/String;

    if-nez v1, :cond_1

    .line 106
    invoke-direct {p0, p1}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$1;->createDetail(Lcom/taobao/monitor/olympic/ViolationError;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionDetail:Ljava/lang/String;

    .line 109
    :cond_1
    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->throwable:Ljava/lang/Throwable;

    const/4 v1, 0x0

    .line 110
    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->thread:Ljava/lang/Thread;

    const-string v1, "1.0.0"

    .line 111
    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionVersion:Ljava/lang/String;

    const-string v1, "arg1"

    .line 112
    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionArg1:Ljava/lang/String;

    const-string v1, "arg2"

    .line 113
    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionArg2:Ljava/lang/String;

    const-string v1, "arg3"

    .line 114
    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionArg3:Ljava/lang/String;

    .line 116
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    iget-object v2, p0, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$1;->this$0:Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;

    .line 117
    invoke-static {v2}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->access$100(Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;)Ljava/util/Map;

    move-result-object v2

    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/ViolationError;->getType()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;

    if-eqz p1, :cond_2

    .line 120
    iget-object p1, p1, Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;->sampling_rate:Ljava/lang/String;

    goto :goto_1

    :cond_2
    const-string p1, "[1,1]"

    :goto_1
    const-string v2, "sample_ratio"

    .line 122
    invoke-interface {v1, v2, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 123
    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->args:Ljava/util/Map;

    return-object v0
.end method


# virtual methods
.method public onViolation(Lcom/taobao/monitor/olympic/ViolationError;)V
    .locals 8

    iget-object v0, p0, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$1;->this$0:Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;

    .line 77
    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/ViolationError;->getType()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->access$000(Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;Ljava/lang/String;)Z

    move-result v0

    const-string v1, "default [1, 1]"

    const-string v2, ", sample rate: "

    const/4 v3, 0x0

    const/4 v4, 0x1

    const-string v5, "OlympicPlugin"

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$1;->this$0:Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;

    .line 78
    invoke-static {v0}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->access$100(Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;)Ljava/util/Map;

    move-result-object v0

    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/ViolationError;->getType()Ljava/lang/String;

    move-result-object v6

    invoke-interface {v0, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;

    new-array v4, v4, [Ljava/lang/Object;

    .line 79
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "not hit sample, type: "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/ViolationError;->getType()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    if-eqz v0, :cond_0

    iget-object v1, v0, Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;->sampling_rate:Ljava/lang/String;

    :cond_0
    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    aput-object p1, v4, v3

    invoke-static {v5, v4}, Lcom/taobao/monitor/olympic/logger/Logger;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    :cond_1
    iget-object v0, p0, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$1;->this$0:Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;

    .line 83
    invoke-static {v0}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;->access$100(Lcom/alibaba/ha/adapter/plugin/OlympicPlugin;)Ljava/util/Map;

    move-result-object v0

    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/ViolationError;->getType()Ljava/lang/String;

    move-result-object v6

    invoke-interface {v0, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;

    new-array v4, v4, [Ljava/lang/Object;

    .line 84
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "hit sample, type: "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Lcom/taobao/monitor/olympic/ViolationError;->getType()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-eqz v0, :cond_2

    iget-object v1, v0, Lcom/alibaba/ha/adapter/service/olympic/OlympicSamplingRate;->sampling_rate:Ljava/lang/String;

    :cond_2
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v4, v3

    invoke-static {v5, v4}, Lcom/taobao/monitor/olympic/logger/Logger;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 86
    invoke-static {}, Lcom/taobao/monitor/olympic/common/Global;->instance()Lcom/taobao/monitor/olympic/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/olympic/common/Global;->context()Landroid/content/Context;

    move-result-object v0

    .line 87
    invoke-direct {p0, p1}, Lcom/alibaba/ha/adapter/plugin/OlympicPlugin$1;->violation2BizError(Lcom/taobao/monitor/olympic/ViolationError;)Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

    move-result-object p1

    .line 88
    invoke-static {}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->getInstance()Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;

    move-result-object v1

    invoke-virtual {v1, v0, p1}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->send(Landroid/content/Context;Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;)V

    return-void
.end method
